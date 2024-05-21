// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, avoid_print, prefer_const_declarations

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class QuranPlayer extends StatefulWidget {
  @override
  _QuranPlayerState createState() => _QuranPlayerState();
}

class _QuranPlayerState extends State<QuranPlayer> {
  List surahs = [];
  String? selectedSurahId;
  AudioPlayer audioPlayer = AudioPlayer();
  List<String> audioUrls = [];
  int currentVerseIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchSurahs();
    audioPlayer.onPlayerComplete.listen((event) {
      playNextVerse();
    });
  }

  Future<void> fetchSurahs() async {
    final url = Uri(
      scheme: 'https',
      host: 'hisham09.pythonanywhere.com',
      path: '/api/quran/surahs/',
    );
    final response = await http.get(url, headers: {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('root:toor'))
    });

    if (response.statusCode == 200) {
      setState(() {
        surahs = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load surahs');
    }
  }

  Future<void> fetchAndPlayRecitation(String surahId) async {
    try {
      final url = Uri(
        scheme: 'https',
        host: 'hisham09.pythonanywhere.com',
        path: '/api/quran/recitations/$surahId',
      );

      final response = await http.get(url, headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('root:toor'))
      });

      if (response.statusCode == 200) {
        List recitations = json.decode(response.body);
        if (recitations.isNotEmpty) {
          setState(() {
            audioUrls = recitations
                .map<String>(
                    (recitation) => recitation['audio_file_url'] as String)
                .toList();
            currentVerseIndex = 0;
          });
          playNextVerse();
        } else {
          print('No recitations found for the selected Surah.');
        }
      } else {
        throw Exception('Failed to load recitation');
      }
    } catch (e) {
      print('Error fetching recitation: $e');
    }
  }

  void playNextVerse() async {
    if (currentVerseIndex < audioUrls.length) {
      final audioUrl = audioUrls[currentVerseIndex];
      print('Playing verse ${currentVerseIndex + 1}: $audioUrl');
      await audioPlayer.play(UrlSource(audioUrl));
      setState(() {
        currentVerseIndex++;
      });
    }
  }

  void stopAudio() async {
    await audioPlayer.stop();
    // setState(() {
    //   currentVerseIndex = 0;
    //   audioUrls.clear();
    // });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Quran Recitation Player',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (surahs.isNotEmpty)
              DropdownButton<String>(
                // itemHeight: kMinInteractiveDimension,
                dropdownColor: Colors.transparent,
                isExpanded: true,
                hint: Text(
                  'Select Surah',
                  style: TextStyle(color: Colors.white),
                ),
                value: selectedSurahId,
                onChanged: (newValue) {
                  setState(() {
                    selectedSurahId = newValue;
                  });
                },
                items: surahs.map<DropdownMenuItem<String>>((surah) {
                  return DropdownMenuItem<String>(
                    value: surah['surah_id'].toString(),
                    child: Text(
                      surah['surah_name'],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (selectedSurahId != null) {
                  fetchAndPlayRecitation(selectedSurahId!);
                }
              },
              child: Text('Play Recitation'),
            ),
            SizedBox(height: 10),
            if (currentVerseIndex > 0)
              ElevatedButton(
                onPressed: stopAudio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Pause'),
              ),
          ],
        ),
      ),
    );
  }
}
