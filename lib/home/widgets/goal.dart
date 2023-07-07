import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_goal.dart';
import 'add_task.dart';
import 'tasks.dart';
import '../../api_service.dart';

class GoalWidget extends StatefulWidget {
  final String id;
  final String title;
  const GoalWidget({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  static const double verticalMargin = 5.0;  // of the entire top UI

  IconData goalIcon = Icons.confirmation_num;  // TODO: change to a more flexible type? instead of the builtin flutter type
  int tasksCompleted = 4;
  int tasksTotal = 10;
  int streaks = 8;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: widget.title);

    ApiService api = ApiService();

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
                return Material(
                  textStyle: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w700
                  ),
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF282828),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: ListView(children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.white70,
                            iconSize: 23.0,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              goalIcon,
                              size: 88.0,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: verticalMargin),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              // ***DONE*** TODO: text wrapping mechanism
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: titleController,
                                decoration: const InputDecoration(
                                  hintText: "Goal Title",
                                  hintStyle: TextStyle(
                                    color: Color(0xFFDEDEDE),
                                    fontSize: 24.0,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  overflow: TextOverflow.ellipsis, // dead code
                                ),
                                maxLines: null,
                                onTapOutside: (PointerDownEvent pointerDownEvent) {
                                  // closes keyboard when tap elsewhere
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  api.updateGoal(widget.id, {'title': titleController.text});
                                },
                              ),
                            ),
                          ),
                          // PROGRESS INDICATOR GENERAL UI
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: verticalMargin),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${((tasksCompleted/tasksTotal)*100).toInt()}%",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(255, 255, 255, 1.0),
                                        ),
                                      ),
                                      Text(
                                        "$tasksCompleted/$tasksTotal tasks",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(255, 255, 255, 0.5),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // CUSTOM ROUNDED PROGRESS INDICATOR
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                                  height: 23.0,
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return Stack(
                                        children: [
                                          Positioned( // BACKGROUND
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(29.0)),
                                                color: Color(0xFFD9D9D9),
                                              ),
                                            ),
                                          ),
                                          Positioned( // FOREGROUND
                                            child: Container(
                                              width: constraints.maxWidth * (tasksCompleted/tasksTotal),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(29.0)),
                                                color: Color(0xFF809CFF),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: verticalMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9.0),
                                    border: Border.all(
                                      color: const Color.fromRGBO(255, 255, 255, 0.25),
                                      width: 3.0,
                                    ),
                                  ),
                                  height: 64,
                                  width: 95,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5.0),
                                        child: const ImageIcon(
                                          AssetImage("assets/icons/Vector.png"),
                                          color: Color.fromRGBO(255, 255, 255, 1.0),
                                          size: 30.0,
                                        ),
                                      ),
                                      Text(
                                        "$streaks",
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9.0),
                                    border: Border.all(
                                      color: const Color.fromRGBO(255, 255, 255, 0.25),
                                      width: 3.0,
                                    ),
                                  ),
                                  height: 64,
                                  width: 95,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "$tasksCompleted",
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "done",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(255, 255, 255, 0.75),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9.0),
                                    border: Border.all(
                                      color: const Color.fromRGBO(255, 255, 255, 0.25),
                                      width: 3.0,
                                    ),
                                  ),
                                  height: 64,
                                  width: 95,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "${tasksTotal-tasksCompleted}",
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "to go",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(255, 255, 255, 0.75),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("subquests",
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.outfit().fontFamily,
                                      fontSize: 24)
                              ),
                              Material(
                                shape: CircleBorder(),
                                child: Ink(
                                  width: 35,
                                  height: 35,
                                  decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: Color(0xFF9BB1FF),
                                  ),
                                  child: IconButton(onPressed: () {
                                    HapticFeedback.lightImpact();
                                    showGeneralDialog(
                                      barrierLabel: "Label",
                                      barrierDismissible: true,
                                      barrierColor: Colors.black.withOpacity(0.5),
                                      transitionDuration: Duration(milliseconds: 700),
                                      context: context, 
                                      pageBuilder: (context, anim1, anim2) {
                                        return AddTaskWidget(goalId: widget.id);
                                      },
                                      transitionBuilder: (context, anim1, anim2, child) {
                                            return SlideTransition(
                                              position: Tween(
                                                      begin: Offset(0, 1),
                                                      end: Offset(0, 0))
                                                  .animate(anim1),
                                              child: child,
                                            );
                                          },
                                    );
                                  }, 
                                  icon: const Icon(color: Colors.white, size: 20, Icons.add),
                                  )
                                ),
                              )
                            ]),
                          ),
                          TasksWidget(goalId: widget.id)
                        ]),
                      )
                    ),
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
                          Padding(padding: EdgeInsets.only(bottom: 5), child: Align(alignment: Alignment.centerLeft, child: Text(
                            'Progress %',
                            style: TextStyle(
                              fontFamily: GoogleFonts.outfit().fontFamily,
                              fontSize: 16
                            )
                          ))),
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