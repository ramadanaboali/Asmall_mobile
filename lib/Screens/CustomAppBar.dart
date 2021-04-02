import 'package:ashmall/HomePage.dart';
import 'package:ashmall/Screens/Favourite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalFunction.dart';
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
  var lang;
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      lang=prefs.getString("lang");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
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
              child: Icon(lang=="en"?Icons.arrow_back_ios_rounded:Icons.arrow_forward_ios_rounded,color: Colors.white,size: 25,)),
          Text(this.Title,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
          GestureDetector(
              onTap: (){
                Navigator.push(context, GlobalFunction.routeBottom(HomePage(2)));
              },
              child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 25,))
        ],
      ),
    );
  }
}