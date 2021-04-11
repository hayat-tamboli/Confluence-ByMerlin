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
          // child: ListView.separated(
          //   separatorBuilder: (_, index) {
          //     return Divider();
          //   },
          //   itemCount: 10,
          //   itemBuilder: (_, index) {
          //     return ListTile(
          //       onTap: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => HackDetailPage()));
          //       },
          //       contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          //       leading: ClipRRect(
          //         borderRadius: BorderRadius.circular(8.0),
          //         child: Image.asset("assets/placeholder.png"),
          //       ),
          //       title: Text("hackathon name"),
          //       subtitle: Text("12 april 2021"),
          //       trailing: Icon(Feather.chevron_right),
          //     );
          //   },
          // ),
          child: ListView(children: [
        ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HackDetailPage()));
          },
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network("https://hackofiesta-iiitl.tech/img/logo.png"),
          ),
          title: Text("HACKOFIESTA"),
          subtitle: Text("16 april 2021 - 18 april 2021"),
          trailing: Icon(Feather.chevron_right),
        ),
        ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HackDetailPage()));
          },
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
                "https://hackthespace.netlify.app/assets/img/logo111.PNG"),
          ),
          title: Text("Hack The Space 🚀"),
          subtitle: Text("17 april 2021 - 19 april 2021"),
          trailing: Icon(Feather.chevron_right),
        ),
      ])),
    );
  }
}
