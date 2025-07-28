import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watermeterocr/views/ui/camera_with_box_view.dart';
import 'package:watermeterocr/views/ui/login/screen/login_view.dart';
import 'package:watermeterocr/views/ui/main_view.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        theme: ThemeData(useMaterial3: false),
        title: 'Meter Pams',
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    );
  }
}
