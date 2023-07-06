import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';
import '../models/user.dart';
import 'widgets/add_goal.dart';
import 'widgets/goal.dart';
import 'widgets/event.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Map<String, dynamic> userJson = {}; // didn't use usermodel because of some weird null err..

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final String userString = prefs.getString('user') ?? ''; // need to throw an err
      userJson = jsonDecode(userString);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ApiService api = ApiService();
    final Stream<QuerySnapshot> _goalsStream = api.getGoals(userJson['id']);
    // keeping events untouched because we haven't implemented events yet
    final Stream<QuerySnapshot> _eventsStream = api.getEvents();

    Text buildGreeting() {
      print(userJson);
      DateTime now = DateTime.now();
      DateTime midnight = DateTime(now.year, now.month, now.day, 0, 0);
      DateTime noon = DateTime(now.year, now.month, now.day, 12, 0);
      DateTime evening = DateTime(now.year, now.month, now.day, 17, 0);
  
      if (now.isAfter(midnight) && now.isBefore(noon)) {  
        return Text(
          "Good morning, ${userJson['username']}",
          style: TextStyle(
            fontFamily: GoogleFonts.outfit().fontFamily,
            fontSize: 24
          )
        );
      } else if (now.isAfter(noon) && now.isBefore(evening)) {
        return Text(
          "Good afternoon, ${userJson['username']}",
          style: TextStyle(
            fontFamily: GoogleFonts.outfit().fontFamily,
            fontSize: 24
          )
        );
      } else {
        return Text(
          "Good evening, ${userJson['username']}",
          style: TextStyle(
            fontFamily: GoogleFonts.outfit().fontFamily,
            fontSize: 24
          )
        );
      }
    }

    return Column(children: [
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: buildGreeting()),
      // TODO: UNCOMMENT AFTER DONE WITH EVENTS
      // const SearchBarWidget(),
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Your Events",
              style: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 24
              )
            )
          ],
        )
      ),
      StreamBuilder<QuerySnapshot>(
        stream: _eventsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(style: TextStyle(color: Colors.white), "Unable to get Goals :(");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(style: TextStyle(color: Colors.white), "Loading Goals...");
          }

          return SizedBox(height: 150, child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return EventWidget(id: document.id, title: "${data["title"]}", club: data["club"]);
            }).toList(),
          ));
        }
      ),
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Your Goals", style: TextStyle(fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 24)),
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              HapticFeedback.lightImpact();
              showGeneralDialog(
                barrierLabel: "Label",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 700),
                context: context,
                pageBuilder: (context, anim1, anim2) {
                  return AddGoalWidget();
                },
                transitionBuilder: (context, anim1, anim2, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
                    child: child,
                  );
                },
              );
            }
          )
        ])
      ),

      // modularize this and put this into another class called like displayGoals
      StreamBuilder<QuerySnapshot>(
        stream: _goalsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(style: TextStyle(color: Colors.white), "Unable to get Goals :(");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(style: TextStyle(color: Colors.white), "Loading Goals...");
          }

          return Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return GoalWidget(id: document.id, title: "${data["title"]}");
            }).toList(),
          );
        })
    ]);
  }
}
