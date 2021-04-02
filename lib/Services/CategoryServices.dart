import 'dart:convert';
import 'package:ashmall/Model/CategoryModel.dart';
import 'package:ashmall/Model/SubCategoryModel.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:http/http.dart' as http;

class CategoryServices{
  String baseURL=GlobalVariable.URl;
  Future<List<CategoryDetail>>getAllCategory(String lang,var token)async
  {
    var url="${baseURL}api/categories/get-all-categories";
    print(url);
    var header={
      "lang":lang,
      "Authorization":"Bearer $token"
    };
    print(header);
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["categories"];
        return slideritems.map((e) => CategoryDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<SubCategoryDetail>>getSubCategory(String lang,var id)async
  {
    var url="${baseURL}api/categories/get-all-sub-categories/$id";
    print(url);
    var header={
      "lang":lang,
    };
    print(header);
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["subCategories"];
        return slideritems.map((e) => SubCategoryDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<SubCategoryDetail>>getAllSubCategory(String lang)async
  {
    var url="${baseURL}api/home/get-all-sub-categories";
    print(url);
    var header={
      "lang":lang,
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["subCategories"];
        return slideritems.map((e) => SubCategoryDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<SubCategoryDetail>>getAllBrand(String lang)async
  {
    var url="${baseURL}api/home/get-all-brands";
    print(url);
    var header={
      "lang":lang,
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["brands"];
        return slideritems.map((e) => SubCategoryDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }


}