// To parse this JSON data, do
//
//     final oneProductModel = oneProductModelFromJson(jsonString);

import 'dart:convert';

OneProductModel oneProductModelFromJson(String str) => OneProductModel.fromJson(json.decode(str));

String oneProductModelToJson(OneProductModel data) => json.encode(data.toJson());

class OneProductModel {
  OneProductModel({
    this.oneProductDetails,
    this.status,
    this.message,
  });

  OneProductDetails oneProductDetails;
  int status;
  String message;

  factory OneProductModel.fromJson(Map<String, dynamic> json) => OneProductModel(
    oneProductDetails: OneProductDetails.fromJson(json["oneProductDetails"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "oneProductDetails": oneProductDetails.toJson(),
    "status": status,
    "message": message,
  };
}

class OneProductDetails {
  OneProductDetails({
    this.id,
    this.name,
    this.description,
    this.coverPhoto,
    this.price,
    this.rate,
    this.disCount,
    this.offerPrice,
    this.imagesPaths,
  });

  String id;
  String name;
  String description;
  String coverPhoto;
  int price;
  int rate;
  int disCount;
  int offerPrice;
  List<String> imagesPaths;

  factory OneProductDetails.fromJson(Map<String, dynamic> json) => OneProductDetails(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    coverPhoto: json["coverPhoto"],
    price: json["price"],
    rate: json["rate"],
    disCount: json["disCount"],
    offerPrice: json["offerPrice"],
    imagesPaths: List<String>.from(json["imagesPaths"].map((x) => x)),
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
    "imagesPaths": List<dynamic>.from(imagesPaths.map((x) => x)),
  };
}
