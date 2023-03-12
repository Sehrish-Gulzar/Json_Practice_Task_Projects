import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: JsonDataDemo()));
}

class JsonDataDemo extends StatefulWidget {
  @override
  State<JsonDataDemo> createState() => _JsonDataDemoState();
}

class _JsonDataDemoState extends State<JsonDataDemo> {
  Future<List> getData() async {
    List userData = [];
    await Future.delayed(Duration(seconds: 5));
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      userData = jsonDecode(response.body);
      return userData;
    }
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (_, userData) {
            if (userData.hasData) {
              return ListView.builder(
                  itemCount: userData.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.black12,
                      child: ListTile(
                        leading: Text("${userData.data![index]["id"]}"),
                        title: Text("${userData.data![index]["name"]}"),
                        subtitle: Text("${userData.data![index]["email"]}"),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
