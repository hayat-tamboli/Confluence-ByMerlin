import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:merlin/auth/forgotPassword.dart';
import 'package:merlin/auth/registerPage.dart';
import 'package:merlin/mainapp.dart';
import 'package:merlin/models/secret_keys.dart';
import 'package:merlin/services/authService.dart';
import 'package:merlin/services/authentication_service.dart';
import 'package:merlin/utils/Constants.dart';
import 'package:merlin/widgets/inputBox.dart';
import 'package:merlin/widgets/primaryBtn.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var _suggestionTextFieldController = TextEditingController();

  // List suggestionsList = [
  //   "Java",
  //   "C++",
  //   "C",
  //   "C++ 14",
  //   "C++ 17",
  //   "C99",
  //   "C#",
  //   "PHP",
  //   "Perl",
  //   "Ruby",
  //   "Python2",
  //   "Python3",
  //   "SQL",
  //   "Scala",
  //   "VB.Net",
  //   "Pascal",
  //   "Haskell",
  //   "Kotlin",
  //   "Swift",
  //   "Objective-C",
  //   "Groovy",
  //   "Fortran",
  //   "Brainfuck",
  //   "Hack",
  //   "TCL",
  //   "Lua",
  //   "Rust",
  //   "F#",
  //   "Ada",
  //   "D",
  //   "Dart",
  //   "YaBasic",
  //   "Free Basic",
  //   "Clojure",
  //   "Verilog",
  //   "NodeJS",
  //   "Scheme",
  //   "Forth",
  //   "Prolog",
  //   "Bash",
  //   "COBOL",
  //   "OCTAVE/ Matlab",
  //   "Icon",
  //   "CoffeeScript",
  //   "Assembler (GCC)",
  //   "R",
  //   "Assembler (NASM)",
  //   "Intercal",
  //   "Nemerle",
  //   "Ocaml",
  //   "Unlambda",
  //   "Picolisp",
  //   "CLISP",
  //   "Elixir",
  //   "SpiderMonkey",
  //   "Rhino JS",
  //   "BC",
  //   "Nim",
  //   "Factor",
  //   "Falcon",
  //   "Fantom",
  //   "Pike",
  //   "Go",
  //   "OZ-Mozart",
  //   "LOLCODE",
  //   "Racket",
  //   "SmallTalk",
  //   "Whitespace",
  //   "Erlang",
  //   "J Lang",
  //   "isCobol",
  // ];

  StreamSubscription _subs;
  bool loader;

  @override
  void initState() {
    loader = false;
    _initDeepLinkListener();
    setState(() => _passwordHide = true);
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    _subs = getLinksStream().listen((String link) {
      _checkDeepLink(link);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      AuthService().loginWithGitHub(code).then((firebaseUser) {
        print(firebaseUser.email);
        print(firebaseUser.photoURL);
        print("LOGGED IN AS: " + firebaseUser.displayName);
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
      _subs = null;
    }
  }

  void onClickGitHubLoginButton() async {
    const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        GITHUB_CLIENT_ID +
        "&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      setState(() {
        loader = true;
      });
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      setState(() {
        loader = false;
      });
      print("CANNOT LAUNCH THIS URL!");
    }
  }

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool _passwordHide;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome back",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputBox(
                      controller: emailController,
                      labelText: "Email",
                    ),
                    InputBox(
                      labelText: "Password",
                      hintText: "**********",
                      obscureText: _passwordHide,
                      controller: passwordController,
                      sufIcon: IconButton(
                        icon:
                            Icon(_passwordHide ? Feather.eye : Feather.eye_off),
                        onPressed: () {
                          setState(() {
                            _passwordHide = !_passwordHide;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        child: Text("forgot password?"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PrimaryButton(
                        alt: false,
                        onTap: () {
                          print("f");
                          context
                              .read<AuthenticationService>()
                              .signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              )
                              .then((value) {
                            print("ff");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainApp()));
                          });
                        },
                        text: "Sign in",
                      ),
                      SizedBox(height: 16),
                      PrimaryButton(
                          alt: false,
                          text: "Continue with github",
                          color: Color(0xff333333),
                          onTap: () async {
                            onClickGitHubLoginButton;
                            await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainApp()));
                          }),
                      SizedBox(height: 24),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'New here? ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: "Now",
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register here',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     context.read<AuthenticationService>().signUp(
                //           email: emailController.text.trim(),
                //           password: passwordController.text.trim(),
                //         );
                //   },
                //   child: Text("Sign Up"),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => ForgotPassword()));
                //   },
                //   child: Text("Forgot Password"),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => GetLinkedInUsers()));
                //   },
                //   child: Text("LinkedIn User List"),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => GetGithubUsers()));
                //   },
                //   child: Text("Github User List"),
                // ),
                // Padding(
                //     padding: EdgeInsets.all(20),
                //     child: Column(
                //       children: [
                //         AutoCompleteTextField(
                //           style: TextStyle(fontSize: 16.0, color: Colors.black),
                //           clearOnSubmit: false,
                //           controller: _suggestionTextFieldController,
                //           itemSubmitted: (item) {
                //             _suggestionTextFieldController.text = item;
                //           },
                //           suggestions: suggestionsList,
                //           itemBuilder: (context, item) {
                //             return Container(
                //                 padding: EdgeInsets.all(20.0),
                //                 child: Row(
                //                   children: <Widget>[
                //                     GestureDetector(
                //                         onTap: () {
                //                           createAlertDialog(context)
                //                               .then((onValue) {
                //                             SnackBar mySnackBar = SnackBar(
                //                                 content: Text(
                //                                     "$onValue projects done"));
                //                             print(mySnackBar);
                //                           });
                //                         },
                //                         child: Text(item,
                //                             style:
                //                                 TextStyle(color: Colors.black)))
                //                   ],
                //                 ));
                //           },
                //           itemSorter: (a, b) {
                //             return a.compareTo(b);
                //           },
                //           itemFilter: (item, query) {
                //             return item
                //                 .toLowerCase()
                //                 .startsWith(query.toLowerCase());
                //           },
                //           decoration: InputDecoration(
                //               border: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(20.0))),
                //         )
                //       ],
                //     ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
