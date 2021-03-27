import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CustomAppBar extends StatefulWidget{
  String Title;
  CustomAppBar(String Title){
    this.Title=Title;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.Title);
  }
}
class _state extends State<CustomAppBar>{
  home h=new home();
  String Title;
  _state(String Title){
    this.Title=Title;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.07,
      width: MediaQuery.of(context).size.width,
      color: Color(h.mainColor),
      padding: EdgeInsets.only(
        left: 10,
        right: 20,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 25,)),
          Text(this.Title,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
          GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.notifications,color: Colors.white,size: 25,))
        ],
      ),
    );
  }
}