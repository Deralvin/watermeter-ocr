import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:get/get.dart';
import 'package:watermeterocr/views/ui/login/screen/login_view.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  DioClient._internal() {
    _dio = Dio();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('jwt_token');

        if (token != null) {
          if (Jwt.isExpired(token)) {
            await _handleLogout();
            return handler.reject(
              DioException(
                requestOptions: options,
                error: 'Token expired',
              ),
            );
          }

          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          await _handleLogout();
        }
        return handler.next(e);
      },
    ));
  }

  late Dio _dio;
  Dio get dio => _dio;

  Future<void> _handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    Get.offAll(LoginView());
  }
}
