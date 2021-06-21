import 'dart:convert';
import 'dart:io';
import 'package:ashmall/Model/BanarModel.dart';
import 'package:ashmall/Model/OneProductModel.dart';
import 'package:ashmall/Model/OrdersModel.dart';
import 'package:ashmall/Model/Product1Model.dart';
import 'package:ashmall/Model/Product2Model.dart';
import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Model/ProductRateModel.dart';
import 'package:ashmall/Model/ProductSpecificationModel.dart';
import 'package:ashmall/Model/QuestionModel.dart';
import 'package:ashmall/Model/SearchModel.dart';
import 'package:ashmall/Model/SemillarModel.dart';
import 'package:ashmall/Model/SidesModel.dart';
import 'package:ashmall/Model/VendorModel.dart';
import 'package:ashmall/Screens/VendorCategory.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

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
  Future<List<Product1Detail>>getLastWatched(String lang,var user_id)async
  {
    var url="${baseURL}api/productWatch/get-productWatch/$user_id";
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
        return slideritems.map((e) => Product1Detail.fromJson(e)).toList();
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
  Future<List<ProductColorModel>>getProductColor(String lang,var product_id)async
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
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["product"]["colorDtos"];
        return slideritems.map((e) => ProductColorModel.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<SidesDetail>>getProductSides(String lang,var product_id)async
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
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["product"]["sidesDtos"];
        return slideritems.map((e) => SidesDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<ProductSizeModel>>getProductSize(String lang,var product_id)async
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
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["product"]["productSizeDtos"];
        return slideritems.map((e) => ProductSizeModel.fromJson(e)).toList();
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
    print("4444444444444444444444444444444");
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    print(header);
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
  Future<List<ProductRateDetail>>getProductRateWithImage(String lang,var id)async
  {
    var url="${baseURL}api/products/get-product-rate-with-image?id=$id";
    print(url);
    print("sssssssssssssssssssssssssssssssssssssssssssssss");
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
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["product"]["productSpeceficationVMs"];
        return slideritems.map((e) => ProductSpecifiction.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<BanarDetail>>getBanar(String lang)async
  {
    var url="${baseURL}api/advertisements/get-advertisements";
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
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["advertisements"];
        return slideritems.map((e) => BanarDetail.fromJson(e)).toList();
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
  Future<Map<String,dynamic>>addWatch(String lang,String Product_id,String UserId)async
  {
    var url="${baseURL}api/productWatch/add-productWatch";
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    var body=
    {
      "ProductId":Product_id,
      "UserId":UserId
    };
    print(body);
    try
    {
      print("kkkk22");
      final response = await http.post(url,body:json.encode(body),headers: header);

      print(response.body);
      print("88888888888888888888888888888888888888888");
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
  Future<Map<String,dynamic>>getSetting(String lang)async{
    String url=baseURL+"api/settings/get-settings";
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    try{
      final responce=await http.get(url,headers: header);
      if(responce.body.isNotEmpty)
      {
        print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<Map<String,dynamic>>getvendorData(String lang,String id)async{
    String url=baseURL+"api/products/get-store-data?vendorId=$id";
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    try{
      final responce=await http.get(url,headers: header);
      if(responce.body.isNotEmpty)
      {
        print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<List<ProductDetail>>getVendorProduct(String lang,var id)async
  {
    String url=baseURL+"api/products/get-store-data?vendorId=$id";
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"]["allProducts"];
        return slideritems.map((e) => ProductDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<ProductDetail>>getVendorLastAdded(String lang,var id)async
  {
    String url=baseURL+"api/products/get-store-data?vendorId=$id";
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"]["lastAdded"];
        return slideritems.map((e) => ProductDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<ProductDetail>>getProductVendorCategory(String lang,var vendor_id,var sub_id)async
  {
    String url=baseURL+"api/products/get-all-products-by-subCategory-and-userId?subId=$sub_id&userId=$vendor_id";
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    try
    {
      final response = await http.get(url,headers: header);
      print(response.body);
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
  Future<List<VendorGallary>>getVendorGallery(String lang,var id)async
  {
    String url=baseURL+"api/products/get-store-data?vendorId=$id";
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"]["vendorGallaryDtos"];
        return slideritems.map((e) => VendorGallary.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<SubCategoryVm>>getVendorGategory(String lang,var id)async
  {
    String url=baseURL+"api/products/get-store-data?vendorId=$id";
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    try
    {
      final response = await http.get(url,headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"]["subCategoryVMs"];
        return slideritems.map((e) => SubCategoryVm.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<SemillarDetail>>getSemillarProduct(String lang,var id)async
  {
    String url=baseURL+"api/products/get-all-Similar-products/$id";
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    try
    {
      final response = await http.get(url,headers: header);
      print(response.body);
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2");
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["products"];
        return slideritems.map((e) => SemillarDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>addFollowers(String lang,String token,String vendor_id,String UserId)async
  {
    var url="${baseURL}api/follower/add-follower";
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang,
      "token":"Bearer "+token
    };
    var body= {
        "UserId":UserId,
        "VendorId":vendor_id
      };
    print(body);
    try
    {
      final response = await http.post(url,body:json.encode(body),headers: header);
      print(response.body);
      if(response.body!=null)
      {
        return json.decode(utf8.decode(response.bodyBytes));
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>getFollowStatus(String lang,String token,String vendor_id,String UserId)async
  {
    var url="${baseURL}api/follower/get-follower/$UserId/$vendor_id";
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang,
      "token":"Bearer "+token
    };
    try
    {
      final response = await http.get(url,headers: header);
      print(response.body);
      if(response.body!=null)
      {
        return json.decode(utf8.decode(response.bodyBytes));
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>deleteFollower(String lang,String token,String vendor_id,String UserId)async
  {
    var url="${baseURL}api/follower/delete-follower?userId=$UserId&vendorId=$vendor_id";
    var header={
      "Content-Type":"application/json",
      "lang":lang,
      "token":"Bearer "+token
    };
    try
    {
      final response = await http.delete(url,headers: header);
      print(response.body);
      if(response.body!=null)
      {
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
    print(header);
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
  static SetRateServices(File fileImage,BuildContext context,var user_id,var Comment,var RateNum,var ProductId)async
  {
    if (fileImage != null) {
      try {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        Dio dio = Dio();
        ///we used uri.encode to enable upload  image with arabic name
        // var url =Uri.encodeFull(createPath('user/editProfileImage'));
        var url = "${GlobalVariable.URl}/api/products/set-product-rate";
        print(url);
        String fileName = basename(fileImage.path);
        // print('${fileName},,,,fileName');
        //print('${pathImage.path},,,,imagePath.path');

        FormData formData = FormData.fromMap({
          "File": await MultipartFile.fromFile(
              fileImage.path, filename: fileName
              , contentType: MediaType('image', fileName
              .split('.')
              .last)),
          "UserId": user_id,
          "RateNum":RateNum,
          "ProductId":ProductId,
          "Comment":Comment
        });
        print(formData.fields);
        print("ssssssssssssssssss");
        Response response = await dio.post(url, data: formData);
        print('${response.data},,,,,,,,fields');
        print("ddddddddddddddddd");
        if (response.statusCode == 200) {
          Toast.show(
              "  تم اضافة التقيم الخاص بك ", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
        else {
          Toast.show(
              " تم اضافة التقيم من قبل ", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          return null;
        }
      }
      catch (e) {
        print('${e}imageuploaderror');
      }
    }
  }
}
class AddOrderDetail{
  String ProductId;
  int Quantity;
  String ColorId;
  String ProductSizeId;
  AddOrderDetail({this.ProductId,this.Quantity,this.ColorId,this.ProductSizeId});
  Map<String, dynamic> toJson() => {
    "ProductId": ProductId,
    "Quantity": Quantity,
    "ColorId":ColorId,
    "ProductSizeId":ProductSizeId
  };
}