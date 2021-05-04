import 'package:ashmall/Screens/AboutApp.dart';
import 'package:ashmall/Screens/CustomText.dart';
import 'package:ashmall/Screens/PrivacyPolices.dart';
import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../GlobalFunction.dart';
import 'UsagePolices.dart';

class ProfileSetting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state  extends State<ProfileSetting>{
  home h=new home();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomText.TitleText("الاعدادات"),
        ),
         body: Container(
           color: Colors.black12,
           padding: EdgeInsets.only(
             left: MediaQuery.of(context).size.width*.03,
             right: MediaQuery.of(context).size.width*.03,
             top: MediaQuery.of(context).size.height*.02
           ),
           child: Column(
             children: [
               Container(
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(10)),
                   border: Border.all(color:Colors.black12,width: 1),
                   color: Colors.white
                 ),
                 padding: EdgeInsets.only(
                   left: MediaQuery.of(context).size.width*.03,
                   right: MediaQuery.of(context).size.width*.03,
                   top: MediaQuery.of(context).size.height*.01,
                   bottom: MediaQuery.of(context).size.height*.01
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     GestureDetector(
                         onTap: (){
                           Navigator.pushNamed(context, "/Profile");
                         },
                         child: CustomText.TitleText("- Profile")),
                     CustomText.TitleText("- Shipping Address")
                   ],
                 ),
               ),
               SizedBox(height: 10,),
               Container(
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     border: Border.all(color:Colors.black12,width: 1),
                   color: Colors.white
                 ),
                 padding: EdgeInsets.only(
                     left: MediaQuery.of(context).size.width*.03,
                     right: MediaQuery.of(context).size.width*.03,
                     top: MediaQuery.of(context).size.height*.01,
                     bottom: MediaQuery.of(context).size.height*.01
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         CustomText.TitleText("- Currency"),
                         CustomText.TitleText("LE"),

                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         CustomText.TitleText("- Language"),
                         CustomText.TitleText("EN"),

                       ],
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 10,),
               Container(
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     border: Border.all(color:Colors.black12,width: 1),
                   color: Colors.white
                 ),
                 padding: EdgeInsets.only(
                     left: MediaQuery.of(context).size.width*.03,
                     right: MediaQuery.of(context).size.width*.03,
                     top: MediaQuery.of(context).size.height*.015,
                     bottom: MediaQuery.of(context).size.height*.015
                 ),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     CustomText.TitleText("- Rate Ashmall"),
                     GestureDetector(
                         onTap: (){
                           Navigator.push(context, GlobalFunction.route(PrivacyPolices()));
                         },
                         child: CustomText.TitleText("- Privacy Polices")),
                     GestureDetector(
                         onTap: (){
                           Navigator.push(context, GlobalFunction.route(UsagePolices()));
                         },child: CustomText.TitleText("- Usage Polices")),
                     GestureDetector(
                         onTap: (){
                           Navigator.push(context, GlobalFunction.route(AboutApp()));
                         },
                         child: CustomText.TitleText("- About App"))
                   ],
                 ),
               ),
               SizedBox(height: MediaQuery.of(context).size.height*.05,),
               Expanded(
                 child: Image.asset("images/logo.png",color: Color(h.mainColor),),
               ),
               SizedBox(height: 10,),
               CustomText.SubTitleText("Ashmall.com Version 1.0.0"),
               CustomText.SubTitleText("All Rights Reserved"),
               SizedBox(height: MediaQuery.of(context).size.height*.05,),
             ],
           ),
         ),
      ),
    );
  }
}