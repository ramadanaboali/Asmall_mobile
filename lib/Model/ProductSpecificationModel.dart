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
    this.speceficationKey,
    this.productId,
    this.value,
  });

  String id;
  String speceficationId;
  String speceficationKey;
  String productId;
  String value;

  factory ProductSpecifiction.fromJson(Map<String, dynamic> json) => ProductSpecifiction(
    id: json["id"],
    speceficationId: json["speceficationId"],
    speceficationKey: json["speceficationKey"],
    productId: json["productId"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "speceficationId": speceficationId,
    "speceficationKey": speceficationKey,
    "productId": productId,
    "value": value,
  };
}
