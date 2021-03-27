import 'dart:async';

import 'package:ashmool/Screens/CustomAppBar.dart';
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
/*    Timer(Duration(seconds: 5), (){
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login',
              (Route<dynamic> route) => false);
      // Phoenix.rebirth(context);
    });*/
    return SafeArea(
      child: Scaffold(
        body: Container(
          height:MediaQuery.of(context).size.height,
          child: Column(
            children: [
              CustomAppBar("Verification"),
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