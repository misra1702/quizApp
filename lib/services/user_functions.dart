import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/services/auth.dart';

class UserFunctions {
  static String collectionName = 'users';
  static CollectionReference db =
      FirebaseFirestore.instance.collection(collectionName);
  static AuthService auth = AuthService();

  static void addUser() {
    User? cUser = auth.getUser;
    if (cUser == null) {
      print("Unable to add user because no one is logged in");
      return;
    }
    String id = cUser.uid;
    db.doc(id).set(
      {
        'emailID': cUser.email,
        'quizSolved': [],
        'score': 0,
      },
    ).then(
      (value) {
        print("User added ${cUser.email}");
      },
    ).catchError(
      (e) {
        print("Failed to add user $e");
      },
    );
  }

  static void addTopic(String quizName) {
    User? cUser = auth.getUser;
    if (cUser == null) {
      print("Unable to add quiz becuase no user logged in");
      return;
    }
    String id = cUser.uid;
    db.doc(id).set(
      {
        'quizSolved': FieldValue.arrayUnion([quizName]),
        'score': FieldValue.increment(1),
      },
      SetOptions(merge: true),
    ).then(
      (value) {
        print("Quiz $quizName added to user $id");
      },
    ).catchError(
      (e) {
        print("Quiz topic not added: $e");
      },
    );
  }
}
