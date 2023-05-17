import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'info.dart';
import 'package:flip_card/flip_card.dart';
import 'Messages.dart';

import 'home.dart';
import 'settingscreen.dart';

void main() => runApp(MyAPPP());

class MyAPPP extends StatefulWidget {
  @override
  _MyAPPPState createState() => _MyAPPPState();
}

class _MyAPPPState extends State<MyAPPP> {
  List<Widget> pages = [
    //UserInformation(),
    UserInformation(),
    Messages(),
    Setting(),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //If you want to show body behind the navbar, it should be true
        extendBody: true,
        body: pages[_index],
        bottomNavigationBar: FloatingNavbar(
          width: double.infinity,
          backgroundColor: Colors.blue.shade900,
          onTap: (int val) => setState(() => _index = val),
          currentIndex: _index,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.chat, title: 'Messages'),
            FloatingNavbarItem(
                icon: Icons.account_circle_rounded, title: 'profile'),
          ],
        ),
      ),
    );
  }
}
