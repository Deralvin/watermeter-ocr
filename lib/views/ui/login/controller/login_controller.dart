import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermeterocr/main.dart';
import 'package:watermeterocr/services/auth_service.dart';
import 'package:watermeterocr/views/ui/home_view.dart';
import 'package:watermeterocr/views/ui/pengguna/home_pelanggan_view.dart';
import 'package:watermeterocr/views/ui/pengguna/main_pelanggan_view.dart';
import 'package:watermeterocr/views/ui/petugas/home_petugas_view.dart';

class LoginController extends GetxController {
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passTxt = TextEditingController();
  final loadingLogin = false.obs;
  AuthService authService = AuthService();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkCredential();
  }

  void checkCredential() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final role = prefs.getString('role');
    if (token != null && !Jwt.isExpired(token)) {
      if (role == 'Pelanggan') {
        Get.offAll(MainPelangganView());
      } else if (role == 'Petugas') {
        Get.offAll(HomePetugasView());
      }
    }
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
      final signInData = await authService.login(emailTxt.text, passTxt.text);
      log("login data ${signInData.role}");
      if (signInData.token != null) {
        if (signInData.role == 'Pelanggan') {
          Get.offAll(MainPelangganView());
        } else if (signInData.role == 'Petugas') {
          Get.offAll(HomePetugasView());
        } else {}
      }
      loadingLogin.value = false;
    } catch (e) {
      loadingLogin.value = false;
    }
  }
}
