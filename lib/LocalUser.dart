import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: LocalUser()));
}

class LocalUser extends StatefulWidget {
  const LocalUser({Key? key}) : super(key: key);

  @override
  State<LocalUser> createState() => _LocalUserState();
}

class _LocalUserState extends State<LocalUser> {
  List userDataJson = [];
  Future getUserData() async {
    http.Response userResponse =
        //     await http.get(Uri.parse("http://10.0.2.2:3000/users"));
        await http.get(Uri.parse("http://localhost:3000/users"));
    if (userResponse.statusCode == 200) {
      setState(() {
        userDataJson = jsonDecode(userResponse.body);
      });
      return userDataJson;
    }
    return userDataJson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getUserData(),
          builder: (_, myuser) {
            if (myuser.hasData) {
              return ListView.builder(
                itemCount: userDataJson.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.black12,
                    child: ListTile(
                      leading: Text("${userDataJson[index]["id"]}"),
                      title: Text("${userDataJson[index]["username"]}"),
                      subtitle: Text("${userDataJson[index]["email"]}"),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
