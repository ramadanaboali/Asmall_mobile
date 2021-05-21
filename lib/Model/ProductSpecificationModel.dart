// To parse this JSON data, do
//
//     final productSpecifiction = productSpecifictionFromJson(jsonString);

import 'dart:convert';

ProductSpecifiction productSpecifictionFromJson(String str) => ProductSpecifiction.fromJson(json.decode(str));

String productSpecifictionToJson(ProductSpecifiction data) => json.encode(data.toJson());

class ProductSpecifiction {
  ProductSpecifiction({
    this.id,
    this.speceficationId,
    this.speceficationName,
    this.productId,
    this.value,
  });

  String id;
  String speceficationId;
  String speceficationName;
  String productId;
  String value;

  factory ProductSpecifiction.fromJson(Map<String, dynamic> json) => ProductSpecifiction(
    id: json["id"],
    speceficationId: json["speceficationId"],
    speceficationName: json["speceficationName"],
    productId: json["productId"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "speceficationId": speceficationId,
    "speceficationName": speceficationName,
    "productId": productId,
    "value": value,
  };
}
