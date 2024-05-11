// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  final List<Map<String, String>> surahs = [
    {"name": "Surah Fatiha", "path": "lib\\pdf\\Holy-Quran-Para-1.pdf"},
    {"name": "Surah Baqarah", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Aal-Imraan", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Nisa", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
  ];

  late List<Map<String, String>> filteredSurahs = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredSurahs = surahs;
  }

  void filterSurahs(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSurahs = surahs;
      } else {
        filteredSurahs = surahs
            .where((surah) =>
                surah["name"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: filterSurahs,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search Surahs...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Message
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Text(
            "بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ",
            style: TextStyle(color: Colors.grey[100]),
          ),
        ),

        // List of Surah buttons
        Expanded(
          child: ListView.builder(
            itemCount: filteredSurahs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to PDF viewer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SfPdfViewer.file(
                          File(filteredSurahs[index]["path"]!),
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.grey[900]!, // Button color
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(
                          vertical: 35, horizontal: 30), // Button padding
                    ),
                  ),
                  child: Text(
                    filteredSurahs[index]["name"]!,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
