import 'package:flutter/material.dart';
import 'package:kelompok19lmsproject/screen/favorite_screen.dart';
import 'package:kelompok19lmsproject/screen/homescreen.dart';
import 'package:kelompok19lmsproject/screen/mycourse_screen.dart';
import 'package:kelompok19lmsproject/screen/profile_screen.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _Index();
}

class _Index extends State<Index> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    MyCourse(),
    Favorite(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(canvasColor: Colors.yellow),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined), label: 'My Course'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      body: Center(
        child: _children.elementAt(_selectedIndex),
      ),
    );
  }
}
