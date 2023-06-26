import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskWidget extends StatefulWidget {
  final String id;
  final String title;
  const TaskWidget({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) { 
        return SizedBox(
          height: 75,
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20.0),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFFDEDEDE)),
              borderRadius: BorderRadius.circular(15),
            ),
            color: const Color(0xFF121212),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(unselectedWidgetColor: Color(0xAADEDEDE)),
                    child: Checkbox(
                      checkColor: Color(0xFFDEDEDE),
                      activeColor: Color(0xFFE86500),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    )
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: GoogleFonts.outfit().fontFamily,
                      fontSize: 18
                    )
                  )
                ],
              )
            )
          )
        );
      }
    );
  }
}