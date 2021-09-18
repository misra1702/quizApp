import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz2List {
  List<Quiz2> questions;
  String title;
  String difficulty;
  Quiz2List(
      {required this.questions, required this.title, required this.difficulty});

  factory Quiz2List.fromMap(Map<String, dynamic> data) {
    var temp = data['questions'].map((e) => Quiz2.fromMap(e)).toList();
    List<Quiz2> ques = List<Quiz2>.from(temp);
    return Quiz2List(
      questions: ques,
      title: data['title'],
      difficulty: data['difficulty'],
    );
  }

  factory Quiz2List.fromJson(List<dynamic> data) {
    List<Quiz2> ques = data.map((e) => Quiz2.fromMap(e)).toList();
    return Quiz2List(
      questions: ques,
      title: data[0]['category'],
      difficulty: data[0]['difficulty'],
    );
  }
}

class Quiz2 {
  String question;
  String correct_answer;
  List<String> incorrect_answers;

  Quiz2(this.question, this.correct_answer, this.incorrect_answers);

  factory Quiz2.fromMap(Map<String, dynamic> data) {
    var temp = data['incorrect_answers'];
    List<String> inc = List<String>.from(temp);
    return Quiz2(data['question'], data['correct_answer'], inc);
  }
}

class Report {
  String emailID;
  int score;
  List<String> quizSolved;

  Report({required this.emailID, required this.quizSolved, required this.score});

  factory Report.fromMap(Map<String, dynamic> data) {
    List<dynamic> temp = data['quizSolved'].map((e) {
      return e;
    }).toList();
    List<String> qSolved = [];
    if (temp.length > 0) {
      qSolved = List<String>.from(temp);
    }
    List<String>.from(temp);
    return Report(
      emailID: data['emailID'],
      score: data['score'],
      quizSolved: qSolved,
    );
  }
}
