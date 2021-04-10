import 'package:flutter/material.dart';
import 'package:merlin/models/linkedInModel.dart';
import 'package:http/http.dart' as http;

class GetGithubUsers extends StatefulWidget {
  @override
  _GetLinkedInUsersState createState() => _GetLinkedInUsersState();
}

Future<LinkedinModel> getList(
    String name, String organisation, String language) async {
  String apiUrl = "https://acmhack.herokuapp.com/github";
  final responses = await http.post(Uri.parse(apiUrl), body: {
    "name": name,
    "organisation": organisation,
    "max_count": "5",
    "language": language
  });
  print(responses.body);
  return linkedinModelFromJson(responses.body);
}

class _GetLinkedInUsersState extends State<GetGithubUsers> {
  String _name, _organisation, _language;
  int _maxCount = 5;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController organisationController = TextEditingController();
  final TextEditingController maxCountController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Name",
            ),
            onChanged: (value) {
              _name = value;
            },
          ),
          TextField(
            controller: organisationController,
            decoration: InputDecoration(
              labelText: "organistion",
            ),
            onChanged: (value) {
              _organisation = value;
            },
          ),
          //  TextField(
          //   controller: nameController,
          //   decoration: InputDecoration(
          //     labelText: "MaxCount",
          //   ),
          //   onChanged: (value) {
          //     _maxCount =nameController.toInt();
          //   },
          // ),
          TextField(
            controller: languageController,
            decoration: InputDecoration(
              labelText: "Language",
            ),
            onChanged: (value) {
              _language = value;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              await getList(_name, _organisation, _language);
            },
            child: Text("Send"),
          )
        ],
      ),
    );
  }
}
