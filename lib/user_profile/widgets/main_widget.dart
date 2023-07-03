import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pop();
      },
      child: Text(
        'Sign out',
        style: TextStyle(color: Colors.white, fontSize: 24)
      )
    );
  }
}