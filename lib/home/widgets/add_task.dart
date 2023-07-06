import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api_service.dart';

class AddTaskWidget extends StatelessWidget {
  final String goalId;
  const AddTaskWidget({Key? key, required this.goalId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiService api = ApiService();
    TextEditingController titleController = TextEditingController();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Color(0xFF282828),
          borderRadius: BorderRadius.circular(40),
        ),
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Column(
              children: [
                Material(
                  color: const Color(0xFF282828),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.black,
                    iconSize: 23.0,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20), // this has to stay if lines 50-57 stay
                        child: TextField(
                          cursorColor: Colors.white,
                          controller: titleController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                            hintText: "Subquest name",
                            hintStyle: TextStyle(
                                color: const Color(0xFFDEDEDE),
                                fontFamily: GoogleFonts.outfit()
                                    .fontFamily,
                                fontSize: 24.0)
                            ),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.outfit().fontFamily,
                            fontSize: 24.0
                          ),
                          enableInteractiveSelection: false,
                        )
                      ),
                      Divider(
                        height: 20,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey,
                      ),
                      Material(
                        color: Color(0x282828),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text("choose a type",
                                style: TextStyle(
                                  fontFamily: GoogleFonts.outfit().fontFamily,
                                  fontSize: 24
                                )
                            ),
                            // HOW DOES CHOOSING A TYPE WORK?
                            ]
                        )
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                    ]
                  )
                ),
                Material(
                  child: Container(
                      color: Color(0xFF282828),
                      child: Row(children: [
                        Expanded(
                          child: TextButton(
                          onPressed: () {
                            api.addTask(FirebaseAuth.instance.currentUser?.uid, goalId, titleController.text);
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                              minimumSize: Size(40, 60),
                              splashFactory: NoSplash.splashFactory,
                              tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.all(0),
                              backgroundColor: const Color(0xFF9BB1FF)),
                          child: Text("Create Task",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily:
                                      GoogleFonts.outfit().fontFamily,
                                  fontSize: 24.0)),
                        )),
                      ]
                    )
                  )
                )
              ]
            )
          )
        ),
      ),
    );
  }
}