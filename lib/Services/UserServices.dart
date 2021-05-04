import 'dart:convert';
import 'dart:io';
import 'package:ashmall/Model/CityModel.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class UserServices{
  String baseURL=GlobalVariable.URl;

  Future<Map<String,dynamic>>login(String lang,String email,String password)async{
    String url=baseURL+"api/people/login";
    print(url);
    var body={
      "EMAIL" : email,
      "PASSWORD" : password,
    };
    print(body);
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    print(header);
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      print(responce.body);
      print("000000000000000000000000000000000000000");
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
  Future<Map<String,dynamic>>resetPassword(String lang,String email,String password)async{
    String url=baseURL+"api/people/reset";
    print(url);
    var body={
      "newPassword" : password,
      "confirmPassword" : password,
      "Email":email
    };
    var header={
      "Content-Type":"application/json",
      "lang":lang
    };
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      print(responce.body);
      print("000000000000000000000000000000000000000");
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
  Future<Map<String,dynamic>>editProfile(var id,var name,var email,var phone)async{
    String url=baseURL+"api/home/edit-profile";
    print(url);
    var body={
        "Id":id,
        "Name":name,
        "Email":email,
        "Phone":phone
    };
    var header={
      "Content-Type":"application/json",
      "lang":"en"
    };
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      print(responce.body);
      print("000000000000000000000000000000000000000");
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

  Future<Map<String,dynamic>>getUserInfo(String lang,String id,String token)async{
    String url=baseURL+"api/home/get-profile?id=$id";
    print(url);
    var header={
      "Content-Type":"application/json",
      "lang":lang,
      "Authorization":"Bearer $token"
    };
    print(header);
    try{
      final responce=await http.get(url,headers: header);
      print(responce.body);
      print("000000000000000000000000000000000000000");
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
  Future<Map<String,dynamic>>registerServices(var lang,var name,var email,var password, var phone ,var address)async{
    String url=baseURL+"api/people/register";
    var body={
      "Email":email,
      "Name":name,
      "Country":"Egypt",
      "Phone":phone,
      "State":"ALexandria",
      "City":"Meami",
      "Address":address,
      "Password":password
    };
    print(body);
    var header={
      "Content-Type":"application/json",
      "lang":"ar"
    };
    print(header);
    print(url);
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      print(responce.body);
      print("00000000000000000000000000000000000000000000000");
      if(responce.statusCode==200 && responce.body.isNotEmpty){
        print(responce.body);
        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<Map<String,dynamic>>checkCode(var phone,var code)async{
    String url="$baseURL/API/en/user/mobileActivation";
    var body={
      "phone":phone,
      "activecode":code
    };
    print('${url},,,,sssssssssssss,,,url');
    print('${json.encode(body)},,,,sssssssssssss,,,bodyyyyy');
    var header={
      "Content-Type":"application/json",
      "X-Auth-Token":"b9fe694397cfc048e0c93b67e0c856ac"
    };
    // print('$header,,,,sssssssssssss,,,headeeeeeeeeeeer');
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      if(responce.statusCode==200 && responce.body.isNotEmpty)
      {
        print(responce.body);
        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }

  Future<Map<String,dynamic>>forgetPassword(var user)async{
    String url="$baseURL/API/en/userForgetPassword/sendCode";
    var body={
      "username":user
    };
    //print('${json.encode(body)},,,,sssssssssssss,,,bodyyyyy');
    var header={
      "Content-Type":"application/json",
      "X-Auth-Token":"b9fe694397cfc048e0c93b67e0c856ac"
    };
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      if(responce.statusCode==200 && responce.body.isNotEmpty)
      {
        // print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<Map<String,dynamic>>checkCodeForgetPassword(var phone,var code)async{
    String url="$baseURL/API/en/userForgetPassword/checkCode";
    var body={
      "phone":phone,
      "activecode":code
    };
    // print('${json.encode(body)},,,,sssssssssssss,,,bodyyyyy');
    var header={
      "Content-Type":"application/json",
      "X-Auth-Token":"b9fe694397cfc048e0c93b67e0c856ac"
    };
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      if(responce.statusCode==200 && responce.body.isNotEmpty)
      {
        // print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }

  Future<Map<String,dynamic>>resetForgetPassword(var lang,var phone,var code,var password,var confirmPassword)async{
    String url="$baseURL/API/$lang/userForgetPassword/change";
    var body={
      "phone":phone,
      "activecode":code,
      "password":password,
      "verifypassword":confirmPassword
    };
    print(url);
    print('${json.encode(body)},,,,sssssssssssss,,,bodyyyyy');
    var header={
      "Content-Type":"application/json",
      "X-Auth-Token":"b9fe694397cfc048e0c93b67e0c856ac"
    };
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      if(responce.statusCode==200 && responce.body.isNotEmpty)
      {
        print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<Map<String,dynamic>>updateProfile(var id,var firstName,var lastName,var email,var phone)async{
    String url="$baseURL/API/en/user/updateProfile";
    var body={
      "user_id":id,
      "firstname":firstName,
      "lastname":lastName,
      "email":email,
      "phone":phone
    };
    //print('${json.encode(body)},,,,sssssssssssss,,,bodyyyyy');
    var header={
      "Content-Type":"application/json",
      "X-Auth-Token":"b9fe694397cfc048e0c93b67e0c856ac"
    };
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      if(responce.statusCode==200 && responce.body.isNotEmpty)
      {
        print(responce.body);
        print("8888888888888888888888888888888888888888888888888888888888888888");
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<Map<String,dynamic>>getProfile(var id)async{
    String url="$baseURL/API/en/user/profile";
    var body={
      "user_id":id
    };
    //print('${json.encode(body)},,,,sssssssssssss,,,bodyyyyy');
    var header={
      "Content-Type":"application/json",
      "X-Auth-Token":"b9fe694397cfc048e0c93b67e0c856ac"
    };
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      if(responce.statusCode==200 && responce.body.isNotEmpty)
      {
        // print(json.decode(responce.body)["Message"]);
        // print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        return json.decode(responce.body)["Message"];
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<Map<String,dynamic>>changePassword(var id,var oldPssword,var Password,var verifyPassword)async{
    String url="$baseURL/API/en/user/changePassword";
    var body={
      "user_id":id,
      "old_password":oldPssword,
      "password":Password,
      "verify_password":verifyPassword
    };
    //print('${json.encode(body)},,,,sssssssssssss,,,bodyyyyy');
    var header={
      "Content-Type":"application/json",
      "X-Auth-Token":"b9fe694397cfc048e0c93b67e0c856ac"
    };
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      if(responce.statusCode==200 && responce.body.isNotEmpty)
      {
        // print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
/*Future<Map<String,dynamic>>changeAvatar(File image,var user_id)async{
    String url="$baseURL/API/en/user/changeAvatar";
    var body={
      "avatar" : image,
      "password" : user_id,
    };
    print('$url,,,,,,,,,,,,url');
    print('${json.encode(body)},,,,,,,,,,,,bodyyyyy');
    var header={
      "Content-Type":"application/json",
      "X-Auth-Token":"b9fe694397cfc048e0c93b67e0c856ac"
    };
    print('$header,,,,,,,,,,,,header');
    try{
      final responce=await http.post(url,body:json.encode(body),headers: header);
      if(responce.statusCode==200 && responce.body.isNotEmpty)
      {
        print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }*/
  static updateAvatar(File fileImage,BuildContext context,var user_id)async
  {
    if (fileImage != null) {
      try {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        Dio dio = Dio();
        ///we used uri.encode to enable upload  image with arabic name
        // var url =Uri.encodeFull(createPath('user/editProfileImage'));
        var url = "${GlobalVariable.URl}/api/home/edit-profile-photo";
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
        });
        print(formData.fields);
        print("ssssssssssssssssss");
        Response response = await dio.post(url, data: formData);
        print('${response.data},,,,,,,,fields');
        print("ddddddddddddddddd");
        if (response.statusCode == 200) {
          Toast.show(
              "  تم تغير صورة الملف الشخصي ", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
        else {
          Toast.show(
              " فشل في تغير صورة الملف الشخصي ", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          return null;
        }
      }
      catch (e) {
        print('${e}imageuploaderror');
      }
    }
  }
  Future<List<CityDetail>>GetCities()async
  {
    var url="${baseURL}api/Lookups/get-governorates";
    print(url);
    try
    {
      final response = await http.get(url);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"];
        return slideritems.map((e) => CityDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }


}