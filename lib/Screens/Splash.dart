import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return splashState();
  }
}
class  splashState extends State<Splash>{
  home h=new home();
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
    Timer(Duration(seconds: 3), (){
      Navigator.of(context)
          .pushNamedAndRemoveUntil(lang==null?"/FirstLanguage":'/mainPage',
              (Route<dynamic> route) => false);
      // Phoenix.rebirth(context);
    });
    return Container(
        decoration: new BoxDecoration(
          color: Color(h.mainColor),
        ),
        child: Column(
          children: [
            SizedBox( height: MediaQuery.of(context).size.height*.15,),
            Image.asset("images/logo.png",
            height: MediaQuery.of(context).size.height*.23,
              color: Colors.white,
            ),
            Expanded(child: SizedBox()),
            Text("Please wait for the application to load",style: TextStyle(fontFamily: "mishwarfont",decoration: TextDecoration.none,fontSize: 12,color: Colors.white),),
            SizedBox(height: 7,),
            Text("من فضلك انتظر تحميل التطبيق",style: TextStyle(fontFamily: "mishwarfont",decoration: TextDecoration.none,fontSize: 12,color: Colors.white),),
            // Text("Please Waite For Application Loading",style: TextStyle(fontFamily: "mishwarfont",decoration: TextDecoration.none,fontSize: 11,color: Colors.white),),
            SizedBox(height: MediaQuery.of(context).size.height*.08,)
          ],
        )
    );
  }
}