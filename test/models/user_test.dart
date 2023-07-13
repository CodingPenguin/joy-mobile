import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_1/models/user.dart';

void main() {
  Timestamp currTime = Timestamp.now();
  UserModel user = UserModel(
    id: 'id',
    geoId: 'geoId',
    createdAt: currTime,
    username: 'username',
    firstName: 'firstName',
    lastName: 'lastName',
    bio: 'bio',
    rank: 'rank',
    xp: 0,
  );

  Map<String, dynamic> userJson = {
    'id': 'id',
    'geoId': 'geoId',
    'createdAt': currTime.toDate().toString(),
    'username': 'username',
    'firstName': 'firstName',
    'lastName': 'lastName',
    'bio': 'bio',
    'rank': 'rank',
    'xp': 0
  };

  Map<String, dynamic> userFirebase = {
    'geoId': 'geoId',
    'createdAt': currTime,
    'username': 'username',
    'firstName': 'firstName',
    'lastName': 'lastName',
    'bio': 'bio',
    'rank': 'rank',
    'xp': 0
  };

  test('UserModel.fromJson()', () {
    UserModel userModelFromJson = UserModel.fromJson(userJson);

    // https://pub.dev/packages/equatable considered using this, but may come with some unwarranted side effects
    expect(userModelFromJson.id, user.id);
    expect(userModelFromJson.geoId, user.geoId);
    expect(userModelFromJson.createdAt, user.createdAt);
    expect(userModelFromJson.username, user.username);
    expect(userModelFromJson.firstName, user.firstName);
    expect(userModelFromJson.lastName, user.lastName);
    expect(userModelFromJson.bio, user.bio);
    expect(userModelFromJson.rank, user.rank);
    expect(userModelFromJson.xp, user.xp);
  });

  test('UserModel.toJson()', () {
    expect(user.toJson(), userJson);
  });
  
  test('UserModel.fromFirebase()', () {
    UserModel userModelFromFirebase = UserModel.fromJson(userFirebase);

    // https://pub.dev/packages/equatable considered using this, but may come with some unwarranted side effects
    expect(userModelFromFirebase.id, user.id);
    expect(userModelFromFirebase.geoId, user.geoId);
    expect(userModelFromFirebase.createdAt, user.createdAt);
    expect(userModelFromFirebase.username, user.username);
    expect(userModelFromFirebase.firstName, user.firstName);
    expect(userModelFromFirebase.lastName, user.lastName);
    expect(userModelFromFirebase.bio, user.bio);
    expect(userModelFromFirebase.rank, user.rank);
    expect(userModelFromFirebase.xp, user.xp);
  });

  test('UserModel.toFirebase()', () {
    expect(user.toFirebase(), userFirebase);
  });
}
