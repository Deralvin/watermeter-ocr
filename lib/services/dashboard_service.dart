import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermeterocr/const/api_path.dart';
import 'package:watermeterocr/model/dashboard.dart';
import 'package:watermeterocr/services/dio_client.dart';

class DashboardService {
  final Dio _dio = DioClient().dio;

  Future<Dashboard> getDashboard() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');
      Map<String, dynamic> payload = Jwt.parseJwt(token!);
      final response = await _dio.get(
        'http://20.66.101.230:8080${ApiPath.dashboardPelanggan}?email=${payload['email']}',
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // kalau pakai tok  en
          },
        ),
      );
      return Dashboard.fromJson(response.data);
    } catch (e) {
      return Dashboard();
    }
  }
}
