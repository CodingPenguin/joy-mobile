import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api_service.dart';
import '../../widgets/divider.dart';
import '../../widgets/interactive_text_field.dart';

class AddTaskWidget extends StatefulWidget {
  final String goalId;
  const AddTaskWidget({Key? key, required this.goalId}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}
class _AddTaskWidgetState extends State<AddTaskWidget> {
  // String? _dropdownValue = "career"; // hard coded to career

  @override
  Widget build(BuildContext context) {
    ApiService api = ApiService();
    TextEditingController titleController = TextEditingController();
    // TextEditingController descriptionController = TextEditingController();
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: (2*MediaQuery.of(context).size.height)/3,
        decoration: BoxDecoration(
          color: const Color(0xFF282828),
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
                    color: const Color(0xFFD9D9D9),
                    iconSize: 23.0,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: const Color(0xFF282828),
                      borderRadius: BorderRadius.circular(20), // this has to stay if lines 50-57 stay
                      child: QFInteractiveTextField(
                        initialText: "",
                        hintText: "subquest name",
                        onTextUpdate: (newText) {
                          titleController.text = newText;
                        },
                      ),
                    ),
                    const QFDivider(),
                    // Material(
                    //   color: const Color(0xFF282828),
                    //   child: Padding(
                    //     padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Directionality(
                    //           textDirection: TextDirection.rtl,
                    //           child: DropdownButtonHideUnderline(
                    //             child: 
                    //               DropdownButton(
                    //                 items: const [
                    //                   DropdownMenuItem(value: "career", child: Text("career")),
                    //                   DropdownMenuItem(value: "academic", child: Text("academic")),
                    //                   DropdownMenuItem(value: "personal", child: Text("personal")),
                    //                 ], 
                    //                 onChanged: (String? selectedValue) {
                    //                   setState(() {
                    //                     _dropdownValue = selectedValue;
                    //                   });
                    //                 },
                    //                 value: _dropdownValue,
                    //                 style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 20),
                    //                 dropdownColor: const Color(0xFF282828),
                    //                 icon: const Icon(size: 20, Icons.arrow_drop_down_circle_outlined)
                    //               ),
                    //           ),
                    //         ),
                    //       ]
                    //     ),
                    //   )
                    // ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  ]
                ),
                Card(
                  color: const Color(0xFF9BB1FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                        child: TextButton(
                        onPressed: () {
                          api.addTask(FirebaseAuth.instance.currentUser?.uid, widget.goalId, titleController.text);
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          // minimumSize: const Size(40, 60),
                          splashFactory: NoSplash.splashFactory,
                          tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          backgroundColor: const Color(0xFF9BB1FF)
                        ),
                        child: const Text("create task",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0
                          )
                        ),
                      )),
                    ]
                    ),
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