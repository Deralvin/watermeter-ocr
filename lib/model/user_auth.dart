// To parse this JSON data, do
//
//     final userAuth = userAuthFromJson(jsonString);

import 'dart:convert';

UserAuth userAuthFromJson(String str) => UserAuth.fromJson(json.decode(str));

String userAuthToJson(UserAuth data) => json.encode(data.toJson());

class UserAuth {
  String? message;
  String? name;
  String? role;
  String? token;

  UserAuth({
    this.message,
    this.name,
    this.role,
    this.token,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) => UserAuth(
        message: json["message"],
        name: json["name"],
        role: json["role"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "name": name,
        "role": role,
        "token": token,
      };
}
