import 'dart:convert';
import 'package:ashmool/Model/OneProductModel.dart';
import 'package:ashmool/Model/ProductModel.dart';
import 'package:ashmool/Model/ProductRateModel.dart';
import 'package:ashmool/Model/QuestionModel.dart';
import 'package:ashmool/Model/SearchModel.dart';
import 'package:ashmool/Services/GlobalVarible.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductServices{
  String baseURL=GlobalVariable.URl;
  Future<List<ProductDetail>>getlastAdd(String lang,var token)async
  {
    var url="${baseURL}api/home/get-last-added-products";
    print(url);
    var header={
      "lang":lang
     // "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["products"];
        return slideritems.map((e) => ProductDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<ProductDetail>>getBestSeller(String lang,var token)async
  {
    var url="${baseURL}api/home/get-preferred-products";
    print(url);
    var header={
      "lang":lang
    // "Authorization":"Bearer $token"
    };
    print(header);
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["products"];
        return slideritems.map((e) => ProductDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<ProductDetail>>getOffers(String lang,var token)async
  {
    var url="${baseURL}api/home/get-offered-products/";
    print(url);
    var header={
      "lang":lang
    //  "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["products"];
        return slideritems.map((e) => ProductDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }

  Future<Map<String,dynamic>>getProductDetails(String lang,var product_id)async
  {
    var url="${baseURL}api/products/get-product-details?poductId=$product_id";
    print(url);
    var header={
      "lang":lang
      //  "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        return json.decode(utf8.decode(response.bodyBytes))["product"];
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }

  Future<List<ProductRateDetail>>getProductRate(String lang,var id)async
  {
    var url="${baseURL}api/products/get-product-rate?Id=$id";
    print(url);
    var header={
      "lang":lang
      //  "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"];
        return slideritems.map((e) => ProductRateDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<ProductDetail>>getProductFromSubCategory(String lang,var id)async
  {
    var url="${baseURL}api/home/get-all-products-by-subCategory/$id";
    print(url);
    var header={
      "lang":lang
      //  "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["products"];
        return slideritems.map((e) => ProductDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<ProductDetail>>getProductFromBrand(String lang,var id)async
  {
    var url="${baseURL}api/home/get-all-products-by-brandId/$id";
    var header={
      "lang":lang
      //  "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["products"];
        return slideritems.map((e) => ProductDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<SearchItem>>Search(String lang,var key)async
  {
    var url="${baseURL}api/home/search/?searchValue=$key";
    var header={
      "lang":lang
      //  "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["searchResult"];
        return slideritems.map((e) => SearchItem.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<QuestionDetail>>GetQuestion(String lang,var key)async
  {
    var url="${baseURL}api/home/search/?searchValue=$key";
    var header={
      "lang":lang
      //  "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["searchResult"];
        return slideritems.map((e) => QuestionDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
}