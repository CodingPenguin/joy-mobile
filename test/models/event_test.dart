// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_1/models/event.dart';

void main() {
  Timestamp currTime = Timestamp.now();
  EventModel event = EventModel(
    id: 'id',
    geoId: 'geoId',
    club: {
      'id': 'clubId',
      'name': 'clubName',
      'adminName': 'adminName'
    },
    createdAt: currTime,
    scheduledAt: currTime,
    name: 'name',
    description: 'description',
    attendees: ['attendee1'],
    type: ['type'],
    topic: ['topic'],
    xp: 0,
  );

  Map<String, dynamic> eventJson = {
    'id': 'id',
    'geoId': 'geoId',
    'club': {
      'id': 'clubId',
      'name': 'clubName',
      'adminName': 'adminName'
    },
    'createdAt': currTime.toDate().toString(),
    'scheduledAt': currTime.toDate().toString(),
    'name': 'name',
    'description': 'description',
    'attendees': ['attendee1'],
    'type': ['type'],
    'topic': ['topic'],
    'xp': 0
  };

  Map<String, dynamic> eventFirebase = {
    'geoId': 'geoId',
    'club': {
      'id': 'clubId',
      'name': 'clubName',
      'adminName': 'adminName'
    },
    'createdAt': currTime,
    'scheduledAt': currTime,
    'name': 'name',
    'description': 'description',
    'attendees': ['attendee1'],
    'type': ['type'],
    'topic': ['topic'],
    'xp': 0
  };

  test('EventModel.toJson()', () {
    expect(event.toJson(), eventJson);
  });

  test('EventModel.fromJson()', () {
    EventModel eventModelFromJson = EventModel.fromJson(eventJson);

    // https://pub.dev/packages/equatable considered using this, but may come with some unwarranted side effects
    expect(eventModelFromJson.id, event.id);
    expect(eventModelFromJson.geoId, event.geoId);
    expect(eventModelFromJson.club, event.club);
    expect(eventModelFromJson.createdAt, event.createdAt);
    expect(eventModelFromJson.scheduledAt, event.scheduledAt);
    expect(eventModelFromJson.name, event.name);
    expect(eventModelFromJson.description, event.description);
    expect(eventModelFromJson.attendees, event.attendees);
    expect(eventModelFromJson.xp, event.xp);
  });
  test('EventModel.fromFirebase()', () {
    EventModel eventModelFromFirebase = EventModel.fromFirebase(eventFirebase);

    // https://pub.dev/packages/equatable considered using this, but may come with some unwarranted side effects
    expect(eventModelFromFirebase.id, event.id);
    expect(eventModelFromFirebase.geoId, event.geoId);
    expect(eventModelFromFirebase.club, event.club);
    expect(eventModelFromFirebase.createdAt, event.createdAt);
    expect(eventModelFromFirebase.scheduledAt, event.scheduledAt);
    expect(eventModelFromFirebase.name, event.name);
    expect(eventModelFromFirebase.description, event.description);
    expect(eventModelFromFirebase.attendees, event.attendees);
    expect(eventModelFromFirebase.xp, event.xp);
  });
  test('EventModel.toFirebase()', () {
    expect(event.toFirebase(), eventFirebase);
  });
}