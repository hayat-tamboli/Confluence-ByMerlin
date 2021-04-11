import "package:flutter/material.dart";
import 'package:merlin/profile%20page/editProfile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GestureDetector(
              child: Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 40.0),
            CircleAvatar(
              radius: 80.0,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100.0))),
            ),
            SizedBox(height: 20.0),
            Text(
              "Hayat Tamboli",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20.0),
            Text(
              "VIT' 23",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/google.png", height: 50.0, width: 50.0),
                Image.asset("assets/linkedin.png", height: 50.0, width: 50.0),
                Image.asset("assets/twitter.png", height: 50.0, width: 50.0),
              ],
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                Container(
                  width: 100.0,
                  child: Center(child: Text("Java")),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(width: 20.0),
                Container(
                  width: 70.0,
                  child: Center(child: Text("C++")),
                  decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(width: 20.0),
                Container(
                  width: 100.0,
                  child: Center(child: Text("Flask")),
                  decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                Container(
                  width: 100.0,
                  child: Center(child: Text("Flutter")),
                  decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(width: 20.0),
                Container(
                  width: 100.0,
                  child: Center(child: Text("Firebase")),
                  decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(width: 20.0),
                Container(
                  width: 100.0,
                  child: Center(child: Text("Javascript")),
                  decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
