// To parse this JSON data, do
//
//     final productRateModel = productRateModelFromJson(jsonString);

import 'dart:convert';

ProductRateModel productRateModelFromJson(String str) => ProductRateModel.fromJson(json.decode(str));

String productRateModelToJson(ProductRateModel data) => json.encode(data.toJson());

class ProductRateModel {
  ProductRateModel({
    this.productRateDetails,
    this.status,
    this.message,
  });

  List<ProductRateDetail> productRateDetails;
  int status;
  String message;

  factory ProductRateModel.fromJson(Map<String, dynamic> json) => ProductRateModel(
    productRateDetails: List<ProductRateDetail>.from(json["ProductRateDetails"].map((x) => ProductRateDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "ProductRateDetails": List<dynamic>.from(productRateDetails.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class ProductRateDetail {
  ProductRateDetail({
    this.id,
    this.comment,
    this.rateNum,
    this.productId,
    this.userId,
    this.userName,
    this.userPhoto,
  });

  String id;
  String comment;
  int rateNum;
  String productId;
  String userId;
  String userName;
  String userPhoto;

  factory ProductRateDetail.fromJson(Map<String, dynamic> json) => ProductRateDetail(
    id: json["id"],
    comment: json["comment"],
    rateNum: json["rateNum"],
    productId: json["productId"],
    userId: json["userId"],
    userName: json["userName"],
    userPhoto: json["userPhoto"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "rateNum": rateNum,
    "productId": productId,
    "userId": userId,
    "userName": userName,
    "userPhoto": userPhoto,
  };
}
