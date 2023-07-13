import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/interactive_text_field.dart';
import '../../widgets/rounded_progress_bar.dart';
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

  String? _dropdownValue = "career"; // hard coded to career

  @override
  Widget build(BuildContext context) {

    ApiService api = ApiService();
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 700),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Material(
                textStyle: Theme.of(context).primaryTextTheme.bodyMedium,
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
                          child: QFInteractiveTextField(
                            initialText: widget.title,
                            hintText: "Goal title",
                            onTextUpdate: (newText) {
                              api.updateGoal(widget.id, {'title': newText});
                            },
                          ),
                        ),
                      ),
                      Material(
                        color: const Color(0xFF282828),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        items: const [
                                          DropdownMenuItem(
                                              value: "career",
                                              child: Text("career")),
                                          DropdownMenuItem(
                                              value: "academic",
                                              child: Text("academic")),
                                          DropdownMenuItem(
                                              value: "personal",
                                              child: Text("personal")),
                                        ],
                                        onChanged: (String? selectedValue) {
                                            setState(() {
                                                  _dropdownValue =
                                                      selectedValue;
                                              }
                                            );
                                        },
                                        value: _dropdownValue,
                                        style: const TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 20),
                                        dropdownColor:
                                            const Color(0xFF282828),
                                        icon: const Icon(
                                            size: 20,
                                            Icons
                                                .arrow_drop_down_circle_outlined)),
                                  ),
                                ),
                              ]),
                        )
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
                            QFRoundedProgressBar(
                              value: tasksCompleted,
                              maxValue: tasksTotal,
                            )
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
                        padding: const EdgeInsets.symmetric(vertical: verticalMargin),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "subquests",
                            style: TextStyle(
                              fontSize: 24,
                            ),
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
            );});
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
                      const QFRoundedProgressBar(
                        value: 4,
                        maxValue: 6,
                        height: 10,
                      ),
                    ])),
                    const Expanded(flex: 1, child: ImageIcon(AssetImage('assets/icons/Vector.png'), color: Colors.white)),
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
}