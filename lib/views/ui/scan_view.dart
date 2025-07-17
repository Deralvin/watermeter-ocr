import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  File? _image;

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _image!,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  )
                : Material(
                    borderRadius: BorderRadius.circular(8),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: _openCamera,
                        child: SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: Center(
                            child: Icon(
                              Icons.add_a_photo_rounded,
                              size: 40,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            _image != null
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _openCamera, child: Text('Retake')),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Input Water Meter'),
            ),
            const SizedBox(
              height: 12,
            ),
            _image == null
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          side: const BorderSide(color: Colors.red, width: 2),
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () {
                          // Aksi tombol X
                        },
                        child: const Icon(Icons.close, color: Colors.red),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          side: const BorderSide(color: Colors.green, width: 2),
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () {
                          // Aksi tombol ✓
                        },
                        child: const Icon(Icons.check, color: Colors.green),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
