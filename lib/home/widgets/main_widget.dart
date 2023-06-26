import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../api_service.dart';
import 'task_widget.dart';
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
                fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 22));
      } else if (now.isAfter(noon) && now.isBefore(evening)) {
        return Text("Good afternoon, Danny",
            style: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 22));
      } else {
        return Text("Good evening, Danny",
            style: TextStyle(
                fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 22));
      }
    }

    final ApiService api = ApiService();

    final Stream<QuerySnapshot> _tasksStream = api.getTasks();
    void addTaskWidget(String title) {
      // tasks.add(TaskWidget(title: title));
      api.addTask(title);
    }

    return Column(children: [
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: buildGreeting()),
      const SearchBarWidget(),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Your Tasks",
                style: TextStyle(
                    fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 22)),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                HapticFeedback.lightImpact();
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                          backgroundColor: Colors.transparent,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Padding(padding: EdgeInsets.only(left: 10, bottom: 5.0), child: Text("task title", style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 18.0), textAlign: TextAlign.left,)),
                                  TextField(
                                      onSubmitted: (String txt) {
                                        addTaskWidget(txt);
                                        Navigator.of(context).pop();
                                      },
                                      autofocus: true,
                                      cursorColor: const Color(0xFFE86500),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFF121212),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xFFDEDEDE)),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xFFDEDEDE)),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          hintText:
                                              'workout, study, call mom...',
                                          hintStyle: TextStyle(
                                              color: const Color(0xFFDEDEDE),
                                              fontFamily: GoogleFonts.outfit()
                                                  .fontFamily,
                                              fontSize: 16.0),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 10.0)),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                              GoogleFonts.outfit().fontFamily,
                                          fontSize: 16.0))
                                ])
                          ]);
                    });
              },
              color: Colors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
          ])),

      // ****DONE**** TODO: READ FROM FIREBASE INSTEAD: https://kymoraa.medium.com/to-do-list-app-with-flutter-firebase-7910bc42cf14
      StreamBuilder<QuerySnapshot>(
        stream: _tasksStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(style: TextStyle(color: Colors.white), "Unable to get Tasks :(");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(style: TextStyle(color: Colors.white), "Loading Tasks...");
          }

          return Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return TaskWidget(id: document.id, title: "${data["title"]}");
            }).toList(),
          );
        })
    ]);
  }
}
