import 'package:flutter/material.dart';
import '../constants.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int _selectedIndex = 1;
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today), label: 'Calendar'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.leaderboard), label: 'Leaderboard'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
            title: Image.asset('assets/logos/MWHAHAH.png',
                width: 40, height: 40, fit: BoxFit.fitHeight)),
        body: Center(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onTabTapped,
          unselectedItemColor: const Color(0xFFE86500),
          selectedItemColor: const Color(0xFFe69d65), // Color(0xFFf76c00),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: items,
          backgroundColor: Colors.black,
        ));
  }
}
