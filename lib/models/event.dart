import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

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
      // required this.type,
      // required this.topic,
      required this.xp,
    }
  );

  String? id;
  String geoId;
  Map<String, String> club;
  Timestamp createdAt;
  Timestamp scheduledAt;
  String name;
  String description;
  List<String> attendees;
  // String? type;
  // String? topic;
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
    // type: json["type"],
    // topic: json["topic"],
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
    // "type": type,
    // "topic": topic,
    "xp": xp
  };
}
