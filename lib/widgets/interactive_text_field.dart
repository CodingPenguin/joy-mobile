import 'package:flutter/material.dart';

class QFInteractiveTextField extends StatelessWidget {
  final TapRegionCallback onExit;
  final String? hintText;

  final TextEditingController controller;
  final scrollController = ScrollController();
  final focusNode = FocusNode();
  final int maxLines;
  final int currentLine = 1;

  QFInteractiveTextField({
    super.key,
    required this.controller,
    this.maxLines = 3,
    required this.hintText,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: controller,
      scrollController: scrollController,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFDEDEDE),
          fontSize: 24.0,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        overflow: TextOverflow.ellipsis, // dead code
      ),
      minLines: 1,
      maxLines: maxLines,
      onTap: () {
        // selects (and auto scrolls all the way down) upon entering the text field
        controller.selection = TextSelection.collapsed(offset: controller.text.length);
      },
      onTapOutside: (e) {
        onExit(e);

        // scrolls back up upon exiting the text field
        FocusScope.of(context).requestFocus(focusNode);
        scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
        focusNode.unfocus();

        // closes keyboard when tap elsewhere
        //FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}

