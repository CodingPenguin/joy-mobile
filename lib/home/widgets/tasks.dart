import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskWidget extends StatefulWidget {
  final String id;
  final String title;
  const TaskWidget({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

// class _TaskWidgetState extends State<TaskWidget> {

// }

class _TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext buildContext) {
    
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color(0xFF3F3C3C),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
        child: Row(
          children: [
            Expanded(flex: 3, child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: GoogleFonts.outfit().fontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                )
              ),
            ])),
            Checkbox(
              value: isChecked, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              onChanged: (bool? value) {
                // NEED TO FIGURE OUT HAPPENS WHEN CHECKBOX IS CHECKED. DOES THE TASK DISAPPEAR, 
                // OR STAY ON THE SCREEN
                setState(() {
                  isChecked = value!;
                });
              }
            )
          ],
        )
      )
    );
  }
}

class TasksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    ApiService api = ApiService();
    final Stream<QuerySnapshot> _tasksStream = api.getTasks();
    return SingleChildScrollView(child: StreamBuilder<QuerySnapshot>(
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
        }));
  }
}