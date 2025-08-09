import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermeterocr/services/image_service.dart';

class DetailInvoiceController extends GetxController {
  ImageService imageService = ImageService();
  final name = "".obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();

    decodeJwt();
  }

  Future<void> getImageProof(int id) async {
    try {
      final data = await imageService.getImageProof(id);
      log("test data image $data");
    } catch (e) {}
  }

  Future<void> decodeJwt() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? "";
    isLoading.value = false;
  }

  String formatRupiah(double number) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );
    return '${formatter.format(number)},-';
  }
}
