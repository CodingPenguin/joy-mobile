import 'package:flutter/material.dart';
import 'constants.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.language_rounded), label: 'Geocommunity'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.arrow_outward_rounded), label: 'Stats'),
    const BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onTabTapped,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          selectedItemColor: const Color(0xFFFFFFFF), // Color(0xFFf76c00),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: items,
          backgroundColor: const Color(0xFF282828),
        ));
  }
}
