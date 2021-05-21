import 'package:ashmall/GlobalFunction.dart';
import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Screens/CustRate.dart';
import 'package:ashmall/Screens/CustomSearchAppBar.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'CustomText.dart';
import 'ProductDetails.dart';

class Store extends StatefulWidget{
  var id;
  Store(var id){
    this.id=id;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.id);
  }
}
class _state extends State<Store>{
  var id;
  _state(var id){
    this.id=id;
  }
  home h=new home();
  List <ProductDetail>data;
  Map<String,dynamic>responce;
ProductServices productServices=new ProductServices();
Map<String,dynamic>followerStatus;
bool disableFollow=true;
var user_id;
loadData()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  responce=await productServices.getvendorData(prefs.getString("lang"), id);
  data=await productServices.getVendorProduct(prefs.getString("lang"), id);
 if(prefs.getString("id")!=null){
   followerStatus=await productServices.getFollowStatus(prefs.getString("lang"), prefs.getString("token"), id, prefs.getString("id"));
 }
  setState(() {
    disableFollow=true;
    user_id=prefs.getString("id");
  });
  print(data.length);
  print("*************************");
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       body: responce==null?Center(child: CircularProgressIndicator()):Container(
         height: MediaQuery.of(context).size.height,
         child: Column(
           children: [
             CustomSearchAppBar(),
             Container(
               padding: EdgeInsets.only(
                 left: MediaQuery.of(context).size.width*.05,
                 right: MediaQuery.of(context).size.width*.05,
               ),
               child: Row(
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     child: Image.network(GlobalVariable.URl+responce["data"]["photo"],
                     height: MediaQuery.of(context).size.width*.2,
                     width: MediaQuery.of(context).size.width*.2,
                       fit: BoxFit.fill,
                     ),
                   ),
                   SizedBox(width: 10,),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                     Container(
                       width: MediaQuery.of(context).size.width*.7-10,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(responce["data"]["name"],style: TextStyle(fontSize: 13,height: 1.3),),
                           user_id!=null? GestureDetector(
                             onTap: ()async{
                               setState(() {
                                 disableFollow=false;
                               });
                                  SharedPreferences pref=await SharedPreferences.getInstance();
                                  if(followerStatus["data"]==true){
                                    productServices.deleteFollower(pref.getString("lang"), pref.getString("token"), id, pref.getString("id"));
                                    loadData();
                                  }
                                  else{
                                    productServices.addFollowers(pref.getString("lang"), pref.getString("token"), id, pref.getString("id"));
                                    loadData();
                                  }

                             },
                             child: Container(
                               width: MediaQuery.of(context).size.width*.2,
                               height: MediaQuery.of(context).size.height*.03,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.all(Radius.circular(5)),
                                   color: disableFollow==false?Colors.black38:Color(h.mainColor)
                               ),
                               alignment: Alignment.center,
                               child: Text(followerStatus["data"]==true?"Un Follow":"Follow",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
                             ),
                           ):SizedBox(),
                         ],
                       ),
                     ),
                       Container(
                         width: MediaQuery.of(context).size.width*.7-10,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                                 width: MediaQuery.of(context).size.width*.44,
                                 child: Text(responce["data"]["email"],maxLines: 1,style: TextStyle(fontSize: 10,height: 1.3),)),
                             Text("Followers : ${responce["data"]["numbersOfFollowers"]}",style: TextStyle(fontSize: 12,height: 1.5),),
                           ],
                         ),
                       ),
                       Container(
                         width: MediaQuery.of(context).size.width*.7-10,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                              width: MediaQuery.of(context).size.width*.4  ,
                                 child: Text(responce["data"]["phone"],style: TextStyle(fontSize: 10,height: 1.3),)),
                             CustomRate(int.parse(responce["data"]["rate"].toString()), 15),
                           ],
                         ),
                       ),
                     ],
                   )
                 ],
               ),
             ),
             SizedBox(height: 8,),
             Container(
            height:1,
            width: MediaQuery.of(context).size.width,
            color: Colors.black38,
          ),
            /* SizedBox(height: 8,),
             Container(
                 width: MediaQuery.of(context).size.width*.94,
                 height: MediaQuery.of(context).size.height*.04,
                 alignment: Alignment.centerLeft,
                 padding: EdgeInsets.only(left: 0,right: 0),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(10)),
                   //color: Color(h.redColor)
                 ),
                 child: Row(
                   children: [
                     Text(DemoLocalizations.of(context).title["lastAdded"],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                   ],
                 )
             ),*/
             SizedBox(height: 10,),
              data==null?Expanded(child:Center(child: CircularProgressIndicator()),):
              Expanded(child: GridView.builder(
           padding: EdgeInsets.only(
               left: MediaQuery.of(context).size.width*.05,
               right: MediaQuery.of(context).size.width*.05
           ),
           primary: false,
           shrinkWrap: true,
           itemCount: data.length,
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 3,
               mainAxisSpacing: 10,
               crossAxisSpacing: 10,
               childAspectRatio: 1/1.4
           ),
           itemBuilder: (context,index){
             return GestureDetector(
               onTap: (){
                 print("sssssssss");
                 Navigator.push(context, GlobalFunction.route(ProductDetails(data[index].id,data[index].name)));
               },
               child: Container(
                 margin: EdgeInsets.only(
                 ),

                 decoration: BoxDecoration(
                     border: Border.all(color: Colors.black12,width: 1),
                     borderRadius: BorderRadius.all(Radius.circular(5))
                 ),

                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Expanded(

                       child: Container(
                         child: ClipRRect(
                           borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(5),
                               topRight: Radius.circular(5)
                           ),
                           child: Image.network(GlobalVariable.URl+data[index].coverPhoto,
                             width: MediaQuery.of(context).size.width,
                             fit: BoxFit.fill,
                           ),
                         ),
                       ),
                     ),
                     SizedBox(height: 3,),
                     Container(
                       padding: EdgeInsets.only(left: 5,right: 5),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                       width: MediaQuery.of(context).size.width*.18,
                                       child:Text(data[index].name,maxLines: 1,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),

                                   Icon(Icons.add_shopping_cart,size: 18,)
                                 ],
                               )
                           ),

                         ],
                       ),
                     ),
                     SizedBox(height: 2,),
                     Container(
                       padding: EdgeInsets.only(left: 3,right: 3),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(

                               // padding: EdgeInsets.only(left: 5,right: 5),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       CustomText.CustomText10(data[index].offerPrice.toString()),
                                       SizedBox(width: 7,),
                                       Container(
                                         height: 7,
                                         padding: EdgeInsets.only(
                                           //left: 5,right: 5
                                         ),
                                         child: CustomRate(data[index].rate.round(),10),
                                       ),
                                     ],
                                   ),
                                 ],
                               )
                           ),

                         ],
                       ),
                     ),
                     SizedBox(height: 2,),

                     SizedBox(height: 10,)
                   ],
                 ),
               ),
             );
           },
         ),)

           ],
         ),
       )
     ),
   );
  }
}