import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermeterocr/const/api_path.dart';
import 'package:watermeterocr/model/user_auth.dart';
import 'package:watermeterocr/views/ui/login/screen/login_view.dart';
import 'dio_client.dart';

class AuthService {
  final Dio _dio = DioClient().dio;

  Future<UserAuth> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'http://20.66.101.230:8080${ApiPath.login}',
        data: {
          'data': {"email": email, "password": password}
        },
      );
      log("cek data ${response.data}");
      final token = response.data['token'];
      final name = response.data['name'];
      final role = response.data['role'];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        await prefs.setString('name', name);
        await prefs.setString('role', role);
        return userAuthFromJson(jsonEncode(response.data));
      } else {
        return UserAuth();
      }
    } catch (e) {
      print('Login failed: $e');
      return UserAuth();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    Get.offAll(LoginView());
  }
}
