import 'package:flutter/material.dart';
import 'package:googles/screens/homeScreen.dart';
import 'package:googles/screens/profile.dart';
import 'package:googles/screens/record.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavstate();
}

class _BottomNavstate extends State<BottomNav> {
  int myIndex = 0;

  List tab1 = [const HomeScreen(), const RecordScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: tab1[myIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 232, 235, 238),
          elevation: 30,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mic),
              label: "Record Audio",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.man_outlined),
              label: "Profile",
            )
          ],
        ),
      ),
    );
  }
}
