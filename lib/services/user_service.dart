import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermeterocr/const/api_path.dart';
import 'package:watermeterocr/model/user.dart';
import 'package:watermeterocr/model/user_auth.dart';
import 'package:watermeterocr/views/ui/login/screen/login_view.dart';
import 'dio_client.dart';

class UserService {
  final Dio _dio = DioClient().dio;

  Future<User> getPelanggan() async {
    try {
      final response = await _dio.get(
        'http://20.66.101.230:8080${ApiPath.users}?role=Pelanggan',
      );

      final result = response.data;
      log("from api $result");
      if (result.isNotEmpty) {
        return userFromJson(jsonEncode(response.data));
      } else {
        return User();
      }
    } catch (e) {
      print('get User failed: $e');
      return User();
    }
  }
}
