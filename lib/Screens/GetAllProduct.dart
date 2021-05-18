import 'package:ashmall/GlobalFunction.dart';
import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Screens/CustomText.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustRate.dart';
import 'ProductDetails.dart';

class AllProduct extends StatefulWidget{
  var id;
  var name;
  var type;
  AllProduct(var id,var name,var type){
    this.id=id;
    this.name=name;
    this.type=type;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.id,this.name,this.type);
  }
}
class _state extends State <AllProduct>{
  var id;
  var name;
  var type;
  _state(var id,var name,var type){
    this.id=id;
    this.name=name;
    this.type=type;
  }
  ProductServices productServices=new ProductServices();
  List<ProductDetail>data;
  loadData() async {
    if(type=="category")
      data=await productServices.getProductFromSubCategory("en", this.id);
    else
      data=await productServices.getProductFromBrand("en", this.id);

    setState(() {
    });
    print("ssssssssssssssssssssssssss");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  home h=new home();
  TextEditingController searchKey=new TextEditingController();
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
      // backgroundColor: Color(h.mainColor),
       body: Container(
         child: Column(
           children: [
             /*SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
               padding: EdgeInsets.only(
                   left: MediaQuery.of(context).size.width*.03,
                   right: MediaQuery.of(context).size.width*.03
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   GestureDetector(child: Icon(Icons.arrow_back),onTap: (){Navigator.pop(context);},),
                   Container(
                     width: MediaQuery.of(context).size.width*.7,
                     height: MediaQuery.of(context).size.height*.05,
                     decoration: BoxDecoration(
                       borderRadius:BorderRadius.all(Radius.circular(30)),
                       color: Colors.white,
                     ),
                     child: TextFormField(
                       enabled: false,
                       onTap: (){
                         Navigator.pushNamed(context, "/Search");
                       },
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
                   SizedBox(width: MediaQuery.of(context).size.width*.03,),
                   Icon(Icons.shopping_cart,size: 25,),
                   Icon(Icons.menu)
                 ],
               ),
             ),*/
             CustomAppBar(this.name),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
                 width: MediaQuery.of(context).size.width*.9,
                 child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 CustomText.TitleText(this.name)
               ],
             )),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             data==null?Center(child: CircularProgressIndicator(),):data.length>0?
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
                   childAspectRatio: 1/1.3
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
                     height: MediaQuery.of(context).size.height*.2,
                     width: MediaQuery.of(context).size.width*.25,
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
                         padding: EdgeInsets.only(left: 5,right: 5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                                 width: MediaQuery.of(context).size.width*.3,
                                 child: CustomText.SubTitleText(data[index].name)),
                             Icon(Icons.add_shopping_cart)
                           ],
                         ),
                       ),
                         SizedBox(height: 2,),
                         Container(
                           height: 13,
                           padding: EdgeInsets.only(left: 5,right: 5),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   CustomText.CustomText10(data[index].offerPrice.toString()),
                                   SizedBox(width: 7,),
                                   CustomText.CustomTextOffers(data[index].price.toString())

                                 ],
                               ),Container(
                                 height: 7,
                                 padding: EdgeInsets.only(
                                     left: 5,right: 5
                                 ),
                                 child: CustomRate(data[index].rate.round(),11),
                               ),
                             ],
                           )
                         ),
                         SizedBox(height: 2,),

                         SizedBox(height: 10,)
                       ],
                     ),
                   ),
                 );
               },
             )

             ):Center(child: Container(
                 height: MediaQuery.of(context).size.height*.7,
                 child: Center(child: CustomText.TitleText("No Product in $name"),)),),
           ],
         ),
       )
     ),
   );
  }
}