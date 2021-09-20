import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/services/models.dart';

/// Static global state. Immutable services that do not care about build context.
class Globals {
  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();


  // Firestore References for Writes
  static final quizRef = FirebaseFirestore.instance.collection('quizs2');
  static final userRef = FirebaseFirestore.instance.collection('users');
  static final cAuth = AuthService();
}
