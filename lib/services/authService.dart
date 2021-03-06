import 'dart:convert';
import 'package:http/http.dart' as http;
// as SecretKey;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:merlin/models/github_login_request.dart';
import 'package:merlin/models/github_login_response.dart';
import 'package:merlin/services/secret_keys.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  Future<auth.User> loginWithGitHub(String code) async {
    //ACCESS TOKEN REQUEST
    final response = await http.post(
      Uri.parse("https://github.com/login/oauth/access_token"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(GitHubLoginRequest(
        clientId: GITHUB_CLIENT_ID,
        clientSecret: GITHUB_CLIENT_SECRET,
        code: code,
      )),
    );
    GitHubLoginResponse loginResponse =
        GitHubLoginResponse.fromJson(json.decode(response.body));
//FIREBASE SIGNIN
    final auth.AuthCredential credential =
        auth.GithubAuthProvider.credential(loginResponse.accessToken);

    final auth.User user =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    return user;
  }
}
