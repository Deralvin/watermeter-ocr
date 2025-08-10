import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watermeterocr/views/ui/petugas/controller/home_petugas_controller.dart';
import 'package:watermeterocr/views/ui/petugas/report_bills/report_bills_view.dart';
import 'package:watermeterocr/main.dart';
import 'package:watermeterocr/views/ui/profile/profile_view.dart';

class HomePetugasView extends StatelessWidget {
  HomePetugasView({super.key});

  final List<Widget> pages = [
    ReportBillsView(
      cameras: cameras,
    ),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePetugasController>(
      init: HomePetugasController(),
      builder: (controller) {
        return Obx(
          () => Scaffold(
            body: pages[controller.selectedIndex.value],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changePage,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
