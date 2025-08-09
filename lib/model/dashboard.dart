// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {
  String? email;
  int? tahun;
  int? bulanIni;
  int? totalTagihanBulanIni;
  int? bulanLalu;
  int? totalTagihanBulanLalu;
  int? selisih;

  Dashboard({
    this.email,
    this.tahun,
    this.bulanIni,
    this.totalTagihanBulanIni,
    this.bulanLalu,
    this.totalTagihanBulanLalu,
    this.selisih,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        email: json["email"],
        tahun: json["tahun"],
        bulanIni: json["bulanIni"],
        totalTagihanBulanIni: json["totalTagihanBulanIni"],
        bulanLalu: json["bulanLalu"],
        totalTagihanBulanLalu: json["totalTagihanBulanLalu"],
        selisih: json["selisih"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "tahun": tahun,
        "bulanIni": bulanIni,
        "totalTagihanBulanIni": totalTagihanBulanIni,
        "bulanLalu": bulanLalu,
        "totalTagihanBulanLalu": totalTagihanBulanLalu,
        "selisih": selisih,
      };
}
