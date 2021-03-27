// To parse this JSON data, do
//
//     final allCategoryModel = allCategoryModelFromJson(jsonString);

import 'dart:convert';

AllCategoryModel allCategoryModelFromJson(String str) => AllCategoryModel.fromJson(json.decode(str));

String allCategoryModelToJson(AllCategoryModel data) => json.encode(data.toJson());

class AllCategoryModel {
  AllCategoryModel({
    this.categoryDetail,
    this.status,
    this.message,
  });

  List<CategoryDetail> categoryDetail;
  int status;
  String message;

  factory AllCategoryModel.fromJson(Map<String, dynamic> json) => AllCategoryModel(
    categoryDetail: List<CategoryDetail>.from(json["CategoryDetail"].map((x) => CategoryDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "CategoryDetail": List<dynamic>.from(categoryDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class CategoryDetail {
  CategoryDetail({
    this.id,
    this.name,
    this.photo,
  });

  String id;
  String name;
  String photo;

  factory CategoryDetail.fromJson(Map<String, dynamic> json) => CategoryDetail(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
  };
}
