import 'dart:convert';
import 'package:ashmool/Services/GlobalVarible.dart';
import 'package:http/http.dart' as http;

class UserServices{
  String baseURL=GlobalVariable.URl;

  Future<Map<String,dynamic>>login(var lang,var email,var password)async{
    String url=baseURL+"api/people/login";
    print(url);
    var body={
      "email" : email,
      "password" : password,
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


}