import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../api_service.dart';
import 'add_goal.dart';
import 'goal.dart';
import 'search_bar.dart';

import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Text buildGreeting() {
      DateTime now = DateTime.now();
      DateTime midnight = DateTime(now.year, now.month, now.day, 0, 0);
      DateTime noon = DateTime(now.year, now.month, now.day, 12, 0);
      DateTime evening = DateTime(now.year, now.month, now.day, 17, 0);

      if (now.isAfter(midnight) && now.isBefore(noon)) {
        return Text("Good morning, Danny",
            style: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 24));
      } else if (now.isAfter(noon) && now.isBefore(evening)) {
        return Text("Good afternoon, Danny",
            style: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 24));
      } else {
        return Text("Good evening, Danny",
            style: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 24));
      }
    }

    final ApiService api = ApiService();
    final Stream<QuerySnapshot> _tasksStream = api.getTasks();

    return Column(children: [
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: buildGreeting()),
      // TODO: UNCOMMENT AFTER DONE WITH EVENTS
      // const SearchBarWidget(),
      // TODO: UNCOMMENT AFTER DONE WITH GOALS
      // Container(
      //   alignment: Alignment.centerLeft,
      //   margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text("Your Events",
      //         style: TextStyle(
      //           fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 24
      //         )
      //       )
      //     ],
      //   )
      // ),
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
      // ****DONE**** TODO: READ FROM FIREBASE INSTEAD: https://kymoraa.medium.com/to-do-list-app-with-flutter-firebase-7910bc42cf14
      StreamBuilder<QuerySnapshot>(
        stream: _tasksStream,
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
