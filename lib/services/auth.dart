import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase user one-time fetch
  User? get getUser {
    return _auth.currentUser;
  }

  // Firebase user a realtime stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future<UserCredential?> signUp(
      String email, String password, BuildContext context) async {
    UserCredential? a;
    String snack = '';
    try {
      a = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        snack = 'Invalid Email';
      } else if (e.code == 'email-already-in-use') {
        snack = 'Email already in use';
      } else if (e.code == 'weak-password') {
        snack = 'Weak Password';
      }
      if (snack != '') {
        SnackBar e = SnackBar(content: Text(snack));
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(e);
      }
    }
    return a;
  }

  Future<UserCredential?> login(
      String email, String password, BuildContext context) async {
    UserCredential? a;
    String snack = '';
    try {
      a = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        snack = 'Invalid Email';
      } else if (e.code == 'user-not-found') {
        snack = 'User Not Found';
      } else if (e.code == 'wrong-password') {
        snack = 'Wrong Password';
      }
    }
    if (snack != '') {
      SnackBar e = SnackBar(content: Text(snack));
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(e);
      snack = '';
    }
    return a;
  }

  // Sign out
  Future<void> signOut() {
    return _auth.signOut();
  }
}
