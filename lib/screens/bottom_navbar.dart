import 'package:flutter/material.dart';
import 'package:quadb_tech/main.dart';
import 'package:quadb_tech/screens/home_screen.dart';
import 'search_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedScreenIndex = 0;

  //item tapped in bottom navbar
  void _onItemTapped(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  List<Widget> screens = [const HomeScreen(), SearchScreen()];

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: screens[_selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          backgroundColor: Colors.grey.shade900.withOpacity(0.5),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
          currentIndex: _selectedScreenIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
