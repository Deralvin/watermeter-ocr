import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ScanOcrView extends StatefulWidget {
  @override
  _WaterMeterReaderPageState createState() => _WaterMeterReaderPageState();
}

class _WaterMeterReaderPageState extends State<ScanOcrView> {
  File? _image;
  String _recognizedText = '';

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _performTextRecognition(File(pickedFile.path));
    }
  }

  Future<void> _performTextRecognition(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String allText = recognizedText.text;

    // Sederhana, coba ambil hanya angka dari teks hasil OCR
    RegExp regExp = RegExp(r'\d+');
    Iterable<Match> matches = regExp.allMatches(allText);

    String numbers = matches.map((m) => m.group(0)).join(' ');

    setState(() {
      _recognizedText = numbers.isNotEmpty ? numbers : 'Tidak ditemukan angka';
    });

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pembaca Water Meter')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Ambil Foto Water Meter'),
            ),
            SizedBox(height: 20),
            _image != null ? Image.file(_image!) : Container(),
            SizedBox(height: 20),
            Text('Value Water Meter:'),
            Text(
              _recognizedText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
