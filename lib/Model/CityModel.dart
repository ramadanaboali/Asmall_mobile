// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    this.cityDetail,
    this.status,
    this.message,
  });

  List<CityDetail> cityDetail;
  int status;
  String message;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    cityDetail: List<CityDetail>.from(json["CityDetail"].map((x) => CityDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "CityDetail": List<dynamic>.from(cityDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class CityDetail {
  CityDetail({
    this.id,
    this.name,
    this.code,
    this.isDeleted,
  });

  String id;
  String name;
  String code;
  bool isDeleted;

  factory CityDetail.fromJson(Map<String, dynamic> json) => CityDetail(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "isDeleted": isDeleted,
  };
}
