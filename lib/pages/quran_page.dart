// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

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
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"},
    {"name": "Surah Fatiha", "path": "lib/pdf/Holy-Quran-Para-1.pdf"}
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // search bar
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search",
                style: TextStyle(color: Colors.grey[100]),
              ),
              Icon(
                Icons.search,
                color: Colors.grey[100],
              ),
            ],
          ),
        ),

        //  message
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Text("بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ",
              style: TextStyle(color: Colors.grey[100])),
        ),

        /**
         * 
         * QURAN PDF VIEWER OF EVERY SURAH
        */

        Expanded(
          child: ListView.builder(
            itemCount: surahs.length,
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
                          File('lib\\pdf\\Holy-Quran-Para-1.pdf'),
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.grey[900]!, // Change the button color here
                    ),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 36, horizontal: 24)),
                  ),
                  child: Text(
                    surahs[index]["name"]!,
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

// class PDFviewer extends StatelessWidget {
//   const PDFviewer({super.key, required this.url});

//   final String url;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PDF().cachedFromUrl(
//         url,
//         placeholder: (progress) => Center(
//           child: Text('$progress %'),
//         ),
//         errorWidget: (error) => Center(
//           child: Text(error.toString()),
//         ),
//       ),
//     );
//   }
// }
