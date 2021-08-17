import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
class UpdateVersion extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return _state();
  }
}
class _state extends State<UpdateVersion>{
  home h=new home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.25),
            Image.asset("images/logo.png",
            height: MediaQuery.of(context).size.height*.25,
            ),
            Expanded(child: SizedBox()),
            GestureDetector(
              onTap: ()=>launchURL(),
              child: Container(
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(h.mainColor),
                ),
                height: MediaQuery.of(context).size.height*.065,
                width: MediaQuery.of(context).size.width*.9,
                alignment: Alignment.center,
                child:   Text("UpdateVersion",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.25),
          ],
        ),
      ),
    );
  }
  launchURL() async {
    if (await canLaunch("https://play.google.com/store/apps/details?id=com.app.ashmall")) {
      await launch("https://play.google.com/store/apps/details?id=com.app.ashmall");
    } else {
      throw 'Could not launch https://play.google.com/store/apps/details?id=com.app.ashmall';
    }
  }

}