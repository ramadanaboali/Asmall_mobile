// To parse this JSON data, do
//
//     final product2Model = product2ModelFromJson(jsonString);

import 'dart:convert';

Product2Model product2ModelFromJson(String str) => Product2Model.fromJson(json.decode(str));

String product2ModelToJson(Product2Model data) => json.encode(data.toJson());

class Product2Model {
  Product2Model({
    this.product2DetailModel,
    this.status,
    this.message,
  });

  Product2DetailModel product2DetailModel;
  int status;
  String message;

  factory Product2Model.fromJson(Map<String, dynamic> json) => Product2Model(
    product2DetailModel: Product2DetailModel.fromJson(json["Product2DetailModel"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "Product2DetailModel": product2DetailModel.toJson(),
    "status": status,
    "message": message,
  };
}

class Product2DetailModel {
  Product2DetailModel({
    this.id,
    this.name,
    this.description,
    this.coverPhoto,
    this.video,
    this.price,
    this.rate,
    this.disCount,
    this.offerPrice,
    this.imagesPaths,
    this.productSpeceficationDtos,
    this.productColorModel,
    this.productSizeModel,
  });

  String id;
  String name;
  String description;
  String coverPhoto;
  dynamic video;
  int price;
  int rate;
  int disCount;
  int offerPrice;
  List<String> imagesPaths;
  List<dynamic> productSpeceficationDtos;
  List<ProductColorModel> productColorModel;
  List<ProductSizeModel> productSizeModel;

  factory Product2DetailModel.fromJson(Map<String, dynamic> json) => Product2DetailModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    coverPhoto: json["coverPhoto"],
    video: json["video"],
    price: json["price"],
    rate: json["rate"],
    disCount: json["disCount"],
    offerPrice: json["offerPrice"],
    imagesPaths: List<String>.from(json["imagesPaths"].map((x) => x)),
    productSpeceficationDtos: List<dynamic>.from(json["productSpeceficationDtos"].map((x) => x)),
    productColorModel: List<ProductColorModel>.from(json["ProductColorModel"].map((x) => ProductColorModel.fromJson(x))),
    productSizeModel: List<ProductSizeModel>.from(json["ProductSizeModel"].map((x) => ProductSizeModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "coverPhoto": coverPhoto,
    "video": video,
    "price": price,
    "rate": rate,
    "disCount": disCount,
    "offerPrice": offerPrice,
    "imagesPaths": List<dynamic>.from(imagesPaths.map((x) => x)),
    "productSpeceficationDtos": List<dynamic>.from(productSpeceficationDtos.map((x) => x)),
    "ProductColorModel": List<dynamic>.from(productColorModel.map((x) => x.toJson())),
    "ProductSizeModel": List<dynamic>.from(productSizeModel.map((x) => x.toJson())),
  };
}

class ProductColorModel {
  ProductColorModel({
    this.id,
    this.imageColor,
  });

  String id;
  String imageColor;

  factory ProductColorModel.fromJson(Map<String, dynamic> json) => ProductColorModel(
    id: json["id"],
    imageColor: json["imageColor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageColor": imageColor,
  };
}

class ProductSizeModel {
  ProductSizeModel({
    this.id,
    this.sizeValue,
  });

  String id;
  String sizeValue;

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) => ProductSizeModel(
    id: json["id"],
    sizeValue: json["sizeValue"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sizeValue": sizeValue,
  };
}
