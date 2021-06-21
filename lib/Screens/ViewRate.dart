import 'package:ashmall/Screens/CustRate.dart';
import 'package:ashmall/Screens/CustomSearchAppBar.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:flutter/cupertino.dart';
import 'package:ashmall/Model/ProductRateModel.dart';
import 'package:flutter/material.dart';

import '../main.dart';
class ViewRate extends StatefulWidget{
  ProductRateDetail rate;
  ViewRate(ProductRateDetail rate){
    this.rate=rate;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(rate);
  }
}
class _state extends State<ViewRate>{
  home h=new home();
  ProductRateDetail rate;
  _state(ProductRateDetail rate){
    this.rate=rate;
  }
  @override
  Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         body: Container(
           child: Column(
             children: [
               CustomSearchAppBar(),
               Container(
                 height: MediaQuery.of(context).size.height*.6,
                 width: MediaQuery.of(context).size.width*.9,
                 child: Image.network(GlobalVariable.URl+rate.photo,fit: BoxFit.cover),
               ),
              SizedBox(height: 15,),
              Container(
                   width: MediaQuery.of(context).size.width,
                   padding: EdgeInsets.only(
                     left: MediaQuery.of(context).size.width*.05,
                     right: MediaQuery.of(context).size.width*.05,
                   ),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Container(
                                 width: 35,height: 35,
                                 child: ClipRRect(
                                     borderRadius: BorderRadius.all(Radius.circular(100)),
                                     child: Image.network(GlobalVariable.URl+rate.userPhoto,fit: BoxFit.cover)),
                               ),
                               SizedBox(width: 10,),
                               Text(rate.userName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),)
                             ],
                           ),
                           CustomRate(rate.rateNum.round(), 17)
                         ],
                       ),
                       SizedBox(height: 15,),
                       Container(
                           width:  MediaQuery.of(context).size.width*.9,
                           child: Text(rate.comment,style: TextStyle(color: Colors.black54),))
                     ],
                   ),
                 ),
             ],
           ),
         ),
       ),
     );
  }
}