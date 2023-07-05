import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';
import '../models/user.dart';
import '../nav.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ApiService api = ApiService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  Future<void> signIn() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text
    );

    Map<String, dynamic> user = await api.getUser(FirebaseAuth.instance.currentUser?.uid);
    print("user from api.getUser $user");
    user['createdAt'] = user['createdAt'].toDate().toString();
    print("user from api.getUser AFTER parse $user");
    UserModel userModel = UserModel.fromJson(user);
    print("user from userModel $userModel");
    Map<String, dynamic> userJson = userModel.toJson();
    print("user from userJson $userJson");

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final String _userString = jsonEncode(userJson);
      print("user _userString $_userString");
      prefs.setString('user', _userString);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          print("user is logged in! this is from login.dart");
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
                    "welcome back, explorer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: GoogleFonts.outfit().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0), 
                    child: TextField(
                      cursorColor: Colors.white,
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
                      try {
                        signIn();
                        // return Home();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                        throw('somethin');
                      }
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
                      "sign in", 
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
