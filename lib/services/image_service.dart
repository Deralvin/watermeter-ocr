import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermeterocr/const/api_path.dart';
import 'package:watermeterocr/services/dio_client.dart';

class ImageService {
  final Dio _dio = DioClient().dio;

  Future<dynamic> getImageProof(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await _dio.get(
      'http://20.66.101.230:8080${ApiPath.viewImage}/$id',
      options: Options(
        headers: {
          "Authorization": "Bearer $token", // kalau pakai tok  en
        },
      ),
    );

    return response.data;
  }
}
