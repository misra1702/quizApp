import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/screens/leaderboard.dart';
import 'package:quiz_app/screens/random_quiz.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/services/db.dart';
import 'package:quiz_app/services/globals.dart';
import 'package:quiz_app/services/models.dart';
import 'package:quiz_app/services/parseJson.dart';

class QuizScr extends StatefulWidget {
  const QuizScr({Key? key}) : super(key: key);

  @override
  _QuizScrState createState() => _QuizScrState();
}

class _QuizScrState extends State<QuizScr> {
  AuthService auth = AuthService();
  int index = 0;
  List<Widget> bodyList = [
    QuizScrBody(),
    LeaderBoard(),
  ];
  void func(int cIndex) async {
    if (cIndex == 2) {
      Quiz2List quiz = await RandomQuiz().getQuiz();
      Navigator.of(context).pushNamed('/take_quiz', arguments: quiz);
      return;
    }
    index = cIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("Inside quiz_scr");

    return Scaffold(
      appBar: AppBar(
        title: Text("QuizApp"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Sign Out?",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                auth.signOut();
                                Navigator.of(context)
                                    .pushReplacementNamed('/sign_up');
                              },
                              child: Text(
                                "Yes",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "No",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: bodyList[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.graduationCap, size: 20),
              label: 'Topics'),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard, size: 20), label: 'Leaderboard'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.random, size: 20), label: 'Random'),
        ],
        currentIndex: index,
        onTap: (int idx) {
          switch (idx) {
            case 0:
              func(0);
              break;
            case 1:
              func(1);
              break;
            case 2:
              func(2);
              break;
          }
        },
        selectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 18,
      ),
    );
  }
}

class QuizScrBody extends StatefulWidget {
  const QuizScrBody({Key? key}) : super(key: key);

  @override
  _QuizScrBodyState createState() => _QuizScrBodyState();
}

class _QuizScrBodyState extends State<QuizScrBody> {
  late Future<List<Quiz2List>> quizList;

  @override
  void initState() {
    super.initState();
    quizList = func();
  }

  Future<List<Quiz2List>> func() async {
    print("Fetching Quiz Lists");
    var a = await Globals.quizRef.get().then(
      (value) {
        return value.docs.map(
          (element) {
            return Quiz2List.fromMap(element.data());
          },
        ).toList();
      },
    );
    return List<Quiz2List>.from(a);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: quizList,
      builder: (context, AsyncSnapshot<List<Quiz2List>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GridView.count(
            crossAxisCount: 2,
            children: snapshot.data!.map((e) => QuizItem(quiz: e)).toList(),
          );
        }
        return Container(
          color: Colors.transparent,
        );
      },
    );
  }
}

class QuizItem extends StatelessWidget {
  final Quiz2List quiz;
  const QuizItem({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/take_quiz', arguments: quiz);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  quiz.title,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  quiz.difficulty,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          // )
          // TopicProgress(topic: topic),
        ),
      ),
    );
  }
}
