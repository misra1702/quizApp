import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/services/globals.dart';
import 'package:quiz_app/services/models.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: Globals.userRef.snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Something went wrong!",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                      ),
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!.docs;
              TextStyle? tempStyle =
                  Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Colors.white,
                      );
              List<Report> rep =
                  data.map((e) => Report.fromMap(e.data())).toList();
              rep.sort((b, a) => a.score.compareTo(b.score));

              print(rep[0].emailID + rep[1].emailID);
              if (rep.length == 0) {
                return Center(
                  child: Text(
                    "No User",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                );
              }
              var cUser = Globals.cAuth.getUser;
              int cInd =
                  rep.indexWhere((element) => element.emailID == cUser?.email);
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cUser?.email ?? "",
                          style: TextStyle(fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "${cInd + 1}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).accentColor,
                            ),
                            children: [
                              TextSpan(
                                text: "/${rep.length}",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: rep.length,
                      itemBuilder: (context, index) {
                        Widget? lead;
                        switch (index) {
                          case 0:
                            lead = Icon(
                              FontAwesomeIcons.trophy,
                              color: Colors.yellow,
                            );
                            break;
                          case 1:
                            lead = Icon(
                              FontAwesomeIcons.trophy,
                              color: Colors.grey.shade300,
                            );
                            break;
                          case 2:
                            lead = Icon(
                              FontAwesomeIcons.trophy,
                              color: Colors.yellow.shade900,
                            );
                            break;
                          default:
                            lead = Text("${index + 1}");
                            break;
                        }
                        return Card(
                          child: ListTile(
                            leading: lead,
                            title: Text(rep[index].emailID, style: tempStyle),
                            trailing: Text(rep[index].score.toString()),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  "Loading...",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                      ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class LeaderBoardBody extends StatefulWidget {
  const LeaderBoardBody({Key? key}) : super(key: key);

  @override
  _LeaderBoardBodyState createState() => _LeaderBoardBodyState();
}

class _LeaderBoardBodyState extends State<LeaderBoardBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
