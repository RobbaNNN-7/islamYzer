// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import, prefer_const_literals_to_create_immutables, use_super_parameters

import 'package:flutter/material.dart';
import 'package:islamyzer/components/bottom_nav_bar.dart';
import 'package:islamyzer/pages/hadith_page.dart';
import 'package:islamyzer/pages/quran_full.dart';
import 'package:islamyzer/pages/quran_page.dart';
import 'package:islamyzer/pages/quran_player.dart';
import 'package:islamyzer/pages/translation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

  final List<Widget> _pages = [
    SurahListPage(),
    HadithPage(),
    QuranPlayer(),
    SurahList(),
    QuranFull(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          MyBottomNavBar(onTabChange: (index) => navigateBottomBar(index)),
      backgroundColor: Color.fromARGB(115, 65, 62, 62),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 190, 171, 171),
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //logo
            Column(
              children: [
                DrawerHeader(
                  child: Image.asset(
                    'lib/images/quran_logo.png',
                    color: Colors.white,
                  ),
                ),

                // divider
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10),
                  child: Divider(color: Colors.grey[900]),
                ),

                // Home Tab
                ListTile(
                  leading: Icon(
                    Icons.library_books_rounded,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Surah List",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Navigate to Home Page
                    Navigator.pop(context); // Close Drawer
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),

                // Quran Page
                ListTile(
                  leading: Icon(
                    Icons.menu_book,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Hadith Page",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Navigate to Quran Page
                    Navigator.pop(context); // Close Drawer
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),

                // Hadith Page
                ListTile(
                  leading: Icon(
                    Icons.queue_music_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Quran Player",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Navigate to Hadith Page
                    Navigator.pop(context); // Close Drawer
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.receipt_long,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Quran Page",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Navigate to Hadith Page
                    Navigator.pop(context); // Close Drawer
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.earbuds_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Translation Page",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Navigate to Hadith Page
                    Navigator.pop(context); // Close Drawer
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                ),
              ],
            ),

            // Quit
            ListTile(
              leading: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.white,
              ),
              title: Text(
                "QUIT",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Handle Quit action
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
