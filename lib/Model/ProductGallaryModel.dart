// To parse this JSON data, do
//
//     final productGallaryModel = productGallaryModelFromJson(jsonString);

import 'dart:convert';

ProductGallaryModel productGallaryModelFromJson(String str) => ProductGallaryModel.fromJson(json.decode(str));

String productGallaryModelToJson(ProductGallaryModel data) => json.encode(data.toJson());

class ProductGallaryModel {
  ProductGallaryModel({
    this.productGallaryDetail,
    this.status,
    this.message,
  });

  List<ProductGallaryDetail> productGallaryDetail;
  int status;
  String message;

  factory ProductGallaryModel.fromJson(Map<String, dynamic> json) => ProductGallaryModel(
    productGallaryDetail: List<ProductGallaryDetail>.from(json["ProductGallaryDetail"].map((x) => ProductGallaryDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "ProductGallaryDetail": List<dynamic>.from(productGallaryDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class ProductGallaryDetail {
  ProductGallaryDetail({
    this.attachment,
    this.type,
  });

  String attachment;
  String type;

  factory ProductGallaryDetail.fromJson(Map<String, dynamic> json) => ProductGallaryDetail(
    attachment: json["attachment"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "attachment": attachment,
    "type": type,
  };
}
