import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:merlin/widgets/primaryBtn.dart';

class HackDetailPage extends StatefulWidget {
  @override
  _HackDetailPageState createState() => _HackDetailPageState();
}

class _HackDetailPageState extends State<HackDetailPage> {
  String _userType = "hacker";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          "Hackathon Name",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset("assets/auth page.png", height: 200),
              Text("Hackathon name",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.black)),
              Text("12 apr 2021"),
              SizedBox(height: 16),
              SingleChildScrollView(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  style: TextStyle(
                    letterSpacing: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Radio(
              value: 'hacker',
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value;
                });
              },
            ),
            title: Text('Single Hacker', style: TextStyle(fontSize: 18)),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Radio(
              value: 'recruiter',
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value;
                });
              },
            ),
            title: Text('I have a small team', style: TextStyle(fontSize: 18)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryButton(
                  alt: false,
                  text: "Register for this",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
