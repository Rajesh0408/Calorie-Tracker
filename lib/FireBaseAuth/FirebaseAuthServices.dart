import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential credential =await auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e) {
      print(e);
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential credential =await auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e) {
      print(e);
    }
    return null;
  }
}