import 'dart:convert';

import 'package:api_calling_demo/seventh_page/seventh_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class sixth_page extends StatefulWidget {
  const sixth_page({Key? key}) : super(key: key);

  @override
  State<sixth_page> createState() => _sixth_pageState();
}

class _sixth_pageState extends State<sixth_page> {
  List l = [];
  Future<List> getData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
//        print('Response body: ${response.body}');
      l = jsonDecode(response.body);
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("6_API_Calling"),
        centerTitle: true,
      ),
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
                      Map map = l[index];

                      User user = User.fromJson(map);
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text("${user.id}"),
                        ),
                        title: Text("${user.title}", maxLines: 1),
                        subtitle: Text("${user.completed}"),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const seventh_page();
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
  int? userId;
  int? id;
  String? title;
  bool? completed;

  User({this.userId, this.id, this.title, this.completed});

  User.fromJson(Map json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}
