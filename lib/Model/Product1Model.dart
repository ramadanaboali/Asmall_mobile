// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

Product1Model productModelFromJson(String str) => Product1Model.fromJson(json.decode(str));

String productModelToJson(Product1Model data) => json.encode(data.toJson());

class Product1Model {
  Product1Model({
    this.productDetail,
    this.status,
    this.message,
  });

  List<Product1Detail> productDetail;
  int status;
  String message;

  factory Product1Model.fromJson(Map<String, dynamic> json) => Product1Model(
    productDetail: List<Product1Detail>.from(json["productDetail"].map((x) => Product1Detail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "productDetail": List<dynamic>.from(productDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class Product1Detail {
  Product1Detail({
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
  int rate;
  int disCount;
  int offerPrice;

  factory Product1Detail.fromJson(Map<String, dynamic> json) => Product1Detail(
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
