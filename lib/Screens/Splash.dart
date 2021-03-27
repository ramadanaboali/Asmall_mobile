import 'package:ashmool/main.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return splashState();
  }
}
class  splashState extends State<Splash>{
  home h=new home();

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), (){
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/mainPage',
              (Route<dynamic> route) => false);
      // Phoenix.rebirth(context);
    });

    return Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('images/Splash.png'),
            fit: BoxFit.cover,
          ),
          color: Color(h.mainColor),
        ),
        child: Column(
          children: [
            Expanded(child: SizedBox()),
            Text("Please wait for the application to load",style: TextStyle(fontFamily: "mishwarfont",decoration: TextDecoration.none,fontSize: 12,color: Colors.white),),
            SizedBox(height: 7,),
            Text("من فضلك انتظر تحميل التطبيق",style: TextStyle(fontFamily: "mishwarfont",decoration: TextDecoration.none,fontSize: 12,color: Colors.white),),
            // Text("Please Waite For Application Loading",style: TextStyle(fontFamily: "mishwarfont",decoration: TextDecoration.none,fontSize: 11,color: Colors.white),),
            SizedBox(height: MediaQuery.of(context).size.height*.2,)
          ],
        )
    );
  }
}