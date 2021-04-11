import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import 'profile page/editProfile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage>
    with TickerProviderStateMixin {
  List<Widget> welcomeImages = [
    SwipeCard(),
    SwipeCard(),
    SwipeCard(),
    SwipeCard(),
    SwipeCard(),
    SwipeCard(),
  ];

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return new Scaffold(
      body: new Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: new TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.BOTTOM,
            totalNum: welcomeImages.length,
            stackNum: 3,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => Card(
              child: welcomeImages[index],
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfile()));
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              /// Get orientation & index of swiped card!
            },
          ),
        ),
      ),
    );
  }
}

class SwipeCard extends StatelessWidget {
  const SwipeCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 10.0),
            CircleAvatar(
              radius: 30.0,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100.0))),
            ),
            SizedBox(height: 10.0),
            Text(
              "Hayat Tamboli",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.0),
            Text(
              "VIT' 23",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/google.png", height: 50.0, width: 50.0),
                Image.asset("assets/linkedin.png", height: 50.0, width: 50.0),
                Image.asset("assets/twitter.png", height: 50.0, width: 50.0),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  width: 100.0,
                  child: Center(child: Text("Java")),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 70.0,
                  child: Center(child: Text("C++")),
                  decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 100.0,
                  child: Center(child: Text("Flask")),
                  decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  width: 100.0,
                  child: Center(child: Text("Flutter")),
                  decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 100.0,
                  child: Center(child: Text("Firebase")),
                  decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(width: 10.0),
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
