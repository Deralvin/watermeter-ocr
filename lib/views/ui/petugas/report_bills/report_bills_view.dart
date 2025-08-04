import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:watermeterocr/model/user.dart';
import 'package:watermeterocr/views/ui/petugas/controller/report_bills_controller.dart';

class ReportBillsView extends StatelessWidget {
  final List<CameraDescription> cameras;
  const ReportBillsView({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportBillsController>(
      init: ReportBillsController()..initCamera(cameras),
      builder: (controller) {
        if (!controller.isCameraInitialized) {
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
                  Gap(60.sp),
                  Obx(() {
                    return DropdownButtonFormField<Result>(
                      decoration: const InputDecoration(
                        labelText: 'Pilih Pelanggan',
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      value: controller.selectedUser.value,
                      items: controller.users.map((user) {
                        return DropdownMenuItem<Result>(
                          value: user,
                          child: Text(user.nama ?? '(Tanpa Nama)'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedUser.value = value;
                      },
                    );
                  }),
                  Stack(
                    children: [
                      Container(
                          color: Colors.red,
                          child: CameraPreview(controller.cameraController)),
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
                          onPressed: controller.captureImageInBox,
                          child: const Icon(Icons.camera_alt),
                        ),
                      ),
                    ],
                  ),
                  if (controller.croppedFile != null)
                    Image.file(controller.croppedFile!),
                  Text("Recognized: ${controller.recognizedText}"),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                    child: TextFormField(
                      controller: controller.catatanAwalController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Inputkan Catatan Awal'),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                    child: TextFormField(
                      controller: controller.recognizedController,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: 'Catatan Akhir'),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        controller.onPressedSavedBills();
                      },
                      child: Text("Simpan"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
