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

class _TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext buildContext) {

    // callback function to determine color of checkbox after a user interaction
    // MIGHT OR MIGHT NOT BE NEEDED
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState> {
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };

      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return const Color(0xFF9BB1FF);
    }

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: const Color(0xFF3F3C3C),
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: Color(0xFF9BB1FF), width: 8)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: GoogleFonts.outfit().fontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
              ),),
              Transform.scale(
                scale: 1.35,
                child: Checkbox(
                  checkColor: const Color(0xFF3F3C3C),
                  // fillColor: MaterialStateColor.resolveWith(getColor), 
                  activeColor: const Color(0xFF9BB1FF),
                  value: isChecked, 
                  shape: const CircleBorder(), 
                  side: const BorderSide(color: Color(0xFF9BB1FF), width: 1),
                  onChanged: (bool? value) {
                    // NEED TO FIGURE OUT HAPPENS WHEN CHECKBOX IS CHECKED. DOES THE TASK DISAPPEAR, 
                    // OR STAY ON THE SCREEN
                    setState(() {
                      isChecked = value!;
                    });
                  }
                )
              ),
            ],
          )
        ),
      )
      )
    );
  }
}

class TasksWidget extends StatelessWidget {
  final String goalId;
  const TasksWidget({Key? key, required this.goalId}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    ApiService api = ApiService();
    final Stream<QuerySnapshot> _tasksStream = api.getTasks(goalId);
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