import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_projects/LocalPostBody.dart';

void main() {
  runApp(MaterialApp(home: LocalLogin()));
}

class LocalLogin extends StatefulWidget {
  static List myUserList = [];

  @override
  State<LocalLogin> createState() => _LocalLoginState();
}

class _LocalLoginState extends State<LocalLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  var email;
  var username;
  List userDataJson = [];
  bool isTrue = false;

  void getUserData() async {
    http.Response userResponse =
        await http.get(Uri.parse("http://localhost:3000/Users"));
    if (userResponse.statusCode == 200) {
      setState(() {
        userDataJson = jsonDecode(userResponse.body);
      });
    }
  }

  void addData() async {
    await http.post(Uri.parse("http://localhost:3000/Users"),
        body: {"username": userController.text, "email": emailController.text});
    var snackBar =
        SnackBar(content: Center(child: Text("Data Added Successfully")));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Login Screen")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: userController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  label: Text("User Name"),
                ),
              ),
            ),
          ),
          Card(
              margin: EdgeInsets.all(10),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    label: Text("Email"),
                  ),
                ),
              )),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  username = userController.text;
                  email = emailController.text;
                  for (int i = 0; i < userDataJson.length; i++) {
                    if (userDataJson[i]["username"] == username &&
                        userDataJson[i]["email"] == email) {
                      isTrue = true;
                      print("${userDataJson[i]}");
                      LocalLogin.myUserList.add(userDataJson[i]);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LocalPost()));
                      break;
                    }
                    if (userDataJson[i]["username"] != username &&
                        userDataJson[i]["email"] != email &&
                        isTrue == false) {
                      setState(() {
                        var snackBar = SnackBar(
                            content: Text("Invalid password or email"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                  }
                });
              },
              child: Text("Login")),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  addData();
                });
              },
              child: Text("Add Data"))
        ],
      ),
    );
  }
}
