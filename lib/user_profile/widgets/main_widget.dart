import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../intro/intro.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
        // this is causing some kind of black screen bug, but i'm not sure how to fix it.
        // Navigator.of(context).pop(); 

        // so instead, i'm doing this. but it 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Intro())
        );
        print('PRESSED SIGNED OUT');
      },
      child: Text(
        'Sign out',
        style: TextStyle(color: Colors.white, fontSize: 24)
      )
    );
  }
}