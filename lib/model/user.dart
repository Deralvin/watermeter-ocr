// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  List<Result>? result;

  User({
    this.result,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  String? nik;
  String? nama;
  String? email;
  String? alamat;
  String? role;

  Result({
    this.id,
    this.nik,
    this.nama,
    this.email,
    this.alamat,
    this.role,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        nik: json["nik"],
        nama: json["nama"],
        email: json["email"],
        alamat: json["alamat"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik": nik,
        "nama": nama,
        "email": email,
        "alamat": alamat,
        "role": role,
      };
}
