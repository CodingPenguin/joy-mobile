import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/user.dart';

class ApiService {

  Future<Map<String, dynamic>> getUser(String? userId) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection('users').doc(userId)
      .get()
      .then((DocumentSnapshot doc) {
        print("Successfully completed");
        final data = doc.data() as Map<String, dynamic>;
        return data;
      });
  }

  Future<void> addUser(UserModel user) {
    // https://stackoverflow.com/questions/48541270/how-to-add-document-with-custom-id-to-firestore
    final firebaseDB = FirebaseFirestore.instance;
    final _user = user.toJson();
    _user.remove('id');

    return firebaseDB.collection("users")
      .doc(user.id)
      .set(_user)
      .then((value) => log("User added"))
      .catchError((onError) => log("Failed to add user: $onError"));
  }

  Stream<QuerySnapshot> getGoals(String? userId) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("goals")
      .where('userId', isEqualTo: userId)
      .snapshots();
  }

  Future<QuerySnapshot> getGoal(String? userId) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("goals")
        .where("userId", isEqualTo: userId)
        .get();
  }

  Future<void> addGoal(String goalName, String? userId) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB
        .collection("goals")
        .add({
          "createdAt": Timestamp.fromDate(DateTime.now()),
          "points": 2, // hard coded
          "state": "incomplete", // hard coded
          "title": goalName,
          "userId": userId
        })
        .then((value) => log("Task added"))
        .catchError((onError) => log("Failed to add task: $onError"));
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

  Future<void> updateGoal(String goalId, Map<String, String> payload) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB
        .collection("goals")
        .doc(goalId)
        .update(payload)
        .then((value) => log("Task $goalId updated"))
        .catchError((onError) => log("Failed to update task $goalId: $onError"));
  }

  // https://firebase.flutter.dev/docs/firestore/usage/
  // https://firebase.google.com/docs/firestore/query-data/queries
  // ***DONE*** TODO: MAKE THIS SO THAT IT GETS TASKS WITH GOAL ID
  Stream<QuerySnapshot> getTasks(String goalId) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB
        .collection("tasks")
        .where("goalID", isEqualTo: goalId)
        .snapshots();
  }

  Future<void> addTask(String? userId, String goalId, String taskName) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("tasks")
      .add({
        "goalID": goalId,
        "createdAt": Timestamp.fromDate(DateTime.now()),
        "state": "incomplete",  // hard coded
        "title": taskName,
        "userId": userId
      })
      .then((value) => log("Task added"))
      .catchError((onError) => log("Failed to add task: $onError"));
  }

  Stream<QuerySnapshot> getEvents() {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("events").snapshots();
  }

  Future<void> updateTask(String id, Map<String, String> payload) {
    final firebaseDB = FirebaseFirestore.instance;
    return firebaseDB.collection("tasks")
      .doc(id)
      .update(payload)
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
}