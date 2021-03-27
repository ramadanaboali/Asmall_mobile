// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.searchItem,
    this.status,
    this.message,
  });

  List<SearchItem> searchItem;
  int status;
  String message;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    searchItem: List<SearchItem>.from(json["SearchItem"].map((x) => SearchItem.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "SearchItem": List<dynamic>.from(searchItem.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class SearchItem {
  SearchItem({
    this.id,
    this.name,
    this.photo,
    this.type,
  });

  String id;
  String name;
  String photo;
  int type;

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "type": type,
  };
}
