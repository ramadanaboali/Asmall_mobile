import 'dart:convert';
import 'package:ashmall/Model/OneProductModel.dart';
import 'package:ashmall/Model/OrdersModel.dart';
import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Model/ProductRateModel.dart';
import 'package:ashmall/Model/ProductSpecificationModel.dart';
import 'package:ashmall/Model/QuestionModel.dart';
import 'package:ashmall/Model/SearchModel.dart';

import 'package:ashmall/Services/GlobalVarible.dart';
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
  Future<List<OrdersDetail>>getAllOrders(String lang,var id,var status)async
  {
    var url="${baseURL}api/order/get-all-orders-by-userId-and-status?userId=$id&status=$status";
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
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["orders"];
        return slideritems.map((e) => OrdersDetail.fromJson(e)).toList();
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
  Future<Map<String,dynamic>>addOrders(String lang,var user_id,double total,String address_id,List orderItem )async
  {
 //   Map<String, dynamic> result = Map.fromIterable(orderItem, key: (v) => v.ProductId.toString(), value: (v) => v.Quantity.toString());
    var url="${baseURL}api/order/add-order";
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    var body={
      "UserId":user_id,
      "TotalPrice":total,
      "ChargeAddressId":address_id,
      "CreatingOrderItemVMs" :orderItem
    };
      print(body);
    try
    {
      print("kkkk22");
      final response = await http.post(url,body:json.encode(body),headers: header);

      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        print("4444444444444444444444444");
        return json.decode(utf8.decode(response.bodyBytes));
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
  Future<List<QuestionDetail>>GetQuestion(String lang,var id)async
  {
    var url="${baseURL}api/faq/get-product-faq?id=$id";
    print(url);

    var header={
      "lang":lang
      //  "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["questionAnswers"];
        return slideritems.map((e) => QuestionDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<ProductSpecifiction>>GesProductSpefication(String lang,var id)async
  {
    var url="${baseURL}api/products/get-product-details?poductId=$id";
    print(url);

    var header={
      "lang":lang
      //  "Authorization":"Bearer $token"
    };
    try
    {
      final response = await http.get(url,headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["product"]["productSpeceficationDtos"];
        return slideritems.map((e) => ProductSpecifiction.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>addQuestion(String lang,String  questionText,String productId,String userId)async
  {
    var url="${baseURL}api/faq/add-question";
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    var body= {
        "questionText": questionText,
        "productId": productId,
        "userId": userId
      };
    print(body);
    try
    {
      print("kkkk22");
      final response = await http.post(url,body:json.encode(body),headers: header);

      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        print("4444444444444444444444444");
        return json.decode(utf8.decode(response.bodyBytes));
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>addAnswer(String lang,String AnswerText,String QuestionId,String UserId)async
  {
    var url="${baseURL}api/faq/add-answer";
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    var body=
      {
        "AnswerText": AnswerText,
        "QuestionId": QuestionId,
        "UserId": UserId
      };
    print(body);
    try
    {
      print("kkkk22");
      final response = await http.post(url,body:json.encode(body),headers: header);

      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        print("4444444444444444444444444");
        return json.decode(utf8.decode(response.bodyBytes));
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>SetRate(String lang,String token,String Comment,int RateNum,String ProductId,String UserId)async
  {
    var url="${baseURL}api/products/set-product-rate";
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang,
      "token":"Bearer "+token
    };
    var body={
      "Comment":Comment,
      "RateNum":RateNum,
      "ProductId":ProductId,
      "UserId":UserId
    };
    print(body);
    try
    {
      print("kkkk22");
      final response = await http.post(url,body:json.encode(body),headers: header);

      print(response.body);
      if(response.body!=null)
      {
        print("4444444444444444444444444");
        return json.decode(utf8.decode(response.bodyBytes));
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
}
class AddOrderDetail{
  String ProductId;
  int Quantity;
  AddOrderDetail({this.ProductId,this.Quantity});
  Map<String, dynamic> toJson() => {
    "ProductId": ProductId,
    "Quantity": Quantity,
  };
}