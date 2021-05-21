// To parse this JSON data, do
//
//     final zoneModel = zoneModelFromJson(jsonString);

import 'dart:convert';

ZoneModel zoneModelFromJson(String str) => ZoneModel.fromJson(json.decode(str));

String zoneModelToJson(ZoneModel data) => json.encode(data.toJson());

class ZoneModel {
  ZoneModel({
    this.zoneDetails,
    this.status,
    this.message,
  });

  List<ZoneDetail> zoneDetails;
  int status;
  String message;

  factory ZoneModel.fromJson(Map<String, dynamic> json) => ZoneModel(
    zoneDetails: List<ZoneDetail>.from(json["ZoneDetails"].map((x) => ZoneDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "ZoneDetails": List<dynamic>.from(zoneDetails.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class ZoneDetail {
  ZoneDetail({
    this.id,
    this.name,
    this.governorateId,
    this.isDeleted,
  });

  String id;
  String name;
  String governorateId;
  bool isDeleted;

  factory ZoneDetail.fromJson(Map<String, dynamic> json) => ZoneDetail(
    id: json["id"],
    name: json["name"],
    governorateId: json["governorateId"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "governorateId": governorateId,
    "isDeleted": isDeleted,
  };
}
