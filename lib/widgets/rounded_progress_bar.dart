import 'package:flutter/cupertino.dart';

class QFRoundedProgressBar extends StatefulWidget {
  final int maxValue;
  final int initialValue;

  const QFRoundedProgressBar({Key? key, required this.maxValue, this.initialValue = 0}) : super(key: key);

  @override
  State<QFRoundedProgressBar> createState() => _QFRoundedProgressBarState();
}

class _QFRoundedProgressBarState extends State<QFRoundedProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  width: constraints.maxWidth * (widget.initialValue/widget.maxValue),
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
    );
  }
}