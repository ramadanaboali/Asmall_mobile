// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  QuestionModel({
    this.questionDetail,
    this.status,
    this.message,
  });

  List<QuestionDetail> questionDetail;
  int status;
  String message;

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    questionDetail: List<QuestionDetail>.from(json["QuestionDetail"].map((x) => QuestionDetail.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "QuestionDetail": List<dynamic>.from(questionDetail.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class QuestionDetail{
  QuestionDetail({
    this.questionDto,
    this.answerDtos,
  });

  QuestionDto questionDto;
  List<AnswerDto> answerDtos;

  factory QuestionDetail.fromJson(Map<String, dynamic> json) => QuestionDetail(
    questionDto: QuestionDto.fromJson(json["questionDto"]),
    answerDtos: List<AnswerDto>.from(json["answerDtos"].map((x) => AnswerDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questionDto": questionDto.toJson(),
    "answerDtos": List<dynamic>.from(answerDtos.map((x) => x.toJson())),
  };
}

class AnswerDto {
  AnswerDto({
    this.id,
    this.answerText,
    this.questionQuestionText,
    this.questionId,
    this.userId,
    this.userName,
    this.userPhoto,
    this.isDeleted,
  });

  String id;
  String answerText;
  String questionQuestionText;
  String questionId;
  String userId;
  UserName userName;
  UserPhoto userPhoto;
  bool isDeleted;

  factory AnswerDto.fromJson(Map<String, dynamic> json) => AnswerDto(
    id: json["id"],
    answerText: json["answerText"],
    questionQuestionText: json["questionQuestionText"],
    questionId: json["questionId"],
    userId: json["userId"],
    userName: userNameValues.map[json["userName"]],
    userPhoto: userPhotoValues.map[json["userPhoto"]],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "answerText": answerText,
    "questionQuestionText": questionQuestionText,
    "questionId": questionId,
    "userId": userId,
    "userName": userNameValues.reverse[userName],
    "userPhoto": userPhotoValues.reverse[userPhoto],
    "isDeleted": isDeleted,
  };
}

enum UserName { MUHAMMAD_RAYAN, ISLAM_ALI, ALI_HASSAN }

final userNameValues = EnumValues({
  "ali hassan": UserName.ALI_HASSAN,
  "islam ali": UserName.ISLAM_ALI,
  "Muhammad Rayan": UserName.MUHAMMAD_RAYAN
});

enum UserPhoto { UPLOAD_DEFAULT_ADMIN_JPG, UPLOAD_USER_221613947838007_JPG, UPLOAD_USER_251613947852839_JPG }

final userPhotoValues = EnumValues({
  "/Upload/Default/admin.jpg": UserPhoto.UPLOAD_DEFAULT_ADMIN_JPG,
  "/Upload/User/22_1613947838007.jpg": UserPhoto.UPLOAD_USER_221613947838007_JPG,
  "/Upload/User/25_1613947852839.jpg": UserPhoto.UPLOAD_USER_251613947852839_JPG
});

class QuestionDto {
  QuestionDto({
    this.id,
    this.questionText,
    this.productId,
    this.productNameEn,
    this.userId,
    this.userName,
    this.userPhoto,
    this.isDeleted,
  });

  String id;
  String questionText;
  String productId;
  String productNameEn;
  String userId;
  UserName userName;
  UserPhoto userPhoto;
  bool isDeleted;

  factory QuestionDto.fromJson(Map<String, dynamic> json) => QuestionDto(
    id: json["id"],
    questionText: json["questionText"],
    productId: json["productId"],
    productNameEn: json["productNameEn"],
    userId: json["userId"],
    userName: userNameValues.map[json["userName"]],
    userPhoto: userPhotoValues.map[json["userPhoto"]],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionText": questionText,
    "productId": productId,
    "productNameEn": productNameEn,
    "userId": userId,
    "userName": userNameValues.reverse[userName],
    "userPhoto": userPhotoValues.reverse[userPhoto],
    "isDeleted": isDeleted,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
