import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:merlin/models/devProfile.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  AuthenticationService(this._firebaseAuth);
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password,String name}) async {
    try {
     
      final UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User user = authResult.user;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(UserProfile.newuser(user.uid, name, user.email).toJson());
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
