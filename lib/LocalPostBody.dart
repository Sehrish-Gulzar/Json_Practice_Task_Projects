import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_projects/LocalUserLogin.dart';

import 'LocalComnt.dart';

void main() {
  // runApp(MaterialApp(home: JsonBody()));
}

class LocalPost extends StatefulWidget {
  static List mycomnts = [];
  @override
  State<LocalPost> createState() => _LocalPostState();
}

class _LocalPostState extends State<LocalPost> {
  List postDataJson = [];
  List myUserPost = [];
  List comntDataJson = [];

  Future getUserPost() async {
    http.Response postResponse =
        await http.get(Uri.parse("http://localhost:3000/Posts"));
    if (postResponse.statusCode == 200) {
      postDataJson = jsonDecode(postResponse.body);
      print("UserId: ${LocalLogin.myUserList}");
      for (int i = 0; i < postDataJson.length; i++) {
        if (postDataJson[i]["userId"] == LocalLogin.myUserList[0]['id']) {
          myUserPost!.add(postDataJson[i]);
          // print(myUserPost);
        }
      }
      return myUserPost;
    }
    return myUserPost;
  }

  Future getUserComnt() async {
    http.Response comntResponse =
        await http.get(Uri.parse("http://localhost:3000/Comments"));
    if (comntResponse.statusCode == 200) {
      comntDataJson = jsonDecode(comntResponse.body);
      return comntDataJson;
    }
    return comntDataJson;
  }

  @override
  Widget build(BuildContext context) {
    getUserPost();
    getUserComnt();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff6b0d21).withOpacity(0.60),
          title: Center(child: Text("Posts")),
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
            FutureBuilder(
                future: getUserPost(),
                builder: (_, userPost) {
                  if (userPost.hasData) {
                    return ListView.builder(
                      itemCount: userPost.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Color(0xff6b0d21).withOpacity(0.5),
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: AlignmentDirectional.topStart,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                "assets/images/2.jpg"),
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            alignment:
                                                AlignmentDirectional.topStart,
                                            child: Text(
                                              " ${LocalLogin.myUserList[0]["username"]}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ],
                                    )),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Text(
                                    " ${userPost.data[index]["title"]}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Text(
                                    "${userPost.data[index]["body"]}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.thumb_up),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            for (int i = 0;
                                                i < userPost.data.length;
                                                i++) {
                                              if (userPost.data[index]
                                                      ["userId"] ==
                                                  comntDataJson[i]["postId"]) {
                                                LocalPost.mycomnts
                                                    .add(comntDataJson[i]);
                                                print("${LocalPost.mycomnts}");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LocalComments()));
                                              }
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.comment),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.share),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ));
  }
}
