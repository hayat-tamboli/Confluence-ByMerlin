import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:merlin/services/authentication_service.dart';
import 'package:merlin/forgotPassword.dart';
import 'package:merlin/getGithubUsers.dart';
import 'package:merlin/getLinkedInUsers.dart';
import 'package:merlin/widgets/skillsSearchBox.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  var _suggestionTextFieldController = TextEditingController();
  List suggestionsList = [
    "Java",
    "C++",
    "C",
    "C++ 14",
    "C++ 17",
    "C99",
    "C#",
    "PHP",
    "Perl",
    "Ruby",
    "Python2",
    "Python3",
    "SQL",
    "Scala",
    "VB.Net",
    "Pascal",
    "Haskell",
    "Kotlin",
    "Swift",
    "Objective-C",
    "Groovy",
    "Fortran",
    "Brainfuck",
    "Hack",
    "TCL",
    "Lua",
    "Rust",
    "F#",
    "Ada",
    "D",
    "Dart",
    "YaBasic",
    "Free Basic",
    "Clojure",
    "Verilog",
    "NodeJS",
    "Scheme",
    "Forth",
    "Prolog",
    "Bash",
    "COBOL",
    "OCTAVE/ Matlab",
    "Icon",
    "CoffeeScript",
    "Assembler (GCC)",
    "R",
    "Assembler (NASM)",
    "Intercal",
    "Nemerle",
    "Ocaml",
    "Unlambda",
    "Picolisp",
    "CLISP",
    "Elixir",
    "SpiderMonkey",
    "Rhino JS",
    "BC",
    "Nim",
    "Factor",
    "Falcon",
    "Fantom",
    "Pike",
    "Go",
    "OZ-Mozart",
    "LOLCODE",
    "Racket",
    "SmallTalk",
    "Whitespace",
    "Erlang",
    "J Lang",
    "isCobol",
  ];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customcontroller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Number of projects"),
            content: TextField(
              controller: customcontroller,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Submit"),
                onPressed: () {
                  Navigator.of(context).pop(customcontroller.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
            },
            child: Text("Sign in"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
            },
            child: Text("Sign Up"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            child: Text("Forgot Password"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GetLinkedInUsers()));
            },
            child: Text("LinkedIn User List"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GetGithubUsers()));
            },
            child: Text("Github User List"),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  AutoCompleteTextField(
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    clearOnSubmit: true,
                    controller: _suggestionTextFieldController,
                    itemSubmitted: (item) {
                      _suggestionTextFieldController.text = item;
                    },
                    suggestions: suggestionsList,
                    itemBuilder: (context, item) {
                      return Container(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    createAlertDialog(context).then((onValue) {
                                      SnackBar mySnackBar = SnackBar(
                                          content:
                                              Text("$onValue projects done"));
                                      print(mySnackBar);
                                    });
                                  },
                                  child: Text(item,
                                      style: TextStyle(color: Colors.black)))
                            ],
                          ));
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemFilter: (item, query) {
                      return item.toLowerCase().startsWith(query.toLowerCase());
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
