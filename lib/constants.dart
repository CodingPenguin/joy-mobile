import 'package:flutter/material.dart';
import 'home/home.dart';
import 'geocommunity/geocommunity.dart';
import 'leaderboard/leaderboard.dart';
import 'user_profile/user_profile.dart';

class ApiConstants {
  static String productionUrl = '';
  static String devUrl = 'http://localhost:4201';
  static String usersEndpoint = '/users';
  static String tasksEndpoint = '/tasks';
}

const List<Widget> widgetOptions = <Widget>[
  HomeWidget(),
  GeocommunityWidget(),
  LeaderboardWidget(),
  UserProfileWidget(),
];
