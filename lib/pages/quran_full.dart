// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class QuranFull extends StatefulWidget {
  const QuranFull({super.key});

  @override
  State<QuranFull> createState() => _QuranFullState();
}

class _QuranFullState extends State<QuranFull> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Message
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Text(
            "القرآن الكريم",
            style: TextStyle(
              color: Colors.grey[100],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        // Quran image with PDF viewer
        GestureDetector(
          onTap: () {
            // Navigate to PDF viewer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SfPdfViewer.file(
                  File('lib/pdf/Holy-Quran-Para-1.pdf'),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Container(
              width: 400,
              height: 450,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/test.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        )
      ],
    );
  }
}
