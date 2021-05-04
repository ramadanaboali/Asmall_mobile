import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ashmall/Model/ProductRateModel.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustRate.dart';
import 'CustomSearchAppBar.dart';


class Reviews extends StatefulWidget{
  String id;
  var name;
  Reviews(String id,var name){
    this.id=id;
    this.name=name;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.id,this.name);
  }
}
class _state extends State<Reviews>{
  String id;
  var name;
  _state(String id,var name){
    this.id=id;
    this.name=name;
  }
  home h=new home();
  TextEditingController searchKey=new TextEditingController();
  ProductServices productServices=new ProductServices();
  List<ProductRateDetail>rate;
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    rate=await productServices.getProductRate(prefs.getString("lang"), this.id);
    setState(() {
    });
    print(rate.length);
    // print(data);
    print("wwwwwwwwwwwwwwwwwww");
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
       body: Container(
         child: Column(
           children: [
           /*  SizedBox(height: MediaQuery.of(context).size.height*.02,),
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
             CustomSearchAppBar(),
             rate==null?Expanded(child: Center(child: CircularProgressIndicator())):rate.length==0?
             Expanded(
               child: Center(
                 child: Column(
                   children: [
                     SizedBox(height: MediaQuery.of(context).size.height*.2,),
                     Image.asset("images/logo.png",
                       height: MediaQuery.of(context).size.height*.2,
                     ),
                     SizedBox(height: 15,),
                     Text(DemoLocalizations.of(context).title["noReviews"])
                   ],
                 ),
               ),
             ):
             Expanded(
               child: ListView.builder(
                   padding: EdgeInsets.only(
                     left: MediaQuery.of(context).size.width*.05,
                     right: MediaQuery.of(context).size.width*.05,
                   ),
                   itemCount: rate.length,itemBuilder: (context,index){
                 return Container(
                   width: MediaQuery.of(context).size.width*.9,
                   margin: EdgeInsets.only(bottom:index==rate.length-1?MediaQuery.of(context).size.height*.05:MediaQuery.of(context).size.height*.01,),
                   padding: EdgeInsets.only(
                       top: MediaQuery.of(context).size.height*.015,
                       bottom: MediaQuery.of(context).size.height*.015,
                       left:12,
                       right: 12
                   ),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                       border: Border.all(color: Colors.black12,width: 1),
                       color: Colors.black12.withOpacity(.05)
                   ),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               CircleAvatar(
                                 minRadius: 13,
                                 maxRadius: 14,
                                 child: ClipRRect(
                                     borderRadius: BorderRadius.all(Radius.circular(1000)),
                                     child: rate[index].userPhoto==null?Icon(Icons.person,):Image.network(GlobalVariable.URl+rate[index].userPhoto,fit: BoxFit.fill,)),
                               ),
                               SizedBox(width: 5,),
                               Container(
                                   width: MediaQuery.of(context).size.width*.55,
                                   child: Text(rate[index].userName,maxLines: 1,))
                             ],
                           ),
                           CustomRate(rate[index].rateNum,12)
                         ],
                       ),
                       SizedBox(height: 8,),
                       Row(
                         children: [
                           Container(
                             width:rate[index].photo==null? MediaQuery.of(context).size.width*.6:MediaQuery.of(context).size.width*.8,
                             child: Text(rate[index].comment,
                               maxLines: 3,textAlign: TextAlign.start,style: TextStyle(fontSize: 12),),
                           ),
                           rate[index].photo==null? Image.network(GlobalVariable.URL2+rate[index].photo,
                           width: MediaQuery.of(context).size.width*.22,
                           ):SizedBox()
                         ],
                       ),
                       SizedBox(height: 8,),
                     ],
                   ),
                 );
               }),
             )
           ],
         ),
       ),
     ),
   );
  }
}