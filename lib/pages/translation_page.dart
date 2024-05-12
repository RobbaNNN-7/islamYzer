// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_declarations, prefer_final_fields, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SurahList extends StatefulWidget {
  @override
  _SurahListState createState() => _SurahListState();
}

class _SurahListState extends State<SurahList> {
  late List<dynamic> _surahs;
  late List<dynamic> _filteredSurahs = [];

  TextEditingController _searchController = TextEditingController();

  Future<List<dynamic>> fetchSurahs() async {
    final String username = 'root';
    final String password = 'toor';
    final Uri apiUrl = Uri(
      scheme: 'https',
      host: 'hisham09.pythonanywhere.com',
      path: '/api/quran/surahs/',
    );

    final response = await http.get(
      apiUrl,
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch surahs');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSurahs().then((surahs) {
      setState(() {
        _surahs = surahs;
        _filteredSurahs = surahs;
      });
    });
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _filteredSurahs = _surahs;
        });
      } else {
        setState(() {
          _filteredSurahs = _surahs
              .where((surah) => surah['surah_name']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Set background color to blackish
      appBar: AppBar(
        title: Text(
          'Surah List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[900], // Match background color
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
            },
            icon: Icon(Icons.clear,
                color: const Color.fromARGB(255, 187, 179, 179)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Surah',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSurahs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${_filteredSurahs[index]["surah_name"]}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Surah Number: ${_filteredSurahs[index]["surah_number"]}',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TranslationPage(
                              _filteredSurahs[index]["surah_id"]),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .grey[800], // Change button color to match background
                    ),
                    child: Text(
                      'View Translation',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TranslationPage extends StatelessWidget {
  final int surahId;

  TranslationPage(this.surahId);

  Future<List<dynamic>> fetchTranslations(int surahId) async {
    final String username = 'root';
    final String password = 'toor';
    final Uri apiUrl = Uri(
      scheme: 'https',
      host: 'hisham09.pythonanywhere.com',
      path: '/api/quran/translations/$surahId',
    );

    final response = await http.get(
      apiUrl,
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> translations = json.decode(response.body);
      return translations;
    } else {
      throw Exception('Failed to fetch translations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translation'),
      ),
      backgroundColor: Colors.grey[900], // Set background color to blackish
      body: FutureBuilder(
        future: fetchTranslations(surahId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            List? translations = snapshot.data;
            return ListView.builder(
              itemCount: translations!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      translations[index]["translated_text"],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
