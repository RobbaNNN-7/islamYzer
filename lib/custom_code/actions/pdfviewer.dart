// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

Future pdfviewer(BuildContext context) async {
  // Add your function code here!
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SfPdfViewer.network(
        'https://www.islamicnet.com/online_quran_pdf/Holy-Quran-Para-1.pdf',
      ),
    ),
  );
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
