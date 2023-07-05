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