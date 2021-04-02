import 'package:ashmall/Model/CategoryModel.dart';
import 'package:ashmall/Model/SubCategoryModel.dart';
import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Services/CategoryServices.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalFunction.dart';
import 'GetAllProduct.dart';

class Category extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return _state();
  }
}
class _state extends State<Category>{
 String SelectedCategory;
home h=new home();
List <CategoryDetail>Category=[];
CategoryServices categoryServices=new CategoryServices();
loadData()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  Category=await categoryServices.getAllCategory(prefs.getString("lang"),prefs.getString("token"));
  getSubCat(Category[0].id);
  setState(() {
    SelectedCategory==Category[0].id;
  });
  print(Category.length);
  print("sssssssssssssssssssssssss");
}
TextEditingController searchKey=new TextEditingController();
List<SubCategoryDetail>subCategories=[];
getSubCat(String id)async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  subCategories=await categoryServices.getSubCategory(prefs.getString("lang"), id,);
  setState(() {
  });
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
       body: Category.length>0?Container(
         child: Column(
           children: [
        /*     SizedBox(height: MediaQuery.of(context).size.height*.02,),
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
             CustomAppBar(DemoLocalizations.of(context).title["category"]),
             SizedBox(height: MediaQuery.of(context).size.height*.015,),
             Expanded(
               child: Row(
                 children: [
                  SingleChildScrollView(
                    child: Container(
                    width: MediaQuery.of(context).size.width*.25,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: Category.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                getSubCat(Category[index].id);
                                setState(() {
                                  SelectedCategory=Category[index].id;
                                });
                           
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height*.065+25,
                                decoration: BoxDecoration(
                                 // borderRadius: BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(width: 1.0,color: Colors.black12.withOpacity(.1)),
                                   color: SelectedCategory==Category[index].id?Color(h.mainColor):Colors.black12.withOpacity(.01),
                                ),
                               // padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)
                                        ),
                                        child: Image.network(GlobalVariable.URl+Category[index].photo,fit: BoxFit.cover,height: MediaQuery.of(context).size.height*.065,
                                            width: MediaQuery.of(context).size.width*.25
                                        )),
                                    SizedBox(height: 5,),
                                    Text(Category[index].name,maxLines: 1,style: TextStyle(fontSize: 10,color: SelectedCategory==Category[index].id?Colors.white:Colors.black45),)
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                  Container(height: MediaQuery.of(context).size.height,color: Colors.black12,width: 1.0,),
                subCategories.length==null?
                Container(
                    width: MediaQuery.of(context).size.width*.7,
                    child: Center(child: CircularProgressIndicator(),)):subCategories.length==0?
                Container(
                    width: MediaQuery.of(context).size.width*.7,
                    child: Center(child: Text("Not Contain Sub Category",style: TextStyle(color: Colors.black45,fontSize: 12,fontWeight: FontWeight.bold),)))
                    :SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width*.745,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child:GridView.builder(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*.03,
                          right: MediaQuery.of(context).size.width*.03,
                        ),
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1/1.25
                        ),
                        itemCount: subCategories.length,
                        itemBuilder: (context,index){
                          return  GestureDetector(
                            onTap: (){
                              Navigator.push(context, GlobalFunction.route(AllProduct(subCategories[index].id,subCategories[index].name,"category")));
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
                                     child:  Image.network(GlobalVariable.URl+subCategories[index].photo,
                                     fit: BoxFit.fill,
                                     ),
                                     ),
                                   ),
                                    SizedBox(height: 3,),
                                    Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: Text(subCategories[index].name,style: TextStyle(fontSize: 10,color: Colors.black87),maxLines: 2,textAlign: TextAlign.center,)),
                                    SizedBox(height: 3,),
                                  ],
                                ),
                            ),
                          );
                        }

                        ),
                    ),
                  ),
                 ],

               ),
             )
           ],
         ),
       ):Center(child: CircularProgressIndicator(),),
     ),
   );
  }
}