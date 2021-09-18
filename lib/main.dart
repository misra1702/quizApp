import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/screens/login.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/services/parseJson.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    // ParseJson.parseJson(context);
    return FutureBuilder(
      future: _initialization,
      builder: (context, e) {
        if (e.hasError) {
          return Container();
        }
        if (e.connectionState == ConnectionState.done) {
          return MyHome();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
