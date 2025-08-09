import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:watermeterocr/const/api_path.dart';
import 'package:watermeterocr/model/history_bills.dart';
import 'package:watermeterocr/views/ui/pengguna/controller/detail_invoice_controller.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DetailInvoiceView extends StatefulWidget {
  const DetailInvoiceView({super.key, required this.billsData});

  final BillsData billsData;

  @override
  State<DetailInvoiceView> createState() => _DetailInvoiceViewState();
}

class _DetailInvoiceViewState extends State<DetailInvoiceView> {
  final GlobalKey _captureKey = GlobalKey();

  Future<void> _captureAndSave() async {
    try {
      // Tangkap widget ke gambar
      RenderRepaintBoundary boundary = _captureKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Simpan ke file
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
      File imgFile = File(filePath);
      await imgFile.writeAsBytes(pngBytes);

      // Tampilkan snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invoice berhasil disimpan"),
          action: SnackBarAction(
            label: "Buka",
            onPressed: () {
              OpenFile.open(filePath); // buka file langsung
            },
          ),
        ),
      );

      print('✅ Screenshot saved: $filePath');
    } catch (e) {
      print('❌ Error capturing screenshot: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DetailInvoiceController()..decodeJwt(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("Detail Invoice"),
        ),
        body: Obx(
          () => Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       "Selly",
                  //       style: TextStyle(fontSize: 28.sp),
                  //     ),
                  //     Icon(
                  //       Icons.person_4_rounded,
                  //       size: 40.sp,
                  //     ),
                  //     Gap(20.sp)
                  //   ],
                  // ),
                  Gap(20.sp),
                  RepaintBoundary(
                    key: _captureKey,
                    child: Container(
                      padding: EdgeInsets.all(12.sp),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kuitansi Pembayaran",
                            style: TextStyle(fontSize: 24.sp),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text("No. SR : ${widget.billsData.id}"),
                              ),
                              Expanded(
                                child: Text(
                                    "Pencacatan ${DateFormat('d MMM yyyy').format(widget.billsData.createdAt!)} : ${widget.billsData.startReading}"),
                              )
                            ],
                          ),
                          Gap(8.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text("Nama :${controller.name}"),
                              ),
                              Expanded(
                                child: Text(
                                    "Pencacatan ${DateFormat('d MMM yyyy').format(DateTime(widget.billsData.createdAt!.year, widget.billsData.createdAt!.month + 1, widget.billsData.createdAt!.day))} : ${widget.billsData.endReading}"),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(),
                              ),
                              Expanded(
                                child: Text(
                                    "Jumlah Pemakaian  ${widget.billsData.usage}"),
                              )
                            ],
                          ),
                          Gap(8.sp),
                          Table(
                            border:
                                TableBorder.all(color: Colors.blue.shade100),
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(3),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(3),
                              4: FlexColumnWidth(3),
                            },
                            children: [
                              // Header
                              TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.blue.shade50),
                                children: [
                                  tableCell("No", isHeader: true),
                                  tableCell("Rincian", isHeader: true),
                                  tableCell("Pemakaian", isHeader: true),
                                  tableCell("Biaya", isHeader: true),
                                  tableCell("Sub Total (Rp)", isHeader: true),
                                ],
                              ),
                              // Data rows
                              TableRow(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  children: [
                                    tableCell("1"),
                                    tableCell("Beban", isBold: true),
                                    tableCell("1"),
                                    tableCell(
                                      controller.formatRupiah(double.parse(
                                              widget.billsData.baseCharge!
                                                  .toString()) /
                                          1),
                                    ),
                                    tableCell(controller.formatRupiah(
                                        double.parse(widget.billsData.baseCharge
                                                .toString()) ??
                                            0))
                                  ]),
                              TableRow(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  children: [
                                    tableCell("2"),
                                    tableCell("0 - 10 m3", isBold: true),
                                    tableCell("${widget.billsData.usage0To10}"),
                                    tableCell(
                                      controller.formatRupiah(double.parse(
                                              widget.billsData.cost0To10!
                                                  .toString()) /
                                          widget.billsData.usage0To10!),
                                    ),
                                    tableCell(controller.formatRupiah(
                                        double.parse(widget.billsData.cost0To10
                                                .toString()) ??
                                            0))
                                  ]),
                              TableRow(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  children: [
                                    tableCell("3"),
                                    tableCell("11 - 20 m3", isBold: true),
                                    tableCell(
                                        "${widget.billsData.usage11To20}"),
                                    tableCell(
                                      controller.formatRupiah(double.parse(
                                              widget.billsData.cost11To20!
                                                  .toString()) /
                                          widget.billsData.usage11To20!),
                                    ),
                                    tableCell(controller.formatRupiah(
                                        double.parse(widget.billsData.cost11To20
                                                .toString()) ??
                                            0))
                                  ]),
                              TableRow(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  children: [
                                    tableCell("4"),
                                    tableCell("21 ke atas m3", isBold: true),
                                    tableCell(
                                        "${widget.billsData.usageAbove20}"),
                                    tableCell(
                                      controller.formatRupiah(double.parse(
                                              widget.billsData.costAbove20!
                                                  .toString()) /
                                          widget.billsData.usageAbove20!),
                                    ),
                                    tableCell(controller.formatRupiah(
                                        double.parse(widget
                                                .billsData.costAbove20
                                                .toString()) ??
                                            0))
                                  ]),
                              // Baris "Total Pembayaran" (seolah colspan 4 kolom)
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(12),
                            color: Colors.grey[200],
                            alignment: Alignment.center,
                            child: Text(
                              "Total Pembayaran Anda",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.green[100],
                            alignment: Alignment.center,
                            child: Text(
                              "${controller.formatRupiah(double.parse(widget.billsData.costAbove20.toString()) ?? 0)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Gap(24.sp),
                  Center(
                    child: ElevatedButton(
                      onPressed: _captureAndSave,
                      child: Text("Download"),
                    ),
                  ),
                  Gap(24.sp),
                  Center(
                    child: Text(
                      "Kuitansi Pembayaran",
                    ),
                  ),
                  Gap(24.sp),
                  Center(
                    child: Image.network(
                      "http://20.66.101.230:8080${ApiPath.viewImage}/${widget.billsData.id}",
                      height: 190.sp,
                    ),
                  ),
                  Gap(24.sp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tableCell(String text, {bool isBold = false, bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isBold || isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 14 : 13,
        ),
      ),
    );
  }
}
