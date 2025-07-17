import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class OcrSclabaleView extends StatefulWidget {
  const OcrSclabaleView({
    super.key,
  });

  @override
  State<OcrSclabaleView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OcrSclabaleView> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  String recognizeText = "";
  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras!.first,
      ResolutionPreset.max,
      enableAudio: false,
    );
    await _controller!.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  /// Ukuran bounding box di layar
  final double boxWidth = 250;
  final double boxHeight = 250;

  Future<void> takePictureAndCrop() async {
    if (!_controller!.value.isInitialized) return;
    if (_controller!.value.isTakingPicture) return;

    try {
      XFile file = await _controller!.takePicture();
      File imageFile = File(file.path);

      // Load image with package image for crop
      Uint8List imageBytes = await imageFile.readAsBytes();
      img.Image? originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) return;

      // Dapatkan ukuran preview kamera di layar
      double previewWidth = MediaQuery.of(context).size.width;
      double previewHeight = previewWidth *
          _controller!.value.previewSize!.height /
          _controller!.value.previewSize!.width;

      // Hitung posisi bounding box di preview
      double boxLeft = (previewWidth - boxWidth) / 2;
      double boxTop = (previewHeight - boxHeight) / 2;

      // Hitung scale antara ukuran preview dan ukuran asli foto
      double scaleX = originalImage.width / previewWidth;
      double scaleY = originalImage.height / previewHeight;

      // Hitung posisi crop di gambar asli
      int cropLeft = (boxLeft * scaleX).toInt();
      int cropTop = (boxTop * scaleY).toInt();
      int cropWidth = (boxWidth * scaleX).toInt();
      int cropHeight = (boxHeight * scaleY).toInt();

      // Pastikan crop area tidak keluar dari bounds gambar
      cropLeft = cropLeft.clamp(0, originalImage.width - 1);
      cropTop = cropTop.clamp(0, originalImage.height - 1);
      if (cropLeft + cropWidth > originalImage.width) {
        cropWidth = originalImage.width - cropLeft;
      }
      if (cropTop + cropHeight > originalImage.height) {
        cropHeight = originalImage.height - cropTop;
      }

      // Crop gambar
      img.Image croppedImage = img.copyCrop(originalImage,
          x: cropLeft, y: cropTop, width: cropWidth, height: cropHeight);

      // Simpan hasil crop ke file baru
      final directory = await getTemporaryDirectory();
      final croppedFile = File('${directory.path}/cropped_image.png');
      await croppedFile.writeAsBytes(img.encodePng(croppedImage));

      // Tampilkan hasil crop
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Gambar Ter-crop'),
          content: Image.file(croppedFile),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Tutup'))
          ],
        ),
      );
    } catch (e) {
      print('Error take picture or crop: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Center(
            child: Container(
              width: boxWidth,
              height: boxHeight,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 3),
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: takePictureAndCrop,
                child: Text('Ambil Foto'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
