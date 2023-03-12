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
        backgroundColor: Color(0xff6b0d21).withOpacity(0.60),
        title: Center(child: Text("Login Screen")),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/bg4.jpg"),
            fit: BoxFit.cover,
            // color: Colors.black12,
            // colorBlendMode: BlendMode.darken,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Color(0xFFB74093).withOpacity(0.5),
                margin: EdgeInsets.all(10),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff6b0d21), width: 3.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 10, color: Colors.black),
                      ),
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: Colors.black87,
                      floatingLabelStyle: TextStyle(color: Colors.black87),
                      label: Text(
                        "User Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                  color: Color(0xFFB74093).withOpacity(0.5),
                  margin: EdgeInsets.all(10),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff6b0d21), width: 3.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 5, color: Colors.black87),
                        ),
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Colors.black87,
                        floatingLabelStyle: TextStyle(color: Colors.black87),
                        label: Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6b0d21).withOpacity(0.60)),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocalPost()));
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
                      }
                    });
                  },
                  child: Text("Login")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6b0d21).withOpacity(0.60)),
                  onPressed: () {
                    setState(() {
                      addData();
                    });
                  },
                  child: Text("Add Data"))
            ],
          ),
        ],
      ),
    );
  }
}
