import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/services/models.dart';

// class Document {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final String path;
//   late DocumentReference ref;

//   Document({required this.path}) {
//     ref = _db.doc(path);
//   }

//   Future<Quiz> getData() async{
//     return  ref.get().then(
//       (v) {
//         return Quiz.quizFromFirestore(v.data() as Map<String, dynamic>);
//       },
//     );
//   }

//   // Stream<T> streamData() {
//   //   return ref.snapshots().map((v));
//   // }
// }

// class UserData<T> {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final String collection;

//   UserData({this.collection=''});

//   Stream<T> get documentStream {
//     return _auth.authStateChanges().switchMap((user) {
//       if (user != null) {
//         Document<T> doc = Document<T>(path: '$collection/${user.uid}');
//         return doc.streamData();
//       } else {
//         return Stream<T>.value(null);
//       }
//     });
//   }

//   Future<T> getDocument() async {
//       Document doc = Document<T>(path: '$collection/${user.uid}');
//       return doc.getData();
//     } else {
//       return null;
//     }
//   }

//   Future<void> upsert(Map data) async {
//     User user = _auth.currentUser;
//     Document<T> ref = Document(path: '$collection/${user.uid}');
//     return ref.upsert(data);
//   }
// }
