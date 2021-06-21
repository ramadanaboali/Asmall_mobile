// To parse this JSON data, do
//
//     final sidesModel = sidesModelFromJson(jsonString);

import 'dart:convert';

SidesModel sidesModelFromJson(String str) => SidesModel.fromJson(json.decode(str));

String sidesModelToJson(SidesModel data) => json.encode(data.toJson());

class SidesModel {
  SidesModel({
    this.sidesDetail,
  });

  List<SidesDetail> sidesDetail;

  factory SidesModel.fromJson(Map<String, dynamic> json) => SidesModel(
    sidesDetail: List<SidesDetail>.from(json["SidesDetail"].map((x) => SidesDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SidesDetail": List<dynamic>.from(sidesDetail.map((x) => x.toJson())),
  };
}

class SidesDetail {
  SidesDetail({
    this.id,
    this.sideImage,
    this.title,
  });

  String id;
  String sideImage;
  String title;

  factory SidesDetail.fromJson(Map<String, dynamic> json) => SidesDetail(
    id: json["id"],
    sideImage: json["sideImage"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sideImage": sideImage,
    "title": title,
  };
}
