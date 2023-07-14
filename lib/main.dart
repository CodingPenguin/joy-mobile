import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'nav.dart';
import 'intro/intro.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          bodySmall: TextStyle(

          ),
          bodyMedium: TextStyle(  // regular default font
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(  // large text for quick summary; large numbers; etc.

          ),
          titleSmall: TextStyle(  // titles for sub-sections (e.g. goals)

          ),
          titleMedium: TextStyle(  // large title for front pages (first thing a user should see?)

          ),
          titleLarge: TextStyle(  // large splash text for signups; etc.

          ),
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        scaffoldBackgroundColor: const Color(0xFF282828),
      ),
      title: 'Questify',
      
      // https://stackoverflow.com/questions/68673592/is-this-the-right-way-to-check-if-user-is-logged-in-flutter-firebase
      home: StreamBuilder(
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

          return const Intro();
        }
      ),
    );
  }
}
