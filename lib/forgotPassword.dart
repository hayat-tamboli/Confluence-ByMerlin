import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

Future getrequest() async {
  final response = await http.get(Uri.parse("https://acmhack.herokuapp.com/"));
  print(response.body) ;
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email;
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();

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
            onChanged: (value) {
              _email = value;
            },
          ),
          ElevatedButton(
            onPressed: () {
              // auth.sendPasswordResetEmail(email: _email);
              getrequest();
            },
            child: Text("Send"),
          )
        ],
      ),
    );
  }
}
