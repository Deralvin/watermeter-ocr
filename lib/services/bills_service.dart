import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermeterocr/const/api_path.dart';
import 'package:watermeterocr/services/dio_client.dart';

class BillsService {
  final Dio _dio = DioClient().dio;

  Future<Map<String, dynamic>> postAddBills({
    required String pathImage,
    required String idUser,
    required String catatanAwal,
    required String catatanAkhir,
    required pemakaian,
  }) async {
    try {
      String fileName = pathImage.split('/').last;
      FormData formData = FormData.fromMap({
        "file_foto": await MultipartFile.fromFile(pathImage,
            contentType: MediaType('image', 'jpg')),
        "id_user": idUser, // field lain kalau ada
        "catatan_awal": catatanAwal,
        "catatan_akhir": catatanAkhir,
        "pemakaian": pemakaian,
        "status": "Belum_Dibayar",
      });

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');
      final response = await _dio.post(
        'http://20.66.101.230:8080${ApiPath.addBills}',
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token", // kalau pakai token
          },
        ),
      );
      return response.data;
    } catch (e) {
      return {"message": "Execption $e"};
    }
  }
}
