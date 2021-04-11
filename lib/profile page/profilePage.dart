import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:merlin/profile%20page/editProfile.dart';
import 'package:merlin/utils/Constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final db = FirebaseFirestore.instance;
  StreamSubscription sub;
  Map data;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    sub = db
        .collection('users')
        .doc(Constants.prefs.getString('userId'))
        .snapshots()
        .listen((snap) {
      setState(() {
        data = snap.data();
        loading = true;
      });
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                child: Icon(Feather.settings),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
              ),
            )
          ],
        ),
        body: loading
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 64.0,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0))),
                      backgroundImage: AssetImage("assets/placeholder.png"),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      data['name'],
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      "class of  2023",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Feather.github),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Feather.linkedin),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Feather.twitter),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          Chip(label: Text("UI/UX designer")),
                          Chip(label: Text("JavaScript")),
                          Chip(label: Text("C++")),
                          Chip(label: Text("React")),
                          Chip(label: Text("Flutter")),
                          Chip(label: Text("Vue")),
                          Chip(label: Text("Python")),
                          Chip(label: Text("HTML")),
                          Chip(label: Text("CSS")),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: CircularProgressIndicator(),
              ));
  }
}
