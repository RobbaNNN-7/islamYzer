// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:islamyzer/components/bottom_nav_bar.dart';
import 'package:islamyzer/main.dart';
import 'package:islamyzer/pages/hadith_page.dart';
import 'package:islamyzer/pages/quran_page.dart';
import 'package:islamyzer/pages/quran_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages to display

  final List<Widget> _pages = [
    const QuranPage(),
    const HadithPage(),
    const QuranPlayer()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          MyBottomNavBar(onTabChange: (index) => navigateBottomBar(index)),
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white,
            onPressed: () {},
          );
        }),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
