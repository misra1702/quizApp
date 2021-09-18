import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/globals.dart';
import 'package:quiz_app/services/models.dart';
import 'package:quiz_app/services/user_functions.dart';

// Shared Data
class QuizState extends ChangeNotifier {
  double? progress = 0;
  int? selected;

  final PageController controller = PageController();

  void setProgress(double? newValue) {
    progress = newValue;
    notifyListeners();
  }

  void setSelected(int? newValue) {
    selected = newValue;
    notifyListeners();
  }

  void nextPage() async {
    setSelected(null);
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}

class TakeQuiz extends StatelessWidget {
  const TakeQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Inside TakeQuiz");
    if (Globals.cAuth.getUser == null) {
      print("No user logged in");
      Navigator.of(context).pushReplacementNamed('/sign_up');
    }
    Quiz2List? quiz = ModalRoute.of(context)?.settings.arguments as Quiz2List;
    return ChangeNotifierProvider(
      create: (context) {
        return QuizState();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Builder(builder: (context) {
          var state = Provider.of<QuizState>(context);
          return PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: state.controller,
            onPageChanged: (int idx) =>
                state.progress = (idx / (quiz.questions.length + 1)),
            itemBuilder: (BuildContext context, int idx) {
              if (idx == 0) {
                return StartPage(quiz: quiz);
              } else if (idx == quiz.questions.length + 1) {
                return CongratsQuiz(quiz: quiz);
              } else {
                return QuestionPage(ques: quiz.questions[idx - 1]);
              }
            },
          );
        }),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  // final PageController controller;
  StartPage({Key? key, required this.quiz}) : super(key: key);
  final Quiz2List quiz;

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            quiz.title,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  color: Theme.of(context).accentColor,
                ),
            textAlign: TextAlign.center,
          ),
          Divider(),
          Expanded(
            child: Text(
              quiz.difficulty,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          TextButton(
            onPressed: state.nextPage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.poll),
                Text('Start Quiz!'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CongratsQuiz extends StatelessWidget {
  CongratsQuiz({Key? key, required this.quiz}) : super(key: key);
  final Quiz2List quiz;
  late Report rep;
  bool isDisabled = false;

  void func() async {
    rep = await Globals.userRef.doc(Globals.cAuth.getUser!.uid).get().then(
      (value) {
        print(value);
        return Report.fromMap(value.data()!);
      },
    ).catchError(
      (e) {
        print("User fetching failed $e");
      },
    );
    if (rep.quizSolved.contains(quiz.title + quiz.difficulty)) {
      isDisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    func();
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats! You completed the ${quiz.title} quiz',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          Divider(),
          // Image.asset('assets/congrats.gif'),
          // Divider(),
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.check),
                Text('Mark Complete!'),
              ],
            ),
            onPressed: () {
              if (isDisabled) {
                SnackBar temp = SnackBar(
                  content: Text("You have already completed this quiz"),
                );
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(temp);
                return;
              }
              String topicId = quiz.title + quiz.difficulty;
              UserFunctions.addTopic(topicId);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/quiz_scr',
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }

  /// Database write to update report doc when complete
  // Future<void> _updateUserReport(Quiz quiz) {
  //   return Global.reportRef.upsert(
  //     ({
  //       'total': FieldValue.increment(1),
  //       'topics': {
  //         '${quiz.topic}': FieldValue.arrayUnion([quiz.id])
  //       }
  //     }),
  //   );
  // }
}

class QuestionPage extends StatelessWidget {
  final Quiz2 ques;
  QuestionPage({Key? key, required this.ques}) : super(key: key);
  late List<String> options;
  void func() {
    options = [];
    options.addAll(ques.incorrect_answers);
    options.add(ques.correct_answer);
    options.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    func();
    var state = Provider.of<QuizState>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(ques.question),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: options.map((opt) {
              return Container(
                height: 90,
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.black26,
                child: InkWell(
                  onTap: () {
                    state.selected = options.indexOf(opt);
                    bool isCorrect = (opt == ques.correct_answer);
                    _bottomSheet(context, opt, state, isCorrect);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                            // opt == ques.correct_answer
                            //     ? FontAwesomeIcons.checkCircle
                            //     : FontAwesomeIcons.circle,
                            FontAwesomeIcons.circle,
                            size: 30),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              opt,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  /// Bottom sheet shown when Question is answered
  _bottomSheet(
      BuildContext context, String opt, QuizState state, bool isCorrect) {
    bool correct = isCorrect;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(correct ? 'Good Job!' : 'Wrong'),
              // Text(
              //   opt.detail,
              //   style: TextStyle(fontSize: 18, color: Colors.white54),
              // ),
              TextButton(
                // color: correct ? Colors.green : Colors.red,
                child: Text(
                  correct ? 'Onward!' : 'Try Again',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: correct ? Colors.green : Colors.red,
                      ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
