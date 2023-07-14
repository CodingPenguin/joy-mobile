import 'package:flutter/material.dart';

class QFInteractiveTextField extends StatelessWidget {
  final void Function(String newText) onTextUpdate;
  final String? hintText;

  final TextEditingController controller;
  String persistentText;
  final String initialText;
  final scrollController = ScrollController();
  final focusNode = FocusNode();
  final int maxLines;
  final TextStyle style;
  final TextStyle hintStyle;

  QFInteractiveTextField({
    super.key,
    required this.initialText,
    this.maxLines = 3,
    required this.hintText,
    required this.onTextUpdate,
    this.style = const TextStyle(
      color: Colors.white,
      fontSize: 24.0,
    )
  })
      : controller = TextEditingController(text: initialText),
        persistentText = initialText,
        hintStyle = style.copyWith(color: const Color(0xFFDEDEDE));

  void textUpdate(String newText) {
    if(persistentText != newText) {
      onTextUpdate(newText);
      persistentText = newText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.done,
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
        hintStyle: hintStyle,
      ),
      style: style,
      minLines: 1,
      maxLines: maxLines,
      onTap: () {
        if(!focusNode.hasPrimaryFocus) {
          // selects (and auto scrolls all the way down) upon entering the text field
          controller.selection = TextSelection.collapsed(offset: controller.text.length);
        }
      },
      onTapOutside: (_) {
        textUpdate(controller.text);

        // scrolls back up upon exiting the text field & closes keyboard
        FocusScope.of(context).requestFocus(focusNode);
        scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
        focusNode.unfocus();
      },
      onSubmitted: (newText) {
        textUpdate(newText);

        FocusScope.of(context).requestFocus(focusNode);
        scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
        focusNode.unfocus();
      },
    );
  }
}

