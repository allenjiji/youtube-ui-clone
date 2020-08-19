import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final String email;
  final String pass;
  AuthServices({this.email, this.pass});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //method to sign in

  Future signIn() async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //method to register
  Future registerWithEmailAndPassword() async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = result.user;
      print(result);
      print(user);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //method to sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
