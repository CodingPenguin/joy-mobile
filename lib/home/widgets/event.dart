import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_service.dart';

class EventWidget extends StatefulWidget {
  final String id;
  final String title;
  final Map<String, dynamic> club;
  const EventWidget({Key? key, required this.id, required this.title, required this.club}) : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: widget.title);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) { 
        return GestureDetector(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width / 2,
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xFF3F3C3C),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Align(alignment: Alignment.topRight, child: Image.asset('assets/icons/urgency.png')),
                    Padding(padding: EdgeInsets.only(bottom: 5), child: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: GoogleFonts.outfit().fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    )),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        widget.club['name'],
                        style: TextStyle(
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontSize: 12
                        )
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF9BB1FF)
                        ),
                        child: Padding(padding: EdgeInsets.all(5), child: Text(
                          '3 days left',
                          style: TextStyle(
                            fontFamily: GoogleFonts.outfit().fontFamily,
                            fontSize: 12
                          )
                        ))
                      ),
                    ],)
                    
                ])
              )
            )
          )
        );
      }
    );
  }
}