import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/screens/take_quiz.dart';
import 'package:quiz_app/services/globals.dart';
import 'package:quiz_app/services/models.dart';

class RandomQuiz {
  late Quiz2List quiz;
  List<String> quizNames = ["History", "Animals", "Politics"];
  late List<Quiz2> allQues = [];
  Random _ran = Random();

  List<int> randomListInd(int size, int max) {
    List<int> x = [];
    while (x.length < size) {
      int ind = _ran.nextInt(size);
      if (x.contains(ind)) continue;
      x.add(ind);
    }
    return x;
  }

  Future<Quiz2List> getQuiz() async {
    int ind = Random().nextInt(quizNames.length);
    allQues = [];
    print("Fetching Quiz from ${quizNames[ind]}");
    await Globals.quizRef.where('title', isEqualTo: quizNames[ind]).get().then(
      (value) {
        value.docs.map(
          (element) {
            var b = Quiz2List.fromMap(element.data());
            allQues.addAll(b.questions);
            return b;
          },
        ).toList();
      },
    );
    print(allQues.length);
    List<int> indList = randomListInd(10, allQues.length);
    List<Quiz2> quesReal = [];
    for (int i = 0; i < indList.length; i++) {
      quesReal.add(allQues[indList[i]]);
    }
    print(quesReal.length);
    quiz = Quiz2List(
      difficulty: "Random",
      title: "Random Quiz",
      questions: quesReal,
    );
    return quiz;
    // return List<Quiz2List>.from(a);
  }
}
