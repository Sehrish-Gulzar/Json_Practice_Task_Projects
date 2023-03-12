import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() async {
//   http.Response response =
//       await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
//   if (response.statusCode == 200) {
//     List myJsonData = jsonDecode(response.body);
//     for (int i = 0; i < myJsonData.length; i++) {
//       print("${myJsonData[i]["id"]} ${myJsonData[i]["title"]}  ");
//       print("******************************");
//     }
//   }
// }
// void main() async {
//   http.Response response =
//       await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
//   if (response.statusCode == 200) {
//     List myJsonData = jsonDecode(response.body);
//     for (int i = 0; i < myJsonData.length; i++) {
//       print(
//           "Id: ${myJsonData[i]["id"]}\nName: ${myJsonData[i]["name"]}\nAddress: ${myJsonData[i]["address"]}\nAddress(street): ${myJsonData[i]["address"]["street"]} ");
//       print("********************************************************");
//     }
//   }
// }
void main() {
  runApp(MaterialApp(home: JsonDataDemo()));
}

class JsonDataDemo extends StatefulWidget {
  @override
  State<JsonDataDemo> createState() => _JsonDataDemoState();
}

class _JsonDataDemoState extends State<JsonDataDemo> {
  List userData = [];
  void getData() async {
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            color: Colors.black12,
            child: ListTile(
              leading: Text("${userData[index]["id"]}"),
              title: Text("${userData[index]["name"]}"),
              subtitle: Text("${userData[index]["email"]}"),
            ),
          );
        },
      ),
    );
  }
}
