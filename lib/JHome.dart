import 'package:flutter/material.dart';
import 'package:json_projects/JLoginPostComnt.dart';

import 'JBodyPostComnt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JHome(),
    );
  }
}

class JHome extends StatefulWidget {
  @override
  State<JHome> createState() => _JHomeState();
}

class _JHomeState extends State<JHome> {
  int currentIndex = 0;
  List<Widget> listOfWidgets = [
    JsonBody(),
    // Customer(),
    // ContactUs(),
    // Product_list(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          "Posts",
        )),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                children: [
                  Text(
                    "Galaxy Cosmetic Store",
                    style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Name: ${JsonLogin.myUserList[0]["name"]}"),
                  Text("Email: ${JsonLogin.myUserList[0]["email"]}"),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("All Products"),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ecommerce()));
                // setState(() {
                //   this.currentIndex = 2;
                // });
              },
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart_rounded),
              title: Text("Products"),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ecommerce()));
                // setState(() {
                //   this.currentIndex = 0;
                // });
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Customer"),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Customer()));
                // setState(() {
                //   this.currentIndex = 1;
                // });
              },
            ),
            ListTile(
              leading: Icon(Icons.ad_units),
              title: Text("Signout"),
            ),
          ],
        ),
      ),
      body: Center(child: listOfWidgets[currentIndex]),
    );
  }
}
