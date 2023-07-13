import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  EventModel(
    {
      required this.id,
      required this.geoId,
      required this.club,
      required this.createdAt,
      required this.scheduledAt,
      required this.name, 
      required this.description,
      required this.attendees,
      required this.type,
      required this.topic,
      required this.xp,
    }
  );

  String? id; // only ? because UserModel has the same thing
  String geoId;
  Map<String, String> club; // club admin name, club id, club name
  Timestamp createdAt;
  Timestamp scheduledAt;
  String name;
  String description;
  List<String> attendees;
  List<String> type; // have this as a well-defined list of types
  List<String> topic; // have this as a well-defined list of topics
  int xp;


  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    geoId: json["geoId"],
    club: json["club"],
    createdAt: Timestamp.fromDate(DateTime.parse(json["createdAt"])),
    scheduledAt: Timestamp.fromDate(DateTime.parse(json["scheduledAt"])),
    name: json["name"],
    description: json["description"],
    attendees: json["attendees"],
    type: json["type"],
    topic: json["topic"],
    xp: json["xp"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "geoId": geoId,
    "club": club,
    "createdAt": createdAt.toDate().toString(),
    "scheduledAt": scheduledAt.toDate().toString(),
    "name": name,
    "description": description,
    "attendees": attendees,
    "type": type,
    "topic": topic,
    "xp": xp
  };

  factory EventModel.fromFirebase(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    geoId: json["geoId"],
    club: json["club"],
    createdAt: json["createdAt"],
    scheduledAt: json["scheduledAt"],
    name: json["name"],
    description: json["description"],
    attendees: json["attendees"],
    type: json["type"],
    topic: json["topic"],
    xp: json["xp"]
  );

  Map<String, dynamic> toFirebase() => { // to remove id field
    "geoId": geoId,
    "club": club,
    "createdAt": createdAt,
    "scheduledAt": scheduledAt,
    "name": name,
    "description": description,
    "attendees": attendees,
    "type": type,
    "topic": topic,
    "xp": xp
  };
}
