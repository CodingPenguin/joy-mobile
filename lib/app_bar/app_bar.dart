import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          // title: Image.asset('assets/logos/questify_1152.png',
          //     width: 40, height: 40, fit: BoxFit.fitHeight));
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}