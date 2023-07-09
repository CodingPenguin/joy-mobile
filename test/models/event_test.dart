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
  test('EventModel.toJson()', () {
    testEventModelToJson();
  });
  test('EventModel.fromJson', () {
    testEventModelFromJson();
  });
}

testEventModelToJson() {
  Timestamp curr_time = Timestamp.now();

  EventModel testEvent = EventModel(
    id: 'id',
    geoId: 'geoId',
    club: {
      'id': 'clubId',
      'name': 'clubName' 
    },
    createdAt: curr_time,
    scheduledAt: curr_time,
    name: 'name',
    description: 'description',
    attendees: ['attendee1'],
    xp: 0,
  );

  Map<String, dynamic> testEventJson = {
    'id': 'id',
    'geoId': 'geoId',
    'club': {
      'id': 'clubId',
      'name': 'clubName'
    },
    'createdAt': curr_time.toDate().toString(),
    'scheduledAt': curr_time.toDate().toString(),
    'name': 'name',
    'description': 'description',
    'attendees': ['attendee1'],
    'xp': 0
  };

  expect(testEvent.toJson(), testEventJson);
}

testEventModelFromJson() {
  Timestamp curr_time = Timestamp.now();

  EventModel testEvent = EventModel(
    id: 'id',
    geoId: 'geoId',
    club: {
      'id': 'clubId',
      'name': 'clubName' 
    },
    createdAt: curr_time,
    scheduledAt: curr_time,
    name: 'name',
    description: 'description',
    attendees: ['attendee1'],
    xp: 0,
  );

  Map<String, dynamic> testEventJson = {
    'id': 'id',
    'geoId': 'geoId',
    'club': {
      'id': 'clubId',
      'name': 'clubName'
    },
    'createdAt': curr_time.toDate().toString(),
    'scheduledAt': curr_time.toDate().toString(),
    'name': 'name',
    'description': 'description',
    'attendees': ['attendee1'],
    'xp': 0
  };

  EventModel testModel = EventModel.fromJson(testEventJson);

  // https://pub.dev/packages/equatable considered using this, but may come with some unwarranted side effects
  expect(testModel.id, testEvent.id);
  expect(testModel.geoId, testEvent.geoId);
  expect(testModel.club, testEvent.club);
  expect(testModel.createdAt, testEvent.createdAt);
  expect(testModel.scheduledAt, testEvent.scheduledAt);
  expect(testModel.name, testEvent.name);
  expect(testModel.description, testEvent.description);
  expect(testModel.attendees, testEvent.attendees);
  expect(testModel.xp, testEvent.xp);
  expect(testModel, testEvent);
}