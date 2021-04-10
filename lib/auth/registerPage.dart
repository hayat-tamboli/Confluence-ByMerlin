import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:merlin/auth/signInPage.dart';
import 'package:merlin/services/authentication_service.dart';
import 'package:merlin/widgets/inputBox.dart';
import 'package:merlin/widgets/primaryBtn.dart';

import '../mainapp.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _passwordHide = true;

  void initState() {
    setState(() => _passwordHide = true);
    super.initState();
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
              children: [
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputBox(
                      labelText: "Name",
                      hintText: "Jhon Doe",
                      controller: nameController,
                    ),
                    InputBox(
                      labelText: "E-mail",
                      hintText: "jhon.doe@example.com",
                      controller: emailController,
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
                  ],
                ),
                SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PrimaryButton(
                      alt: false,
                      onTap: () {
                        if (emailController.text != null &&
                            passwordController.text != null &&
                            nameController.text != null) {
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          AuthenticationService file =
                              new AuthenticationService(_auth);
                          file
                              .signUp(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainApp()));
                          });
                        }
                      },
                      text: "Register",
                    ),
                    SizedBox(height: 16),
                    PrimaryButton(
                      alt: false,
                      text: "Continue with github",
                      color: Color(0xff333333),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Already a user? ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Now",
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
