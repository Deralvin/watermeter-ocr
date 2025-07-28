import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:watermeterocr/const/color_pallete.dart';
import 'package:watermeterocr/views/ui/camera_with_box_view.dart';
import 'package:watermeterocr/main.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Widget? _child;
  @override
  void initState() {
    _child = CameraWithBox(
      cameras: cameras,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete().primayColor,
      extendBody: true,
      body: _child,
      bottomNavigationBar: FluidNavBar(
        style: FluidNavBarStyle(
            barBackgroundColor: ColorPallete().primayColor,
            iconUnselectedForegroundColor: Colors.white),
        icons: [
          FluidNavBarIcon(
              icon: Icons.home_rounded,
              unselectedForegroundColor: Colors.white,
              selectedForegroundColor: ColorPallete().accentColor,
              backgroundColor: ColorPallete().primayColor),
          FluidNavBarIcon(
              icon: Icons.camera_alt_rounded,
              unselectedForegroundColor: Colors.white,
              selectedForegroundColor: ColorPallete().accentColor,
              backgroundColor: ColorPallete().primayColor),
          FluidNavBarIcon(
              icon: Icons.person_2_rounded,
              unselectedForegroundColor: Colors.white,
              selectedForegroundColor: ColorPallete().accentColor,
              backgroundColor: ColorPallete().primayColor),
        ],
        onChange: _handleNavigationChange,
        scaleFactor: 1.5,
        defaultIndex: 1,
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = CameraWithBox(
            cameras: cameras,
          );
          break;
        case 1:
          _child = Center(
            child: Text("dada"),
          );
          break;
        case 2:
          _child = Center(
            child: Text("dada"),
          );
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
