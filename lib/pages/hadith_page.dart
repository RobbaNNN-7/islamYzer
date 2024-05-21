// ignore_for_file: use_super_parameters, prefer_const_constructors, avoid_web_libraries_in_flutter, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HadithPage extends StatefulWidget {
  const HadithPage({Key? key}) : super(key: key);

  @override
  State<HadithPage> createState() => _HadithPage();
}

class _HadithPage extends State<HadithPage> {
  final List<Map<String, String>> surahs = [
    {
      "name": "Sahih Bukhari",
      "path": "lib/pdf/bukhari.pdf",
      "image": "lib/images/bukhari.jpg"
    },
    {
      "name": "Sahih Muslim",
      "path": "lib/pdf/bukhari.pdf",
      "image": "lib/images/muslim.jpeg"
    },
    {
      "name": "Al-Tirmizi",
      "path": "lib/pdf/bukhari.pdf",
      "image": "lib/images/tirmizi.jpeg"
    },
    {
      "name": "Mishkat-ul-Masabeeh",
      "path": "lib/pdf/bukhari.pdf",
      "image": "lib/images/mishkat.jpg"
    },
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
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            // Search bar
            Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(horizontal: 10),
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
                        hintText: 'Search Hadith...',
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
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
                style: TextStyle(
                    color: Colors.grey[100],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),

            // List of Surah buttons
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredSurahs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to PDF viewer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewerPage(
                              pdfPath: filteredSurahs[index]["path"]!,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width *
                                0.8, // 80% of screen width
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  Colors.grey[900], // Button background color
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                filteredSurahs[index]["name"]!, // Surah name
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Image.asset(
                              filteredSurahs[index][
                                  "image"]!, // Image path for the current Surah
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  PdfViewerPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Hadith',
          style: TextStyle(
              backgroundColor: Colors.transparent, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SfPdfViewer.file(File(pdfPath)),
    );
  }
}
