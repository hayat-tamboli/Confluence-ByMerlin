import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:merlin/auth/mainAuthPage.dart';
import 'package:merlin/widgets/primaryBtn.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.pop(context);
              })),
      body: Container(
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Hayat Tamboli",
                      style: TextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Feather.edit,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Graduation Year",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "2023",
                      style: TextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Feather.edit,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Skills",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Hayat Tamboli",
                      style: TextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Feather.edit,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            PrimaryButton(alt: true, text: "Log out", onTap: (){Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MainAuthPage()));})
          ],
        ),
      ),
    );
  }
}
