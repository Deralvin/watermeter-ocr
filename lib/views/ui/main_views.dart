import 'package:flutter/material.dart';
import 'package:watermeterocr/views/ui/ocr_sclabale_view.dart';
import 'package:watermeterocr/views/ui/scalable_bounding_ocr_view.dart';
import 'package:watermeterocr/views/ui/scan_ocr_view.dart';
import 'package:watermeterocr/views/ui/scan_view.dart';

class MainViews extends StatelessWidget {
  const MainViews({super.key, required this.child, required this.title});
  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menu Utama',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Scan Capture'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainViews(
                      title: 'Scan Capture',
                      child: ScanView(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Scan OCR'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainViews(
                      title: 'Scan OCR',
                      child: ScanOcrView(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('OCR Scalable'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainViews(
                      title: 'Scan Sclable',
                      child: OcrSclabaleView(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('OCR Scalable Bounding Box'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainViews(
                      title: 'Scan Sclable OCR Bounding box',
                      child: ScalableBoundingOcrView(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
