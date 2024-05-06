// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
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

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  // navigated to pdf view
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFviewer(
                            url:
                                "https://www.islamicnet.com/online_quran_pdf/Holy-Quran-Para-1.pdf"),
                      ));
                },
                child: Text("Surah Fatiha")),

            // 2nd button

            ElevatedButton(
                onPressed: () {
                  // navigated to pdf view
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFviewer(
                            url:
                                "https://www.islamicnet.com/online_quran_pdf/Holy-Quran-Para-1.pdf"),
                      ));
                },
                child: Text("Surah Baqarah")),

            ElevatedButton(
                onPressed: () {
                  // navigated to pdf view
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFviewer(
                            url:
                                "https://www.islamicnet.com/online_quran_pdf/Holy-Quran-Para-1.pdf"),
                      ));
                },
                child: Text("Surah Aal-Imran")),
          ], // end pdf viwer
        )
      ],
    );
  }
}

class PDFviewer extends StatelessWidget {
  const PDFviewer({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDF().cachedFromUrl(
        url,
        placeholder: (progress) => Center(
          child: Text('$progress %'),
        ),
        errorWidget: (error) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
