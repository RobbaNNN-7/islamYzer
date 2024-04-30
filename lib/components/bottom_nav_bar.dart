// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;

  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GNav(
            color: Color.fromARGB(255, 76, 75, 75),
            activeColor: const Color.fromARGB(255, 255, 255, 255),
            tabActiveBorder: Border.all(color: Colors.white),
            tabBackgroundColor: Colors.grey.shade100,
            onTabChange: (value) => onTabChange!(value),
            tabs: [
          GButton(
            icon: Icons.my_library_books,
            text: 'Quran',
            textColor: Colors.black,
            iconColor: Colors.white,
            iconActiveColor: Colors.grey[900],
          ),
          GButton(
            icon: Icons.menu_book,
            text: 'Hadith',
            textColor: Colors.black,
            iconColor: Colors.white,
            iconActiveColor: Colors.grey[900],
          ),
          GButton(
            icon: Icons.queue_music,
            text: 'Quran Player',
            iconColor: Colors.white,
            textColor: Colors.black,
            iconActiveColor: Colors.grey[900],
          )
        ]));
  }
}
