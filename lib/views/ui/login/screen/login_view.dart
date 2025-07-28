import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:watermeterocr/const/color_pallete.dart';
import 'package:watermeterocr/main.dart';
import 'package:watermeterocr/views/ui/login/controller/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (controller) => Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.sp),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorPallete().secondColor,
                ColorPallete().primayColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: controller.loadingLogin.value == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Meter Pams',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                    Gap(8.sp),
                    Text("Email"),
                    Gap(4.sp),
                    TextFormField(
                      controller: controller.emailTxt,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                      ),
                    ),
                    Gap(16.sp),
                    Text("Password"),
                    Gap(4.sp),
                    TextFormField(
                      controller: controller.passTxt,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                      ),
                    ),
                    Gap(12.sp),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.sp),
                        ),
                        onPressed: () {
                          controller.loginAttempt();
                        },
                        child: Text("Sign In"),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
