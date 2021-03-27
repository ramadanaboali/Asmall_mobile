import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CustomRate extends StatefulWidget{
  int rate;
  double size;
  CustomRate(int rate,double size){
    this.rate=rate;
    this.size=size;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.rate,this.size);
  }
}
class _state extends State<CustomRate>{
  int rate;
  double size;
  int freestar;
  _state(int rate,double size){
    this.rate=rate;
    freestar=5-rate;
    this.size=size;
  }
  @override
  Widget build(BuildContext context) {
    home h=new home();
    return Container(
      height: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 10,
            child: ListView.builder(
                primary: false,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: rate,
                itemBuilder:(context,index){
                  return Icon(Icons.star,size: this.size,color: Color(h.mainColor),);
                }
            ),
          ),
          Container(
            height: 10,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemCount: freestar,
                itemBuilder:(context,index){
                  return Icon(Icons.star_border,size: this.size,color: Color(h.redColor),);
                }
            ),
          )
        ],
      ),
    );
  }
}