import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merlin/mainapp.dart';
import 'package:merlin/widgets/primaryBtn.dart';

import 'auth/registerPage.dart';

class FilterChipDisplay extends StatefulWidget {
  @override
  _FilterChipDisplayState createState() => _FilterChipDisplayState();
}

class _FilterChipDisplayState extends State<FilterChipDisplay> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.times,
              color: Colors.white,
            ),
            onPressed: () {}),
        title: Text(
          "Filter Result",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.home,
                color: Colors.white,
              ),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _titleContainer("Web Development"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Wrap(
                spacing: 5.0,
                runSpacing: 3.0,
                children: <Widget>[
                  filterChipWidget(chipName: 'HTML'),
                  filterChipWidget(chipName: 'CSS'),
                  filterChipWidget(chipName: 'JavaScript'),
                  filterChipWidget(chipName: 'Django'),
                  filterChipWidget(chipName: 'Flask'),
                ],
              )),
            ),
          ),
          Divider(
            color: Colors.blueGrey,
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _titleContainer('Backend'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: <Widget>[
                    filterChipWidget(chipName: 'C++'),
                    filterChipWidget(chipName: 'Python'),
                    filterChipWidget(chipName: 'Java'),
                    filterChipWidget(chipName: 'Ruby'),
                    filterChipWidget(chipName: 'GoLang'),
                    filterChipWidget(chipName: 'R'),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.blueGrey,
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _titleContainer('Others'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: <Widget>[
                    filterChipWidget(chipName: 'Flutter'),
                    filterChipWidget(chipName: 'Dart'),
                    filterChipWidget(chipName: 'SQL'),
                    filterChipWidget(chipName: 'PHP'),
                    filterChipWidget(chipName: 'Kotlin'),
                    filterChipWidget(chipName: 'Swift'),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.blueGrey,
            height: 10.0,
          ),
          PrimaryButton(
            text: "Submit",
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainApp()));
            },
            padding: 40,
            alt: false,
          ),
        ],
      ),
    );
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
  );
}

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: Color(0xff6200ee),
          fontSize: 16.0,
          fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Color(0xffeadffd),
    );
  }
}
