import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class seventh_page extends StatefulWidget {
  const seventh_page({Key? key}) : super(key: key);

  @override
  State<seventh_page> createState() => _seventh_pageState();
}

class _seventh_pageState extends State<seventh_page> {
  List l = [];
  // Future<List> getData() async {
  //   int val = 2;
  //
  //   var url = Uri.parse(
  //       'https://jsonplaceholder.typicode.com/users?id=1&id=$val&id=4');
  //   var response = await http.get(url);
  //   print('Response status: ${response.statusCode}');
  //
  //   if (response.statusCode == 200) {
  //     // print('Response body: ${response.body}');
  //
  //     l = jsonDecode(response.body);
  //   }
  //   return l;
  // }

  Future<List> getData() async {
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');

    l = response.data;

    print(l);

    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("7_API_Calling"), centerTitle: true),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List l = snapshot.data as List;

              if (l.isNotEmpty) {
                return Scrollbar(
                    child: ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    Map m = l[index];

                    User user = User.fromJson(m);

                    return Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(child: Text("${user.id}")),
                            const SizedBox(
                              height: 2,
                            ),
                            const Text('Name : '),
                            Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: Text("${user.name}"),
                            ),
                            const Text('email : '),
                            Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: Text("${user.email}"),
                            ),
                            const Text('Address : '),
                            Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Street : ${user.address!.street}"),
                                  Text("suite : ${user.address!.suite}"),
                                  Text("city :  ${user.address!.city}"),
                                  const Text("Geo : "),
                                  Container(
                                      margin: const EdgeInsets.only(left: 40),
                                      child: Text(
                                          "lat : ${user.address!.geo!.lat}")),
                                  Container(
                                      margin: const EdgeInsets.only(left: 40),
                                      child: Text(
                                          "lng : ${user.address!.geo!.lng}")),
                                ],
                              ),
                            ),
                            const Text('Phone : '),
                            Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: Text("${user.phone}"),
                            ),
                            const Text('Website : '),
                            Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: Text("${user.website}"),
                            ),
                            const Text('Company : '),
                            Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name : ${user.company!.name}"),
                                  Text(
                                      "catchPhrase : ${user.company!.catchPhrase}"),
                                  Text("bs : ${user.company!.bs}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ));
              } else {
                return const Center(
                  child: Text("NO DATA FOUND"),
                );
              }
            }
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  User.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['phone'] = this.phone;
    data['website'] = this.website;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo!.toJson();
    }
    return data;
  }
}

class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['catchPhrase'] = this.catchPhrase;
    data['bs'] = this.bs;
    return data;
  }
}
