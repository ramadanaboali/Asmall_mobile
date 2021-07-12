import 'dart:async';

import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class VerificationDone extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<VerificationDone>{
  home h=new home();
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), (){
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/loginHome',
              (Route<dynamic> route) => false);
      // Phoenix.rebirth(context);
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text(DemoLocalizations.of(context).title["verification"],style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          elevation: 0,
          leading: GestureDetector(child: Icon(Icons.arrow_back),onTap: (){Navigator.pop(context);},),
          //  actions: [Icon(Icons.arrow_back)],
          iconTheme: IconThemeData(
              color: Colors.black
          ),
        ),
        body: Container(
          height:MediaQuery.of(context).size.height,
          child: Column(
            children: [
              //CustomAppBar("Verification"),
              Expanded(child: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.15,),
                    Icon(Icons.check_circle,color: Color(h.mainColor),size: 170,),
                    SizedBox(height: MediaQuery.of(context).size.height*.015,),
                    Container(
                        width: MediaQuery.of(context).size.width*.8,
                        child: Text("Your Account Has Been Activited",textAlign: TextAlign.center,style: TextStyle(height: 1.6,color: Colors.black54,fontSize: 16,fontWeight: FontWeight.bold),)),

                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}