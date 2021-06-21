import 'dart:convert';
import 'package:ashmall/Model/CityModel.dart';
import 'package:ashmall/Model/ZoneModel.dart';
import 'package:http/http.dart' as http;
import 'package:ashmall/Model/AddressModel.dart';

import 'GlobalVarible.dart';

class AddressServices{
  String baseURL=GlobalVariable.URl;
  Future<List<AddressDetail>>getAllAddresses(String lang,var id)async
  {
    var url="${baseURL}api/addsress/get-all-addresses-by-userId?userId=$id";
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
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"];
        return slideritems.map((e) => AddressDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>AddAddress(String lang,String user_id,String phone ,String country,String city,String address)async{
    String url=baseURL+"api/addsress/add-address";
    print(url);
    var body={
      "Phone":phone,
      "Address":address,
      "Country":country,
      "State":"000",
      "City":city,
      "Email":"asd@mail.com",
      "UserId":user_id
    };
    print(body);
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
  Future<Map<String,dynamic>>deleteAddress(String lang,String id)async{
    String url=baseURL+"api/addsress/delete-address?id=$id";
    print(url);
    var header={
      "lang":lang
    };
    print(header);
    try{
      final responce=await http.delete(url,headers: header);
      print(responce.body);
      print("*********************************************");
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
  Future<List<ZoneDetail>>GetCityZone(var id)async
  {
    var url="${baseURL}api/Lookups/get-cities-by-governorateId?governorateId=$id";
    print(url);
    try
    {
      final response = await http.get(url);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"];
        return slideritems.map((e) => ZoneDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
}