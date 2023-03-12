import 'package:flutter/material.dart';
import 'package:json_projects/LocalPostBody.dart';

class LocalComments extends StatefulWidget {
  const LocalComments({Key? key}) : super(key: key);

  @override
  State<LocalComments> createState() => _LocalCommentsState();
}

class _LocalCommentsState extends State<LocalComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("Comments")),
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
          ListView.builder(
              itemCount: LocalPost.mycomnts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Color(0xff6b0d21).withOpacity(0.5),
                    child: Container(
                      child: ListTile(
                        title: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                "${LocalPost.mycomnts[index]["name"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                "${LocalPost.mycomnts[index]["email"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "${LocalPost.mycomnts[index]["body"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
