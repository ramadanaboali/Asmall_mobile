import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Model/SearchModel.dart';
import 'package:ashmall/Screens/GetAllProduct.dart';
import 'package:ashmall/Screens/ProductDetails.dart';
import 'package:ashmall/Screens/SearchSubCategory.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../GlobalFunction.dart';
class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Search>{
  TextEditingController searchKey=new TextEditingController();
  home h=new home();
  List<SearchItem>data2=[];
  String Empty="Enter Key Search";
  ProductServices productServices=new ProductServices();
  List<String>data=["sharaf","elrayn","keySerarch"];
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       resizeToAvoidBottomInset: false,
       body:  Container(
             padding: EdgeInsets.only(
               left: MediaQuery.of(context).size.width*.03,
               right: MediaQuery.of(context).size.width*.03
             ),
             child: Column(
               children: [
                 SizedBox(height: MediaQuery.of(context).size.height*.02,),
                 Container(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       GestureDetector(child: Icon(Icons.arrow_back),onTap: (){Navigator.pop(context);},),
                       Container(
                         width: MediaQuery.of(context).size.width*.85,
                         height: MediaQuery.of(context).size.height*.05,
                         decoration: BoxDecoration(
                           borderRadius:BorderRadius.all(Radius.circular(30)),
                           color: Colors.white,
                         ),
                         child: TextFormField(
                           autofocus: true,
                           onChanged: (val)async{
                          if(val.isNotEmpty){
                            data2=await productServices.Search("en", val);
                            setState(() {
                                  Empty="No Data Available With This Key Search";
                            });
                            print(data2.length);
                            print("ssssssssssssssss");
                          }
                          else{
                            setState(() {
                              data2=[];
                              Empty="Enter Key Search";
                            });
                          }
                           },
                           keyboardType: TextInputType.text,
                           //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
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
                             hintText:'Search' ,
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
                       )
                     ],
                   ),
                 ),
                 SizedBox(height: MediaQuery.of(context).size.height*.015,),
           /*      Container(
                   width: MediaQuery.of(context).size.width,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Serach History",style: TextStyle(fontSize:13,fontWeight: FontWeight.bold),),
                       Icon(Icons.delete,color: Colors.black38,)
                     ],
                   ),
                 ),
                 SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context,index){
                    return Container(
                      height: 20,
                      padding: EdgeInsets.only(left: 7,right: 7),
                      margin: EdgeInsets.only(left: 3,right: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.black26
                      ),
                      child: Text(data[index],style: TextStyle(fontSize: 12),),
                    );
                      }
                  ),
                ),
                 SizedBox(height: MediaQuery.of(context).size.height*.015,),
                 Container(
                   width: MediaQuery.of(context).size.width,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Discover More",style: TextStyle(fontSize:13,fontWeight: FontWeight.bold),),
                       Icon(Icons.autorenew_rounded,color: Colors.black38,)
                     ],
                   ),
                 ),
                 SizedBox(height: MediaQuery.of(context).size.height*.01,),
                 Container(
                   height: 20,
                   alignment: Alignment.centerLeft,
                   child: ListView.builder(
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       primary: false,
                       itemCount: data.length,
                       itemBuilder: (context,index){
                         return Container(
                           height: 20,
                           padding: EdgeInsets.only(left: 7,right: 7),
                           margin: EdgeInsets.only(left: 3,right: 3),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(30)),
                               color: Colors.black26
                           ),
                           child: Text(data[index]),
                         );
                       }
                   ),
                 ),*/
         data2.length==null?
         Expanded(
           child: Container(
               width: MediaQuery.of(context).size.width*.7,
               child: Center(child: CircularProgressIndicator(),)),
         ):data2.length==0?
         Container(
             width: MediaQuery.of(context).size.width*.7,
             height: MediaQuery.of(context).size.height*.4,
             child: Center(child: Text(Empty,textAlign: TextAlign.center,style: TextStyle(color: Colors.black45,fontSize: 14,fontWeight: FontWeight.bold),)))
             :Expanded(child: SingleChildScrollView(
           child: Container(
             padding: EdgeInsets.only(
                 left: MediaQuery.of(context).size.width*.05,
                 right: MediaQuery.of(context).size.width*.05,
                 top: MediaQuery.of(context).size.height*.02,
                 bottom: 80
             ),
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
             color: Colors.white,
             child:GridView.builder(
                 padding: EdgeInsets.only(
                 ),
                 primary: false,
                 shrinkWrap: true,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 3,
                     mainAxisSpacing: 5,
                     crossAxisSpacing: 5,
                     childAspectRatio: 1/1.25
                 ),
                 itemCount: data2.length,
                 itemBuilder: (context,index){
                   return  GestureDetector(
                     onTap: (){
                       if(data2[index].type==1)
                         Navigator.push(context, GlobalFunction.route(SearchSubCategory(data2[index].id)));
                     else if( data2[index].type==2)
                      Navigator.push(context, GlobalFunction.route(AllProduct(data2[index].id,data2[index].name,"category")));
                    else if(data2[index].type==3)
                        Navigator.push(context, GlobalFunction.route(AllProduct(data2[index].id,data2[index].name,"category")));
                    else
                        Navigator.push(context, GlobalFunction.route(ProductDetails(data2[index].id,data2[index].name)));
                     },
                     child: Container(
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(5)),
                           border: Border.all(color: Colors.black12,width: 1)
                       ),
                       // padding: EdgeInsets.all(10),
                       child: Column(
                         children: [
                           Expanded(
                             child: ClipRRect(
                               child:  Image.network(GlobalVariable.URl+data2[index].photo,
                                 fit: BoxFit.fill,
                               ),
                             ),
                           ),
                           SizedBox(height: 3,),
                           Container(
                               height: 30,
                               alignment: Alignment.center,
                               child: Text(data2[index].name,style: TextStyle(fontSize: 10,color: Colors.black87),maxLines: 2,textAlign: TextAlign.center,)),
                           SizedBox(height: 3,),
                         ],
                       ),
                     ),
                   );
                 }

             ),
           ),

         ))]
             ),
           ),
         ),


   );
  }
}

