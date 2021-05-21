// To parse this JSON data, do
//
//     final followerModel = followerModelFromJson(jsonString);

import 'dart:convert';

FollowerModel followerModelFromJson(String str) => FollowerModel.fromJson(json.decode(str));

String followerModelToJson(FollowerModel data) => json.encode(data.toJson());

class FollowerModel {
  FollowerModel({
    this.followerDetail,
    this.status,
    this.message,
  });

  List<FollowerDetail> followerDetail;
  int status;
  String message;

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
    followerDetail: List<FollowerDetail>.from(json["followerDetail"].map((x) => FollowerDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "followerDetail": List<dynamic>.from(followerDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class FollowerDetail {
  FollowerDetail({
    this.id,
    this.name,
    this.email,
    this.type,
    this.phone,
    this.photo,
    this.password,
    this.isHasTempPassword,
    this.tempPassword,
    this.isDeleted,
    this.isBlocked,
    this.creationDateTime,
    this.modificationDateTime,
    this.token,
    this.gender,
    this.dateOfBirth,
    this.credibility,
  });

  String id;
  String name;
  String email;
  int type;
  String phone;
  String photo;
  String password;
  bool isHasTempPassword;
  dynamic tempPassword;
  bool isDeleted;
  bool isBlocked;
  DateTime creationDateTime;
  dynamic modificationDateTime;
  dynamic token;
  String gender;
  DateTime dateOfBirth;
  bool credibility;

  factory FollowerDetail.fromJson(Map<String, dynamic> json) => FollowerDetail(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    type: json["type"],
    phone: json["phone"],
    photo: json["photo"],
    password: json["password"],
    isHasTempPassword: json["isHasTempPassword"],
    tempPassword: json["tempPassword"],
    isDeleted: json["isDeleted"],
    isBlocked: json["isBlocked"],
    creationDateTime: DateTime.parse(json["creationDateTime"]),
    modificationDateTime: json["modificationDateTime"],
    token: json["token"],
    gender: json["gender"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    credibility: json["credibility"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "type": type,
    "phone": phone,
    "photo": photo,
    "password": password,
    "isHasTempPassword": isHasTempPassword,
    "tempPassword": tempPassword,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "creationDateTime": creationDateTime.toIso8601String(),
    "modificationDateTime": modificationDateTime,
    "token": token,
    "gender": gender,
    "dateOfBirth": dateOfBirth.toIso8601String(),
    "credibility": credibility,
  };
}
