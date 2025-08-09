import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:watermeterocr/views/ui/pengguna/controller/main_pelanggan_controller.dart';
import 'package:watermeterocr/views/ui/pengguna/home_pelanggan_view.dart';
import 'package:watermeterocr/views/ui/profile/profile_view.dart';

class MainPelangganView extends StatelessWidget {
  MainPelangganView({super.key});

  final MainPelangganController controller = Get.put(MainPelangganController());

  final List<Widget> pages = [
    HomePelangganView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
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
        ));
  }
}
