import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static Future<bool> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Successful login, you can navigate to the next screen or do any other logic here.
    } catch (e) {
      // Handle login errors (e.g., invalid credentials, user not found, etc.)
      print('Error: $e');
      // You can show a snackbar, alert dialog, or any other error handling UI here.
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<bool> signupWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Successful signup, you can navigate to the next screen or do any other logic here.
    } catch (e) {
      // Handle signup errors (e.g., weak password, email already in use, etc.)
      print('Error: $e');
      // You can show a snackbar, alert dialog, or any other error handling UI here.
    }
    return FirebaseAuth.instance.currentUser != null;
  }
}
