import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../forth_page/forth_page.dart';

class third_page extends StatefulWidget {
  const third_page({Key? key}) : super(key: key);

  @override
  State<third_page> createState() => _third_pageState();
}

class _third_pageState extends State<third_page> {
  List l = [];

  Future<List> getdata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      //print('Response body: ${response.body}');

      l = jsonDecode(response.body);
    }

    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("3_API_Calling"),
      ),
      body: FutureBuilder(
        future: getdata(),
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
                      leading: CircleAvatar(child: Text("${user.id}")),
                      title: Text("${user.title}"),
                    );
                  },
                ));
              }
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const forth_page();
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

  User({this.userId, this.id, this.title});

  User.fromJson(Map json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
