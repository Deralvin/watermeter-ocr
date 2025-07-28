import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CameraWithBox extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraWithBox({super.key, required this.cameras});

  @override
  State<CameraWithBox> createState() => _CameraWithBoxState();
}

class _CameraWithBoxState extends State<CameraWithBox> {
  late CameraController _controller;
  bool _isCameraInitialized = false;
  TextEditingController recognizedController = TextEditingController();
  // Bounding box size
  final double boxLeft = 50;
  final double boxTop = 150;
  final double boxWidth = 210;
  final double boxHeight = 60;
  File? croppedFile;
  String _recognizedText = '';
  @override
  void initState() {
    super.initState();
    initCamera();
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
      recognizedController.text = _recognizedText;
    });

    textRecognizer.close();
  }

  Future<void> initCamera() async {
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
    );
    await _controller.initialize();
    await _controller.setFlashMode(FlashMode.off);
    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  Future<void> captureImageInBox() async {
    try {
      final file = await _controller.takePicture();
      final imageBytes = await File(file.path).readAsBytes();
      final original = img.decodeImage(imageBytes);

      if (original == null) return;

      final previewSize = _controller.value.previewSize!;
      final scaleX = original.width / previewSize.height;
      final scaleY = original.height / previewSize.width;

      final cropX = (180).toInt();
      final cropY = (600 * scaleY).toInt();
      final cropW = (350).toInt();
      final cropH = (boxHeight * scaleY).toInt();

      final cropped = img.copyCrop(original,
          x: cropX, y: cropY, width: cropW, height: cropH);
      final croppedBytes = Uint8List.fromList(img.encodeJpg(cropped));

      final dir = await getTemporaryDirectory();
      final datacropped = File('${dir.path}/{${DateTime.now()}}.jpg');
      await datacropped.writeAsBytes(croppedBytes);

      if (!mounted) return;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => PreviewImage(imageFile: croppedFile),
      //   ),
      // );

      setState(() {
        croppedFile = datacropped;
        _performTextRecognition(croppedFile!);
      });
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CameraPreview(_controller),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 210,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 3),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: FloatingActionButton(
                      onPressed: captureImageInBox,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
              if (croppedFile != null) Image.file(croppedFile!),
              Text("Text Recognized $_recognizedText"),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                child: TextFormField(
                  controller: recognizedController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: 'Inputkan Watermeter'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PreviewImage extends StatelessWidget {
  final File imageFile;

  const PreviewImage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cropped Result')),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
