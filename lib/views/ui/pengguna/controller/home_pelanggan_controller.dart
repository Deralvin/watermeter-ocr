import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermeterocr/model/dashboard.dart';
import 'package:watermeterocr/model/history_bills.dart';
import 'package:watermeterocr/services/bills_service.dart';
import 'package:watermeterocr/services/dashboard_service.dart';

class HomePelangganController extends GetxController {
  DashboardService dashboardService = DashboardService();
  BillsService billsService = BillsService();
  final historyBills = Rxn<HistoryBills>();
  final dashboard = Rxn<Dashboard>();
  final name = "".obs;
  final isLoading = false.obs;

  final selectedYear = DateTime.now().year.obs;
  final yearList = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDashboard();
    decodeJwt();
    generateYearList();
    final currentYear = DateTime.now().year;
    getHistoryBills(currentYear);
  }

  Future<void> getDashboard() async {
    try {
      isLoading.value = true;
      final data = await dashboardService.getDashboard();
      dashboard.value = data;
    } catch (e) {
      dashboard.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> decodeJwt() async {
    final prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? "";
    update();
  }

  String convertCmToM(int value) {
    final data = value / 1000;
    return '$data';
  }

  void generateYearList() {
    final currentYear = DateTime.now().year;
    yearList.clear();
    for (int i = 0; i < 5; i++) {
      yearList.add(currentYear - i);
    }
  }

  void setYear(int year) {
    selectedYear.value = year;
  }

  Future<void> getHistoryBills(int year) async {
    try {
      final data = await billsService.getHistoryBills(years: year);

      // Urutkan berdasarkan created_at ascending
      data.billsData!.sort((a, b) {
        final dateA = a.createdAt ?? DateTime(1900); // fallback biar nggak null
        final dateB = b.createdAt ?? DateTime(1900);
        return dateA.compareTo(dateB); // ascending
      });
      log("get data history ${data.billsData}");
      historyBills.value = data;
    } catch (e) {
      historyBills.value = HistoryBills(
        billsData: [],
      );
    }
  }
}
