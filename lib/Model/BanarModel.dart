// To parse this JSON data, do
//
//     final banarModel = banarModelFromJson(jsonString);

import 'dart:convert';

BanarModel banarModelFromJson(String str) => BanarModel.fromJson(json.decode(str));

String banarModelToJson(BanarModel data) => json.encode(data.toJson());

class BanarModel {
  BanarModel({
    this.banarDetail,
    this.status,
    this.message,
  });

  List<BanarDetail> banarDetail;
  int status;
  String message;

  factory BanarModel.fromJson(Map<String, dynamic> json) => BanarModel(
    banarDetail: List<BanarDetail>.from(json["BanarDetail"].map((x) => BanarDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "BanarDetail": List<dynamic>.from(banarDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class BanarDetail {
  BanarDetail({
    this.id,
    this.title,
    this.description,
    this.photo,
  });

  String id;
  String title;
  String description;
  String photo;

  factory BanarDetail.fromJson(Map<String, dynamic> json) => BanarDetail(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "photo": photo,
  };
}
