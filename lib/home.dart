import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/login.dart';
import 'package:quiz_app/screens/quiz_scr.dart';
import 'package:quiz_app/screens/sign_up.dart';
import 'package:quiz_app/screens/take_quiz.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/services/models.dart';

class MyHome extends StatelessWidget {
  MyHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Firebase Analytics
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],

      // Named Routes
      routes: {
        '/sign_up': (context) => SignUp(),
        '/login': (context) => Login(),
        '/quiz_scr': (context) => QuizScr(),
        '/take_quiz': (context) => TakeQuiz(),
      },

      // Theme
      theme: ThemeData(
        fontFamily: 'Nunito',
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.black87,
        ),
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        accentColor: Colors.orange,
        // brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18),
          bodyText2: TextStyle(fontSize: 16),
          button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
          headline1: TextStyle(fontWeight: FontWeight.bold),
          headline2: TextStyle(color: Colors.grey),
        ),
        buttonTheme: ButtonThemeData(),
      ),
      home: func(),
    );
  }

  Widget func() {
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return QuizScr();
    } else
      return SignUp();
  }
}
