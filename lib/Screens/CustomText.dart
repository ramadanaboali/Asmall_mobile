import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText{
  static Widget TitleText(String content){
    return  Text(content,style: TextStyle(color: Colors.black87.withOpacity(.6),fontSize: 16,fontWeight: FontWeight.bold),);
  }
  static Widget SubTitleText(String content){
    return  Text(content,maxLines: 1,style: TextStyle(color: Colors.black87.withOpacity(.6),fontSize: 12,fontWeight: FontWeight.w700),);
  }
  static Widget CustomText10(String content){
    return  Text(content,maxLines: 1,style: TextStyle(color: Colors.black87.withOpacity(.6),fontSize: 10,fontWeight: FontWeight.bold),);
  }
  static Widget CustomTextOffers(String content){
    return  Text(content,maxLines: 1,style: TextStyle(color: Colors.black87.withOpacity(.4),fontSize: 10,decoration: TextDecoration.lineThrough,fontWeight: FontWeight.bold),);
  }

}