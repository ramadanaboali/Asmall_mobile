import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../GlobalFunction.dart';
import '../HomePage.dart';
import '../main.dart';
import 'LangSetting.dart';

class CustomSearchAppBar extends StatelessWidget{
  home h=new home();
  TextEditingController searchKey=new TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Container(
     child: Column(
       children: [
         SizedBox(height: MediaQuery.of(context).size.height*.01,),
         Container(
           padding: EdgeInsets.only(
               left: MediaQuery.of(context).size.width*.03,
               right: MediaQuery.of(context).size.width*.03
           ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               GestureDetector(child: Icon(Icons.arrow_back),onTap: (){Navigator.pop(context);},),
               GestureDetector(
                   onTap: (){
                     Navigator.pushNamed(context, "/Search");
                   },
                 child: Container(
                   width: MediaQuery.of(context).size.width*.65,
                   height: MediaQuery.of(context).size.height*.05,
                   decoration: BoxDecoration(
                     borderRadius:BorderRadius.all(Radius.circular(30)),
                     color: Colors.white,
                   ),
                   child: TextFormField(
                     enabled: false,
                     keyboardType: TextInputType.text,
                     //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                     decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                       disabledBorder: new OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: BorderSide(color: Color(h.mainColor))
                       ),
                       enabledBorder: new OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: BorderSide(color: Color(h.mainColor))
                       ),
                       focusedBorder:  new OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: BorderSide(color: Color(h.mainColor))
                       ),
                       focusedErrorBorder:new OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: BorderSide(color: Colors.red)
                       ),
                       errorBorder:new OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: BorderSide(color: Colors.red)
                       ),
                       hintText:'Search',
                       hintStyle: TextStyle(fontSize: 12,color: Colors.black38),
                       suffixIcon:Container(
                           margin: EdgeInsets.all(5),
                           alignment: Alignment.center,
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(20)),
                               color: Color(h.redColor)
                           ),
                           child: Icon(Icons.search,color: Colors.white,size: 20,)),
                       suffixIconConstraints: BoxConstraints(
                           maxHeight: 50,
                           minHeight: 30,
                           maxWidth: 70,
                           minWidth: 50
                       ) ,
                     ),
                     controller: searchKey,
                   ),
                 ),
               ),
               SizedBox(width: MediaQuery.of(context).size.width*.0,),
               GestureDetector(
                 onTap: (){
                   Navigator.push(context, GlobalFunction.routeBottom(HomePage(2)));
                 },
                 child: Stack(
                   children: [
                     Container(
                         padding: EdgeInsets.only(left: 4,right: 4,top: 7,bottom: 7),
                         child: Icon(Icons.shopping_cart,size: 25,)),
                     Positioned(
                       left: 17,
                       child: CircleAvatar(
                         radius: 7.8,
                         foregroundColor: Color(h.mainColor),
                         backgroundColor: Color(h.mainColor),
                         child: Text(ParentPage.counter.toString(),style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                       ),
                     )
                   ],
                 ),
               ),
               GestureDetector(
                 onTap: (){
                   menu(context);
                 },
                 child: Container(
                   padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                   child: Column(
                     children: [
                       Container(
                         height: 5,width: 5,
                         decoration: BoxDecoration(
                             borderRadius:BorderRadius.all(Radius.circular(100)),
                             color: Colors.black
                         ),
                       ),
                       SizedBox(height: 1,),
                       Container(
                         height: 5,width: 5,
                         decoration: BoxDecoration(
                             borderRadius:BorderRadius.all(Radius.circular(100)),
                             color: Colors.black
                         ),
                       ),
                       SizedBox(height: 1,),
                       Container(
                         height: 5,width: 5,
                         decoration: BoxDecoration(
                             borderRadius:BorderRadius.all(Radius.circular(100)),
                             color: Colors.black
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               SizedBox(width: 2,)

             ],
           ),
         ),
         //CustomAppBar(DemoLocalizations.of(context).title["category"]),
         SizedBox(height: MediaQuery.of(context).size.height*.015,),
       ],
     ),
   );
  }
 static void menu(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>StatefulBuilder(
          builder: (BuildContext context, StateSetter setState)=> Scaffold(
            backgroundColor: Colors.transparent,
            body:  GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    // top: MediaQuery.of(context).size.height*.4
                  ),
                  color: Colors.transparent,
                  child: Container(
                    height: MediaQuery.of(context).size.height*.1,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*.075,
                        bottom: MediaQuery.of(context).size.height*.69,
                    ),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          width:MediaQuery.of(context).size.width*.68,
                          height: MediaQuery.of(context).size.height*.3,
                          color: Colors.transparent,
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                            left: 10,right: 10
                          ),
                          child: Column(
                            children:[
                              SizedBox(height:  MediaQuery.of(context).size.height*.01,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(DemoLocalizations.of(context).title["home"])),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, GlobalFunction.route(HomePage(3)));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(DemoLocalizations.of(context).title["account"])),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, GlobalFunction.route(LangSetting()));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(DemoLocalizations.of(context).title["setting"])),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          width: 25,
                          height: MediaQuery.of(context).size.height*.3,
                          color: Colors.transparent,
                        ),
                      ],
                    )
                  ),


                ),
              ),
          ),
        ));
  }
}