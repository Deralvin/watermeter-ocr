import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:watermeterocr/model/user.dart';
import 'package:watermeterocr/services/bills_service.dart';
import 'package:watermeterocr/services/user_service.dart';

class ReportBillsController extends GetxController {
  late CameraController cameraController;
  bool isCameraInitialized = false;

  final TextEditingController recognizedController = TextEditingController();

  final TextEditingController catatanAwalController = TextEditingController();
  final TextEditingController catatanAkhirController = TextEditingController();
  File? croppedFile;
  String recognizedText = '';
  String pathOriginalCamera = '';

  final double boxWidth = 210;
  final double boxHeight = 60;
  UserService userService = UserService();
  BillsService billsService = BillsService();
  RxList<Result> users = <Result>[].obs;
  Rx<Result?> selectedUser = Rx<Result?>(null); // nullable selected user
  Future<void> initCamera(List<CameraDescription> cameras) async {
    getUserPelanggan();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );
    await cameraController.initialize();
    await cameraController.setFlashMode(FlashMode.off);
    isCameraInitialized = true;

    update();
  }

  void getUserPelanggan() async {
    try {
      final data = await userService.getPelanggan();
      log("from get pelanggan ${data.result}");

      if (data.result != null) {
        users.assignAll(data.result!); // ✅ ini yang benar
      }
    } catch (e) {
      log("catch data error $e");
    }
  }

  Future<void> performTextRecognition(File imageFile) async {
    // proses mengambil gambar dari internalt storage yang sudah di crop
    final inputImage = InputImage.fromFile(imageFile);

    //proses untuk mendefiniskan text apa yang akan di recognize
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    //proses membaca image menjadi text number
    final recognized = await textRecognizer.processImage(inputImage);

    final allText = recognized.text;

    //fungsi filter text itu angka
    final regExp = RegExp(r'\d+');
    final matches = regExp.allMatches(allText);
    final numbers = matches.map((m) => m.group(0)).join(' ');

    recognizedText = numbers.isNotEmpty ? numbers : 'Tidak ditemukan angka';
    recognizedController.text = recognizedText;

    textRecognizer.close();
    update();
  }

  Future<void> captureImageInBox() async {
    try {
      //fuul capture image
      final file = await cameraController.takePicture();
      final imageBytes = await File(file.path).readAsBytes();
      pathOriginalCamera = file.path;
      final original = img.decodeImage(imageBytes);
      if (original == null) return;

      final previewSize = cameraController.value.previewSize!;
      final scaleX = original.width / previewSize.height;
      final scaleY = original.height / previewSize.width;

// proses crop bounding box
      final cropX = (180).toInt();
      final cropY = (600 * scaleY).toInt();
      final cropW = (350).toInt();
      final cropH = (boxHeight * scaleY).toInt();

//hasil dari crop image
      final cropped = img.copyCrop(
        original,
        x: cropX,
        y: cropY,
        width: cropW,
        height: cropH,
      );

// save ke internal storage file
      final croppedBytes = Uint8List.fromList(img.encodeJpg(cropped));
      final dir = await getTemporaryDirectory();
      final croppedImageFile =
          File('${dir.path}/cropped_${DateTime.now()}.jpg');
      await croppedImageFile.writeAsBytes(croppedBytes);

      //file sudah tersimpan

      croppedFile = croppedImageFile;

      //fungsi untuk text recognize
      await performTextRecognition(croppedFile!);
      update();
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    recognizedController.dispose();
    super.onClose();
  }

  void onPressedSavedBills() async {
    int awal = int.parse(catatanAwalController.text);
    int akhir = int.parse(recognizedController.text);
    int? hasil = akhir - awal;
    log("data yang disimpan ${pathOriginalCamera} ${awal} ${akhir} ${selectedUser.value!.id} ${hasil}");

    final data = await billsService.postAddBills(
        pathImage: pathOriginalCamera,
        idUser: selectedUser.value!.id.toString(),
        catatanAwal: catatanAwalController.text,
        catatanAkhir: recognizedController.text,
        pemakaian: hasil.toString());

    log("return data response ${data['message']}");

    if (data['message'] == "Data berhasil dibuat") {
      Get.snackbar('Success', "${data['message']}",
          backgroundColor: Colors.green, colorText: Colors.white);
      clearData();
    } else {
      Get.snackbar('Error', "${data['message']}",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void clearData() async {
    catatanAwalController.text = '';
    recognizedController.text = '';
    pathOriginalCamera = '';

    croppedFile = null;

    update();
  }
}
