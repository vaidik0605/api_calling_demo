import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../second_page/second_page.dart';

class first_page extends StatefulWidget {
  const first_page({Key? key}) : super(key: key);

  @override
  State<first_page> createState() => _first_pageState();
}

class _first_pageState extends State<first_page> {
  bool status = false;
  List l = [];

  // Future<List> getData() async {
  //   var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
  //   var response = await http.get(url);
  //   print('Response status: ${response.statusCode}');
  //   if (response.statusCode == 200) {
  //     // print('Response body: ${response.body}');
  //     l = jsonDecode(response.body);
  //   }
  //   return l;
  // }

  Future<List> getData() async {
    var response = await Dio()
        .get('https://jsonplaceholder.typicode.com/comments?postId=5&postId=2');

    l = response.data;
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("1_API_Calling"),
      ),
      // body: (status)
      //     ? (l.length > 0
      //         ? Scrollbar(
      //             radius: Radius.circular(10),
      //             child: ListView.builder(
      //               itemCount: l.length,
      //               itemBuilder: (context, index) {
      //                 Map m = l[index];
      //
      //                 User user = User.fromJson(m);
      //
      //                 return ListTile(
      //                   leading: Text("${user.id}"),
      //                   title: Text("${user.name}"),
      //                   subtitle: Text("${user.email}"),
      //                 );
      //               },
      //             ),
      //           )
      //         : Center(
      //             child: Text("NO DATA FOUND"),
      //           ))
      //     : Center(
      //         child: CircularProgressIndicator(),
      //       ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List l = snapshot.data as List;
              if (l.isNotEmpty) {
                return RawScrollbar(
                  thumbColor: Colors.blue[800],
                  trackVisibility: true,
                  radius: Radius.circular(10),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      Map m = l[index];
                      User user = User.fromJson(m);

                      return ListTile(
                        leading: CircleAvatar(child: Text("${user.id}")),
                        title: Text("${user.name}"),
                        subtitle: Text("${user.email}"),
                        trailing: CircleAvatar(child: Text("${user.postId}")),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text("NO DATA FOUND"),
                );
              }
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return second_page();
            },
          ));
        },
      ),
    );
  }
}

class User {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  User({this.postId, this.id, this.name, this.email, this.body});

  User.fromJson(Map json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}
