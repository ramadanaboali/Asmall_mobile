// To parse this JSON data, do
//
//     final vendorModel = vendorModelFromJson(jsonString);

import 'dart:convert';

VendorModel vendorModelFromJson(String str) => VendorModel.fromJson(json.decode(str));

String vendorModelToJson(VendorModel data) => json.encode(data.toJson());

class VendorModel {
  VendorModel({
    this.data,
    this.status,
    this.message,
  });

  Data data;
  int status;
  String message;

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
    data: Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.gender,
    this.video,
    this.credibility,
    this.showCommunicationData,
    this.rate,
    this.numbersOfFollowers,
    this.vendorAllProductModel,
    this.vendorLastAdded,
    this.vendorGallary,
    this.subCategoryVMs,
  });

  String id;
  String name;
  String email;
  String phone;
  String photo;
  String gender;
  String video;
  bool credibility;
  bool showCommunicationData;
  int rate;
  int numbersOfFollowers;
  List<Vendor> vendorAllProductModel;
  List<Vendor> vendorLastAdded;
  List<VendorGallary> vendorGallary;
  List<SubCategoryVm> subCategoryVMs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    gender: json["gender"],
    video: json["video"],
    credibility: json["credibility"],
    showCommunicationData: json["showCommunicationData"],
    rate: json["rate"],
    numbersOfFollowers: json["numbersOfFollowers"],
    vendorAllProductModel: List<Vendor>.from(json["VendorAllProductModel"].map((x) => Vendor.fromJson(x))),
    vendorLastAdded: List<Vendor>.from(json["VendorLastAdded"].map((x) => Vendor.fromJson(x))),
    vendorGallary: List<VendorGallary>.from(json["vendorGallary"].map((x) => VendorGallary.fromJson(x))),
    subCategoryVMs: List<SubCategoryVm>.from(json["subCategoryVMs"].map((x) => SubCategoryVm.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    "gender": gender,
    "video": video,
    "credibility": credibility,
    "showCommunicationData": showCommunicationData,
    "rate": rate,
    "numbersOfFollowers": numbersOfFollowers,
    "VendorAllProductModel": List<dynamic>.from(vendorAllProductModel.map((x) => x.toJson())),
    "VendorLastAdded": List<dynamic>.from(vendorLastAdded.map((x) => x.toJson())),
    "vendorGallary": List<dynamic>.from(vendorGallary.map((x) => x.toJson())),
    "subCategoryVMs": List<dynamic>.from(subCategoryVMs.map((x) => x.toJson())),
  };
}

class SubCategoryVm {
  SubCategoryVm({
    this.id,
    this.name,
    this.categoryId,
    this.photo,
  });

  String id;
  String name;
  String categoryId;
  String photo;

  factory SubCategoryVm.fromJson(Map<String, dynamic> json) => SubCategoryVm(
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

class Vendor {
  Vendor({
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

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
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

class VendorGallary {
  VendorGallary({
    this.id,
    this.image,
    this.userId,
  });

  String id;
  String image;
  String userId;

  factory VendorGallary.fromJson(Map<String, dynamic> json) => VendorGallary(
    id: json["id"],
    image: json["image"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "userId": userId,
  };
}
