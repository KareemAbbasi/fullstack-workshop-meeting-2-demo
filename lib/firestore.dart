import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("hello");
  // saveStudent();
  getUsers();
}

var students = [
  {"name": "Kareem", "id": 10},
  {"name": "Reem", "id": 2},
  {"name": "Rami", "id": 3},
  {"name": "Atef", "id": 4},
];

var doc1 = students[0];

/**
 * Collection: Students -> Doc(student name)
 */
Future<void> saveStudent() async {
  var db = FirebaseFirestore.instance;

  print("Adding data to firestore");
  students.forEach((student) async {
    await db
        .collection("Students")
        .doc(student["name"] as String?)
        .set(student)
        .onError((e, _) => print("Error writing document: $e"));
  });

  await db
      .collection("Students")
      .doc("Kareem")
      .set({"name": "Kareeeeeem"}, SetOptions(merge: true));

  print("done");
}

Future<void> getUsers() async {
  var db = FirebaseFirestore.instance;
  db.collection("Students").get().then(
    (querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
}
