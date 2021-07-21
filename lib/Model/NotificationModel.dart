// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.notificationDetail,
    this.status,
    this.message,
  });

  List<NotificationDetail> notificationDetail;
  int status;
  String message;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    notificationDetail: List<NotificationDetail>.from(json["NotificationDetail"].map((x) => NotificationDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "NotificationDetail": List<dynamic>.from(notificationDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class NotificationDetail {
  NotificationDetail({
    this.id,
    this.title,
    this.notificationStatus,
    this.notificationType,
    this.navigationUrl,
    this.createdAt,
    this.lastModified,
    this.creationDate,
    this.creationTime,
  });

  String id;
  String title;
  int notificationStatus;
  int notificationType;
  String navigationUrl;
  DateTime createdAt;
  DateTime lastModified;
  String creationDate;
  String creationTime;

  factory NotificationDetail.fromJson(Map<String, dynamic> json) => NotificationDetail(
    id: json["id"],
    title: json["title"],
    notificationStatus: json["notificationStatus"],
    notificationType: json["notificationType"],
    navigationUrl: json["navigationURL"],
    createdAt: DateTime.parse(json["createdAt"]),
    lastModified: DateTime.parse(json["lastModified"]),
    creationDate: json["creationDate"],
    creationTime: json["creationTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "notificationStatus": notificationStatus,
    "notificationType": notificationType,
    "navigationURL": navigationUrl,
    "createdAt": createdAt.toIso8601String(),
    "lastModified": lastModified.toIso8601String(),
    "creationDate": creationDate,
    "creationTime": creationTime,
  };
}
