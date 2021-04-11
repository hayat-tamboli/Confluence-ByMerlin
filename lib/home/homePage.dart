import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:merlin/home/hackathonDetailsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hackathons", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Feather.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) {
            return ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HackDetailPage()));
              },
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              leading: Image.asset("assets/auth page.png"),
              title: Text("hackathon name"),
              subtitle: Text("12 april 2021"),
              trailing: Icon(Feather.chevron_right),
            );
          },
        ),
      ),
    );
  }
}
