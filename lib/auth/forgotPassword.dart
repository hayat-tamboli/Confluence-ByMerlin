import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merlin/widgets/inputBox.dart';
import 'package:merlin/widgets/primaryBtn.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

Future getrequest() async {
  final response = await http.get(Uri.parse("https://acmhack.herokuapp.com/"));
  print(response.body);
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email;
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Forgot your password?",
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              InputBox(
                controller: emailController,
                labelText: "Email",
                onChange: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PrimaryButton(
                  alt: false,
                  onTap: () {
                    // auth.sendPasswordResetEmail(email: _email);
                    getrequest();
                  },
                  text: "Send Email",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
