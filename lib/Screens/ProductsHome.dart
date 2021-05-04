import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../GlobalFunction.dart';
import 'CustRate.dart';
import 'CustomSearchAppBar.dart';
import 'CustomText.dart';
import 'ProductDetails.dart';

class ProductsHome extends StatefulWidget{
  List <ProductDetail>data;
  String name;
  ProductsHome(List <ProductDetail>data,String name){
    this.name=name;
    this.data=data;
  }
  @override
  State<StatefulWidget> createState() {
     return _state(this.data,this.name);
  }
}
class _state extends State<ProductsHome>{
  List <ProductDetail>data;
  String name;
  _state(List <ProductDetail>data,String name){
    this.name=name;
    this.data=data;
  }
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       body: Container(
         child: Column(
           children: [
             CustomSearchAppBar(),
             Expanded(child: GridView.builder(
               padding: EdgeInsets.only(
                   left: MediaQuery.of(context).size.width*.05,
                   right: MediaQuery.of(context).size.width*.05
               ),
               primary: false,
               shrinkWrap: true,
               itemCount: data.length,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   mainAxisSpacing: 10,
                   crossAxisSpacing: 10,
                   childAspectRatio: 1/1.2
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
                         Divider(color: Colors.black45,thickness: 1,),
                         SizedBox(height: 2,),
                         Container(
                           padding: EdgeInsets.only(left: 7,right: 7),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                   width: MediaQuery.of(context).size.width*.3,
                                   child: CustomText.SubTitleText(data[index].name)),

                             ],
                           ),
                         ),
                         SizedBox(height: 2,),
                         Container(
                           padding: EdgeInsets.only(left: 7,right: 7),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(

                                   width: MediaQuery.of(context).size.width*.39,
                                   // padding: EdgeInsets.only(left: 5,right: 5),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               CustomText.CustomText10(data[index].offerPrice.toString()),
                                               SizedBox(width: 7,),
                                               Container(
                                                 height: 7,
                                                 padding: EdgeInsets.only(
                                                   //left: 5,right: 5
                                                 ),
                                                 child: CustomRate(data[index].rate,12),
                                               ),
                                             ],
                                           ),
                                           Icon(Icons.add_shopping_cart)
                                           /* SizedBox(width: 7,),
                                                CustomText.CustomTextOffers(LastList[index].price.toString())*/

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
             ),
             )
           ],
         ),
       ),   ),
   );
  }
}