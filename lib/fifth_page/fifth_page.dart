import 'dart:convert';

import 'package:api_calling_demo/sixth_page/sixth_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class fifth_page extends StatefulWidget {
  const fifth_page({Key? key}) : super(key: key);

  @override
  State<fifth_page> createState() => _fifth_pageState();
}

class _fifth_pageState extends State<fifth_page> {
  List l = [];

  Future<List> getData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');

      l = jsonDecode(response.body);
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("5_API_Calling"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List l = snapshot.data as List;
              if (l.isNotEmpty) {
                return Scrollbar(
                    child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    Map map = l[index];

                    User user = User.fromJson(map);

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text("${user.id}"),
                      ),
                      title: Text("${user.title}"),
                      subtitle: Text("${user.url}"),
                    );
                  },
                ));
              } else {
                return Center(child: const Text("NO DATA FOUND"));
              }
            }
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const sixth_page();
              },
            ),
          );
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class User {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  User({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  User.fromJson(Map json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
