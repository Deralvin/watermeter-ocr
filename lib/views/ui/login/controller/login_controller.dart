import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watermeterocr/services/auth_serive.dart';
import 'package:watermeterocr/views/ui/home_view.dart';

class LoginController extends GetxController {
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passTxt = TextEditingController();
  final loadingLogin = false.obs;
  AuthService authService = AuthService();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    emailTxt.dispose();
    passTxt.dispose();
    super.dispose();
  }

  void loginAttempt() async {
    loadingLogin.value = true;

    try {
      log("our data email ${emailTxt.text} and ${passTxt.text}");
      final signInData = await authService.login(emailTxt.text, passTxt.text);

      if (signInData == true) {
        Get.offAll(HomeView());
      }
      loadingLogin.value = false;
    } catch (e) {
      loadingLogin.value = false;
    }
  }
}
