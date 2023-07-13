import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.geoId,
    required this.createdAt,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.rank,
    required this.xp
  });

  String? id;
  String geoId;
  Timestamp createdAt;
  String username;
  String firstName;
  String lastName;
  String bio;
  String rank;
  int xp;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    geoId: json["geoId"],
    createdAt: Timestamp.fromDate(DateTime.parse(json["createdAt"])),
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    bio: json["bio"],
    rank: json["rank"],
    xp: json["xp"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "geoId": geoId,
    "createdAt": createdAt.toDate().toString(),
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "bio": bio,
    "rank": rank,
    "xp": xp
  };

  factory UserModel.fromFirebase(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    geoId: json["geoId"],
    createdAt: json["createdAt"],
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    bio: json["bio"],
    rank: json["rank"],
    xp: json["xp"]
  );

  Map<String, dynamic> toFirebase() => { // to remove id field and keep createdAt as Timestamp
    "geoId": geoId,
    "createdAt": createdAt,
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "bio": bio,
    "rank": rank,
    "xp": xp
  };
}
