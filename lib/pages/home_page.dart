// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import, prefer_const_literals_to_create_immutables

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
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
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
                )),

                // divider

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10),
                  child: Divider(color: Colors.grey[900]),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "HOME TAB",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                // 2nd slide

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.menu_book_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      "QURAN PAGE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                // 3rd

                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.library_books,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Hadith Page",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app_sharp,
                  color: Colors.white,
                ),
                title: Text(
                  "QUIT",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
