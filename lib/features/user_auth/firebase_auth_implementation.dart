import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithUsernameAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }

    catch (e)
    {
      print("An error occured bruh, cant help u :(");
    }

    return null;
  }

  Future<User?> signInWithUsernameAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }

    catch (e)
    {
      print("An error occured bruh, cant help u :(");
    }

    return null;
  }

}