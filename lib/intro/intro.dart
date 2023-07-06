import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../nav.dart';
import './signup.dart';
import 'login.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = snapshot.data;
        if (user != null) {
          return const Nav();
        }
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            // for the below line: https://stackoverflow.com/questions/44978216/flutter-remove-back-button-on-appbar
            automaticallyImplyLeading: false,
            // title: Image.asset('assets/logos/questify_1152.png',
            //     width: 40, height: 40, fit: BoxFit.fitHeight)),
          ),
          body: Column(children: [
            Image.asset('assets/intro.png', width: 400),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Questify",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontFamily: GoogleFonts.outfit().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30, bottom: 15.0), child: TextButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup())
                      )
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      // splashFactory: NoSplash.splashFactory,
                      // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.all(0),
                      backgroundColor: const Color(0xFF9BB1FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )
                    ),
                    child: Text(
                      "Sign Up", 
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.outfit().fontFamily,
                        fontSize: 24
                      )
                    )
                  )),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: GoogleFonts.outfit().fontFamily,
                      ),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Login())
                        )
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          color: const Color(0xFF9BB1FF)
                        ),
                      ),
                    )
                  ])
                ]
              )
            )
          ])
        );
      }
    );
    //   }
    // );
  }
}
