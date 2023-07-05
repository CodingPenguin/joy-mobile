import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';
import '../nav.dart';
import '../home/home.dart';
import '../models/user.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // EYE ICON CLICK CAUSES THIS TO APPEAR AND IT'S WEIRD. 
        // if (snapshot.connectionState != ConnectionState.active) {
        //   return Center(child: CircularProgressIndicator());
        // }
        final user = snapshot.data;
        if (user != null) {
          print("user is logged in! this is from signup.dart");
          print(user);
          return const Nav();
        }
        
        print("user is NOT logged in!");
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            // title: Image.asset('assets/logos/questify_1152.png',
            //     width: 40, height: 40, fit: BoxFit.fitHeight)),
          ),
          body: Column(children: [
            Image.asset('assets/stars_signup.png', height: MediaQuery.of(context).size.height / 6),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "start your journey, now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: GoogleFonts.outfit().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // THIS IS THE USERNAME TEXTFIELD. IT IS NOT REQUIRED RIGHT NOW.
                  // JUST USE EMAIL AND PASSWORD TO REGISTER.
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0), 
                    child: TextField(
                      cursorColor: Colors.white,
                      autocorrect: false,
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.white.withOpacity(0.2)
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.white.withOpacity(0.2)
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.white.withOpacity(0.2)
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'username',
                        hintStyle: TextStyle(
                          color: Color(0xFFDEDEDE),
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontSize: 18
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0), 
                    child: TextField(
                      cursorColor: Colors.white,
                      autocorrect: false,
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.white.withOpacity(0.2)
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.white.withOpacity(0.2)
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.white.withOpacity(0.2)
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'email address',
                        hintStyle: TextStyle(
                          color: Color(0xFFDEDEDE),
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontSize: 18
                        ),
                      ),
                    )
                  ),
                  TextField(
                    controller: passwordController,
                    cursorColor: Colors.white,
                    autocorrect: false,
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                          color: Colors.white.withOpacity(0.2)
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                          color: Colors.white.withOpacity(0.2)
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),                  
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                          color: Colors.white.withOpacity(0.2)
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'password',
                      hintStyle: TextStyle(
                        color: Color(0xFFDEDEDE),
                        fontFamily: GoogleFonts.outfit().fontFamily,
                        fontSize: 18
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                          color: Colors.white,
                        ),
                        splashColor: Colors.transparent,
                        onPressed: () {
                          setState( () {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      )
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15.0), child: TextButton(
                    onPressed: () async {
                      final createdUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text
                      );
                      final user = UserModel(
                        id: FirebaseAuth.instance.currentUser?.uid,
                        geoId: "UCI", // hardcoded right now
                        createdAt: DateTime.now(),
                        username: usernameController.text,
                        firstName: 'nothing', // hardcoded right now
                        lastName: 'no last', // hardcoded right now
                        bio: 'bio..', // hardcoded right now
                        rank: 'rank', // hardcoded right now
                        xp: 0 // hardcoded right now
                      );
                      apiService.addUser(user);
                      final prefs = await SharedPreferences.getInstance();
                      setState(() {
                        final String _userString = jsonEncode(user);
                        prefs.setString('user', _userString);
                      });
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                      splashFactory: NoSplash.splashFactory,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: const Color(0xFF9BB1FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )
                    ),
                    child: Text(
                      "create account", 
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.outfit().fontFamily,
                        fontSize: 24
                      )
                    )
                  )),
              ])
            )
          ])
        );
      }
    );
  }
}
