import 'package:flutter/material.dart';

class QFDivider extends StatelessWidget {
  const QFDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
      thickness: 2,
      indent: 0,
      endIndent: 0,
      color: Color(0xFF4B4B4B),
    );
  }
}
