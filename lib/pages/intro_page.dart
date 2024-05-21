// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:islamyzer/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo

              // Image.asset('lib/images/banner2.jpg'),
              Container(
                width: 500,
                height: 400,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/quran_logo.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
              ),

              const SizedBox(height: 24),

              // title
              Text(
                "JUST DO IT ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              //subtitle
              const SizedBox(height: 4),

              Text(
                "Islamic App For Reverts A Place Where You Find Solitude",
                style: TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              //start new button

              const SizedBox(height: 48),

              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 48, 47, 47),
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      "Let's Learn Quran",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
