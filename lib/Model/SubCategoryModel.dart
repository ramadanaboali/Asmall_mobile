// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    this.subCategoryDetail,
    this.status,
    this.message,
  });

  List<SubCategoryDetail> subCategoryDetail;
  int status;
  String message;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    subCategoryDetail: List<SubCategoryDetail>.from(json["SubCategoryDetail"].map((x) => SubCategoryDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "SubCategoryDetail": List<dynamic>.from(subCategoryDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class SubCategoryDetail {
  SubCategoryDetail({
    this.id,
    this.name,
    this.categoryId,
    this.photo,
  });

  String id;
  String name;
  String categoryId;
  String photo;

  factory SubCategoryDetail.fromJson(Map<String, dynamic> json) => SubCategoryDetail(
    id: json["id"],
    name: json["name"],
    categoryId: json["categoryId"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "categoryId": categoryId,
    "photo": photo,
  };
}
