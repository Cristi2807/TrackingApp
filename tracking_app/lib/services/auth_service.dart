import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracking_app/pages/login.dart';
import '../models/user.dart';


class AuthService {

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user){
    if (user==null){
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
      String email,
      String password
      ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e){
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Wrong password provided for that user.',
        );
      }
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email,
      String password,
      ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async{
    return await _firebaseAuth.signOut();
  }
}