import 'package:flutter/material.dart';
import 'package:json_projects/JBodyPostComnt.dart';

class MyComments extends StatefulWidget {
  const MyComments({Key? key}) : super(key: key);

  @override
  State<MyComments> createState() => _MyCommentsState();
}

class _MyCommentsState extends State<MyComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("Comments")),
      ),
      body: ListView.builder(
          itemCount: JsonBody.mycomnts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Colors.white60,
                child: Container(
                  child: ListTile(
                    title: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            "${JsonBody.mycomnts[index]["name"]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            "${JsonBody.mycomnts[index]["email"]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "${JsonBody.mycomnts[index]["body"]}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
