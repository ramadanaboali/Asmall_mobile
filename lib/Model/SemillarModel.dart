// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

SemillarModel productModelFromJson(String str) => SemillarModel.fromJson(json.decode(str));

String productModelToJson(SemillarModel data) => json.encode(data.toJson());

class SemillarModel {
  SemillarModel({
    this.productDetail,
    this.status,
    this.message,
  });

  List<SemillarDetail> productDetail;
  int status;
  String message;

  factory SemillarModel.fromJson(Map<String, dynamic> json) => SemillarModel(
    productDetail: List<SemillarDetail>.from(json["productDetail"].map((x) => SemillarDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "productDetail": List<dynamic>.from(productDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class SemillarDetail {
  SemillarDetail({
    this.id,
    this.name,
    this.description,
    this.coverPhoto,
    this.price,
    this.rate,
    this.disCount,
    this.offerPrice,
  });

  String id;
  String name;
  String description;
  String coverPhoto;
  int price;
  double rate;
  int disCount;
  int offerPrice;

  factory SemillarDetail.fromJson(Map<String, dynamic> json) => SemillarDetail(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    coverPhoto: json["coverPhoto"],
    price: json["price"],
    rate: json["rate"],
    disCount: json["disCount"],
    offerPrice: json["offerPrice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "coverPhoto": coverPhoto,
    "price": price,
    "rate": rate,
    "disCount": disCount,
    "offerPrice": offerPrice,
  };
}
