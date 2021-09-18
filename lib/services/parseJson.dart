// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:quiz_app/services/models.dart';

// class ParseJson {
//   static parseJson(BuildContext context) async {
//     // String data1 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz1.json");
//     // String data2 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz2.json");
//     // String data3 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz3.json");
//     // String data4 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz4.json");
//     // String data5 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz5.json");
//     // String data6 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz6.json");
//     // String data7 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz7.json");
//     // String data8 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz8.json");
//     // String data9 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz9.json");
//     // String data10 =
//     //   await DefaultAssetBundle.of(context).loadString("assets/quiz10.json");
//     // final jsonResult1 = jsonDecode(data1);
//     // final jsonResult2 = jsonDecode(data2);
//     // final jsonResult3 = jsonDecode(data3);
//     // final jsonResult4 = jsonDecode(data4);
//     // final jsonResult5 = jsonDecode(data5);
//     // final jsonResult6 = jsonDecode(data6);
//     // final jsonResult7 = jsonDecode(data7);
//     // final jsonResult8 = jsonDecode(data8);
//     // final jsonResult9 = jsonDecode(data9);
//     // final jsonResult10 = jsonDecode(data10);
//     // CollectionReference db = FirebaseFirestore.instance.collection('quizs2');
//     // await db.add(
//     //   {
//     //     'questions': jsonResult1,
//     //     'title': jsonResult1[0]['category'],
//     //     'difficulty': jsonResult1[0]['difficulty'],
//     //   },
//     // );
//     // await db.add(
//     //   {
//     //     'questions': jsonResult2,
//     //     'title': jsonResult2[0]['category'],
//     //     'difficulty': jsonResult2[0]['difficulty'],
//     //   },
//     // );
//     // await db.add(
//     //   {
//     //     'questions': jsonResult3,
//     //     'title': jsonResult3[0]['category'],
//     //     'difficulty': jsonResult3[0]['difficulty'],
//     //   },
//     // );
//     // await db.add(
//     //   {
//     //     'questions': jsonResult4,
//     //     'title': jsonResult4[0]['category'],
//     //     'difficulty': jsonResult4[0]['difficulty'],
//     //   },
//     // );
//     // await db.add(
//     //   {
//     //     'questions': jsonResult5,
//     //     'title': jsonResult5[0]['category'],
//     //     'difficulty': jsonResult5[0]['difficulty'],
//     //   },
//     // );
//     // await db.add(
//     //   {
//     //     'questions': jsonResult6,
//     //     'title': jsonResult6[0]['category'],
//     //     'difficulty': jsonResult6[0]['difficulty'],
//     //   },
//     // );
//     // await db.add(
//     //   {
//     //     'questions': jsonResult7,
//     //     'title': jsonResult7[0]['category'],
//     //     'difficulty': jsonResult7[0]['difficulty'],
//     //   },
//     // );
//     // await db.add(
//     //   {
//     //     'questions': jsonResult8,
//     //     'title': jsonResult8[0]['category'],
//     //     'difficulty': jsonResult8[0]['difficulty'],
//     //   },
//     // );
//     // await db.add(
//     //   {
//     //     'questions': jsonResult9,
//     //     'title': jsonResult9[0]['category'],
//     //     'difficulty': jsonResult9[0]['difficulty'],
//     //   },
//     // );
//     // await db.add(
//     //   {
//     //     'questions': jsonResult10,
//     //     'title': jsonResult10[0]['category'],
//     //     'difficulty': jsonResult10[0]['difficulty'],
//     //   },
//     // );

//     var data1 =
//         await DefaultAssetBundle.of(context).loadString('assets/quiz1.json');
//     data1 = jsonEncode(data1);
//     final jsonResult1 = jsonDecode(data1);
//     print(jsonResult1);
//   }
// }
