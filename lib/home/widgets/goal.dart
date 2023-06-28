import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_service.dart';

class GoalWidget extends StatefulWidget {
  final String id;
  final String title;
  const GoalWidget({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: widget.title);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) { 
        return GestureDetector(
          onTap: () {
            showGeneralDialog(
              barrierLabel: "Label",
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: Duration(milliseconds: 700),
              context: context,
              pageBuilder: (context, anim1, anim2) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 225,
                    decoration: BoxDecoration(
                      color: const Color(0xFF282828),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Material(
                          borderRadius: BorderRadius.circular(20), // this has to stay if lines 50-57 stay
                          child: TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF3F3C3C),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Task Title",
                              hintStyle: TextStyle(
                                color: const Color(0xFFDEDEDE),
                                fontFamily: GoogleFonts.outfit().fontFamily,
                                fontSize: 24.0
                              )
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: GoogleFonts.outfit().fontFamily,
                              fontSize: 24.0
                            ),
                            enableInteractiveSelection: false,
                          )
                        ),    
                        Material(
                          child: Container(
                            color: Color(0xFF282828),
                            child: Row(children: [
                              Expanded(flex: 4, child: TextButton(
                                onPressed: () {
                                  updateTask(widget.id, {'title': titleController.text});
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  minimumSize: Size(40, 60),
                                  splashFactory: NoSplash.splashFactory,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  padding: EdgeInsets.all(0),
                                  backgroundColor: const Color(0xFF9BB1FF)
                                ),
                                child: Text("Update Goal", style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 24.0)),
                              )),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.white),
                                  onPressed: () {
                                    deleteTask(widget.id);
                                    Navigator.of(context).pop();
                                  }
                                )
                              )
                            ])
                          )
                        )
                      ]),
                    )
                  ),
                );
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
                  child: child,
                );
              },
            );
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Card(
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
                    Expanded(flex: 1, child: Image.asset('assets/icons/emoji.png')),
                    Expanded(flex: 3, child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Row(children: [
                        Expanded(flex: 5, child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Padding(padding: EdgeInsets.only(bottom: 5), child: Text(
                            'Progress %',
                            style: TextStyle(
                              fontFamily: GoogleFonts.outfit().fontFamily,
                              fontSize: 16
                            )
                          )),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: LinearProgressIndicator(
                              value: 0.667,
                              minHeight: 10,
                              color: Color(0xFF809CFF),
                              backgroundColor: Colors.white,
                              
                            )
                          )
                        ])),
                        Expanded(flex: 1, child: ImageIcon(AssetImage('assets/icons/Vector.png'), color: Colors.white)),
                        Expanded(flex: 1, child: Text('36', style: TextStyle(fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 16)))
                      ])
                    ]))
                  ],
                )
              )
            )
          )
        );
      }
    );
  }
}