import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {

  // https://firebase.flutter.dev/docs/firestore/usage/
  Stream<QuerySnapshot> getTasks() {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("tasks").snapshots();
  }

  // Adding a type of goal
//   Future<void> addTypeForGoal(String taskName) {
//     final firebaseDB = FirebaseFirestore.instance;
//     return firebaseDB.collection("tasks")
//       .add({
//         "createdAt": Timestamp.fromDate(DateTime.now()),
//         "points": 2, // hard coded
//         "state": "incomplete",  // hard coded
//         "title": taskName,
//         "userId": "aaaaa"  // userId hard coded for now
//       })
//       .then((value) => log("Task added"))
//       .catchError((onError) => log("Failed to add task: $onError"));
//   }
// }

  Future<void> addGoalType(String goalType) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("tasks")
      .add({
        "createdAt": Timestamp.fromDate(DateTime.now()),
        "points": 2, // hard coded
        "state": "incomplete",  // hard coded
        "title": goalType,
        "userId": "aaaaa"  // userId hard coded for now
      })
      .then((value) => log("Task added"))
      .catchError((onError) => log("Failed to add task: $onError"));
  }

  Future<void> addTask(String taskName) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("tasks")
      .add({
        "createdAt": Timestamp.fromDate(DateTime.now()),
        "points": 2, // hard coded
        "state": "incomplete",  // hard coded
        "title": taskName,
        "userId": "aaaaa"  // userId hard coded for now
      })
      .then((value) => log("Task added"))
      .catchError((onError) => log("Failed to add task: $onError"));
  }

  Stream<QuerySnapshot> getEvents() {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("events").snapshots();
  }

}

  Future<void> updateTask(String id, Map<String, String> payload) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("tasks")
      .doc(id)
      .set(payload)
      .then((value) => log("Task $id updated"))
      .catchError((onError) => log("Failed to update task $id: $onError"));
  }

  Future<void> deleteTask(String id) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("tasks")
      .doc(id)
      .delete()
      .then((value) => log("Task $id deleted"))
      .catchError((onError) => log("Failed to delete task $id: $onError"));
  }