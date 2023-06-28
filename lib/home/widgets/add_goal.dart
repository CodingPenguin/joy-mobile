import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api_service.dart';

class AddGoalWidget extends StatefulWidget {
  const AddGoalWidget({Key? key}) : super(key: key);

  @override
  State<AddGoalWidget> createState() => _AddGoalWidgetState();
}

class _AddGoalWidgetState extends State<AddGoalWidget> {
  @override
  Widget build(BuildContext buildContext) {
    ApiService api = ApiService();
    TextEditingController titleController = TextEditingController();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: Color(0xFF282828),
          borderRadius: BorderRadius.circular(40),
        ),
        child: SizedBox.expand(child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset('assets/icons/emoji.png'),
              Material(
                borderRadius: BorderRadius.circular(20), // this has to stay if lines 50-57 stay
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF282828),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Goal Title",
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
            ])),
            Material(
              child: Container(
                color: Color(0xFF282828),
                child: Row(children: [
                  Expanded(child: TextButton(
                    onPressed: () {
                      api.addTask(titleController.text);
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(40, 60),
                      splashFactory: NoSplash.splashFactory,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.all(0),
                      backgroundColor: const Color(0xFF9BB1FF)
                    ),
                    child: Text("Add Goal", style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.outfit().fontFamily, fontSize: 24.0)),
                  )),
                ])
              )
            )
          ])   
        )),
      ),
    );
  }
}