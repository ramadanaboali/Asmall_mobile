// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.addressDetail,
    this.status,
    this.message,
  });

  List<AddressDetail> addressDetail;
  int status;
  String message;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    addressDetail: List<AddressDetail>.from(json["AddressDetail"].map((x) => AddressDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "AddressDetail": List<dynamic>.from(addressDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class AddressDetail {
  AddressDetail({
    this.id,
    this.userName,
    this.phone,
    this.address,
    this.country,
    this.state,
    this.city,
    this.email,
    this.isDefault,
    this.isDeleted,
    this.userId,
  });

  String id;
  String userName;
  String phone;
  String address;
  String country;
  String state;
  String city;
  String email;
  bool isDefault;
  bool isDeleted;
  String userId;

  factory AddressDetail.fromJson(Map<String, dynamic> json) => AddressDetail(
    id: json["id"],
    userName: json["userName"],
    phone: json["phone"],
    address: json["address"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    email: json["email"],
    isDefault: json["isDefault"],
    isDeleted: json["isDeleted"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "phone": phone,
    "address": address,
    "country": country,
    "state": state,
    "city": city,
    "email": email,
    "isDefault": isDefault,
    "isDeleted": isDeleted,
    "userId": userId,
  };
}
