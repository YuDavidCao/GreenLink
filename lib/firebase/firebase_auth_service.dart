import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:GreenLink/firebase/firebase_firestore_service.dart';

class FirebaseAuthService {
  static Future<bool> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      //ignored
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<bool> signupWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      //ignored
    }
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestoreService.addUserData(
          FirebaseAuth.instance.currentUser!.email ?? "",
          FirebaseAuth.instance.currentUser!.uid);
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<void> deleteUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.delete();
    }
  }
}
