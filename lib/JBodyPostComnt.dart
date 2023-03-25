import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_projects/JsonComents.dart';

import 'JLoginPostComnt.dart';

void main() {
  // runApp(MaterialApp(home: JsonBody()));
}

class JsonBody extends StatefulWidget {
  static List mycomnts = [];
  @override
  State<JsonBody> createState() => _JsonBodyState();
}

class _JsonBodyState extends State<JsonBody> {
  List postDataJson = [];
  List myUserPost = [];
  List comntDataJson = [];

  Future getUserPost() async {
    http.Response postResponse =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (postResponse.statusCode == 200) {
      postDataJson = jsonDecode(postResponse.body);
      print("UserId: ${JsonLogin.myUserList[0]['id']}");
      for (int i = 0; i < postDataJson.length; i++) {
        if (postDataJson[i]["userId"] == JsonLogin.myUserList[0]['id']) {
          myUserPost!.add(postDataJson[i]);
          print(myUserPost);
        }
      }
      return myUserPost;
    }
    return myUserPost;
  }

  Future getUserComnt() async {
    http.Response comntResponse = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
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
        backgroundColor: Colors.purple[200],
        title: Center(child: Text("Posts")),
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
                        color: Colors.white60,
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
                                        backgroundImage:
                                            AssetImage("assets/images/1.jpg"),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          // padding: EdgeInsets.all(5),
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          child: Text(
                                            " ${JsonLogin.myUserList[0]["name"]}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            alignment:
                                                AlignmentDirectional.topStart,
                                            child: Text(
                                              " ${JsonLogin.myUserList[0]["username"]}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              alignment: AlignmentDirectional.topCenter,
                              child: Text(
                                " ${userPost.data[index]["title"]}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              alignment: AlignmentDirectional.topCenter,
                              child: Text(
                                "${userPost.data[index]["body"]}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
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
                                          if (userPost.data[index]["userId"] ==
                                              comntDataJson[i]["postId"]) {
                                            JsonBody.mycomnts
                                                .add(comntDataJson[i]);
                                            print("${JsonBody.mycomnts}");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyComments()));
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
            },
          ),
        ],
      ),
    );
  }
}
