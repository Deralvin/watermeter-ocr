// To parse this JSON data, do
//
//     final historyBills = historyBillsFromJson(jsonString);

import 'dart:convert';

HistoryBills historyBillsFromJson(String str) =>
    HistoryBills.fromJson(json.decode(str));

String historyBillsToJson(HistoryBills data) => json.encode(data.toJson());

class HistoryBills {
  List<BillsData>? billsData;

  HistoryBills({
    this.billsData,
  });

  factory HistoryBills.fromJson(Map<String, dynamic> json) => HistoryBills(
        billsData: json["result"] == null
            ? []
            : List<BillsData>.from(
                json["result"]!.map((x) => BillsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": billsData == null
            ? []
            : List<dynamic>.from(billsData!.map((x) => x.toJson())),
      };
}

class BillsData {
  int? id;
  String? customerName;
  String? startReading;
  String? endReading;
  int? usage;
  int? usage0To10;
  int? usage11To20;
  int? usageAbove20;
  int? baseCharge;
  int? cost0To10;
  int? cost11To20;
  int? costAbove20;
  int? totalPayment;
  Status? status;
  String? proof;
  DateTime? createdAt;

  BillsData({
    this.id,
    this.customerName,
    this.startReading,
    this.endReading,
    this.usage,
    this.usage0To10,
    this.usage11To20,
    this.usageAbove20,
    this.baseCharge,
    this.cost0To10,
    this.cost11To20,
    this.costAbove20,
    this.totalPayment,
    this.status,
    this.proof,
    this.createdAt,
  });

  factory BillsData.fromJson(Map<String, dynamic> json) => BillsData(
        id: json["id"],
        customerName: json["customerName"]!,
        startReading: json["startReading"],
        endReading: json["endReading"],
        usage: json["usage"],
        usage0To10: json["usage0To10"],
        usage11To20: json["usage11To20"],
        usageAbove20: json["usageAbove20"],
        baseCharge: json["baseCharge"],
        cost0To10: json["cost0To10"],
        cost11To20: json["cost11To20"],
        costAbove20: json["costAbove20"],
        totalPayment: json["totalPayment"],
        status: statusValues.map[json["status"]]!,
        proof: json["proof"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerName": customerName,
        "startReading": startReading,
        "endReading": endReading,
        "usage": usage,
        "usage0To10": usage0To10,
        "usage11To20": usage11To20,
        "usageAbove20": usageAbove20,
        "baseCharge": baseCharge,
        "cost0To10": cost0To10,
        "cost11To20": cost11To20,
        "costAbove20": costAbove20,
        "totalPayment": totalPayment,
        "status": statusValues.reverse[status],
        "proof": proof,
        "created_at": createdAt?.toIso8601String(),
      };
}

enum Status { BELUM_DIBAYAR }

final statusValues = EnumValues({"Belum_Dibayar": Status.BELUM_DIBAYAR});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
