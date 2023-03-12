import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'JHome.dart';

void main() {
  runApp(MaterialApp(home: JsonLogin()));
}

class JsonLogin extends StatefulWidget {
  static List myUserList = [];

  @override
  State<JsonLogin> createState() => _JsonLoginState();
}

class _JsonLoginState extends State<JsonLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  var email;
  var username;
  List userDataJson = [];

  void getUserData() async {
    http.Response userResponse =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (userResponse.statusCode == 200) {
      setState(() {
        userDataJson = jsonDecode(userResponse.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Center(child: Text("Login Screen")),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: new AssetImage("assets/images/bg1.jpg"),
            fit: BoxFit.cover,
            // color: Colors.black12,
            // colorBlendMode: BlendMode.darken,
          ),
          Column(
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
                      prefixIcon: Icon(Icons.person),
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
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[500]),
                  onPressed: () {
                    bool isTrue = false;
                    setState(() {
                      username = userController.text;
                      email = emailController.text;
                      for (int i = 0; i < userDataJson.length; i++) {
                        if (userDataJson[i]["username"] == username &&
                            userDataJson[i]["email"] == email) {
                          isTrue = true;
                          JsonLogin.myUserList.add(userDataJson[i]);
                          // print(JsonLogin.myUseList);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => JHome()));

                          break;
                        }
                        if (userDataJson[i]["username"] != username &&
                            userDataJson[i]["email"] != email &&
                            isTrue == false) {
                          setState(() {
                            var snackBar = SnackBar(
                                content: Text("Invalid password or email"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        }
                        // if (isTrue == false) {
                        //   setState(() {
                        //     var snackBar = SnackBar(
                        //         content: Text("Invalid password or email"));
                        //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //   });
                        // }
                      }
                    });
                  },
                  child: Text("Login"))
            ],
          ),
        ],
      ),
    );
  }
}
