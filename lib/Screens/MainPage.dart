import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Screens/AllBrand.dart';
import 'package:ashmall/Screens/Category.dart';
import 'package:ashmall/Screens/CustRate.dart';
import 'package:ashmall/Screens/CustomText.dart';
import 'package:ashmall/Screens/Favourite.dart';
import 'package:ashmall/Screens/ProductDetails.dart';
import 'package:ashmall/Screens/ProductsHome.dart';
import 'package:ashmall/Screens/SubCategory.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalFunction.dart';
import 'LangSetting.dart';
import 'Orders.dart';
class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<MainPage>{
  TextEditingController searchKey=new TextEditingController();
  home h=new home();
  List <ProductDetail>BestList=[];
  List <ProductDetail>OffersList=[];
  List <ProductDetail>LastList=[];
  ProductServices productServices=new ProductServices();
  var user_id;
  loadData()async{
    SharedPreferences  Prefs=await SharedPreferences.getInstance();
    BestList=await productServices.getBestSeller(Prefs.getString("lang"), Prefs.getString("token"));
    OffersList=await productServices.getOffers(Prefs.getString("lang"), Prefs.getString("token"));
    LastList=await productServices.getlastAdd(Prefs.getString("lang"), Prefs.getString("token"));
    setState(() {
      user_id=Prefs.getString("id");
    });
    print(user_id+"userrrrrrrrrrrrrrrrrrrrrr");
    print(BestList.length);
    print(OffersList.length);
    print(LastList.length);
    print("ssssssssssssssssssssss");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          color: Color(0xffff7db4).withOpacity(.02),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.05,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/Search");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.9,
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
                        hintText:DemoLocalizations.of(context).title['Search'],
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
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Container(
                  height: MediaQuery.of(context).size.height*.13,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.04
                    ),
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(Category()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.2,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Color(h.redColor)
                                ),
                                child: Icon(Icons.menu,color: Colors.white,size: 35,),
                              ),
                              SizedBox(height: 8,),
                              Text( DemoLocalizations.of(context).title["category"],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                     SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(SubCategory()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.2,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Color(h.redColor)
                                ),
                                child: Icon(Icons.subject_rounded,color: Colors.white,size: 35,),
                              ),
                              SizedBox(height: 8,),
                              Text(DemoLocalizations.of(context).title["subcategory"],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(Bran()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.2,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Color(h.redColor)
                                ),
                                child: Icon(Icons.branding_watermark,color: Colors.white,size: 35,),
                              ),
                              SizedBox(height: 8,),
                              Text(DemoLocalizations.of(context).title["brand"],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(Favourite()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.2,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Color(h.redColor)
                                ),
                                child: Icon(Icons.favorite,color: Colors.white,size: 35,),
                              ),
                              SizedBox(height: 8,),
                              Text( DemoLocalizations.of(context).title["wishlist"],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ),


                      SizedBox(width: 10,),
                    user_id!=null? Row(
                       children: [
                         GestureDetector(
                           onTap: (){
                             Navigator.push(context, GlobalFunction.route(Orders()));
                           },
                           child: Container(
                             width: MediaQuery.of(context).size.width*.2,
                             child: Column(
                               children: [
                                 Container(
                                   padding: EdgeInsets.all(7),
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.all(Radius.circular(20)),
                                       color: Color(h.redColor)
                                   ),
                                   child: Icon(Icons.border_left_outlined,color: Colors.white,size: 35,),
                                 ),
                                 SizedBox(height: 8,),
                                 Text(DemoLocalizations.of(context).title["orders"],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                               ],
                             ),
                           ),
                         ),
                         SizedBox(width: 10,),
                       ],
                     ):SizedBox(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(LangSetting()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.2,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Color(h.redColor)
                                ),
                                child: Icon(Icons.settings,color: Colors.white,size: 35,),
                              ),
                              SizedBox(height: 8,),
                              Text(DemoLocalizations.of(context).title["setting"],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(ProductsHome(BestList,DemoLocalizations.of(context).title["bestSeller"])));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.94,
                    height: MediaQuery.of(context).size.height*.055,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(h.redColor)
                    ),
                    child: Row(
                      children: [
                        Text(DemoLocalizations.of(context).title["bestSeller"],style: TextStyle(color: Colors.white),),
                      ],
                    )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                BestList.length==0?
                Container(
                  height: MediaQuery.of(context).size.height*.2,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator(),),
                ):
                Container(
                  height: MediaQuery.of(context).size.height*.21,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: BestList.length,
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.03),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(ProductDetails(BestList[index].id,BestList[index].name)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: 15
                          ),
                          height: MediaQuery.of(context).size.height*.21,
                          width: MediaQuery.of(context).size.width*.3,
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
                                    child: Image.network(GlobalVariable.URl+BestList[index].coverPhoto,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Container(color: Colors.black45,height: 1,width: MediaQuery.of(context).size.width,),
                              SizedBox(height:MediaQuery.of(context).size.height*.007,),
                              Container(
                                padding: EdgeInsets.only(left: 5,right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width*.25,
                                        child: CustomText.SubTitleText(BestList[index].name)),

                                  ],
                                ),
                              ),
                              SizedBox(height: 2,),
                              Container(
                                  padding: EdgeInsets.only(left: 5,right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CustomText.CustomText10(BestList[index].offerPrice.toString()),
                                             /* SizedBox(width: 7,),
                                              CustomText.CustomTextOffers(BestList[index].price.toString())*/

                                            ],
                                          ),Container(

                                            padding: EdgeInsets.only(
                                              // left: 5,right: 5
                                            ),
                                            child: CustomRate(BestList[index].rate,11),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.add_shopping_cart)
                                    ],
                                  )
                              ),

                              SizedBox(height:MediaQuery.of(context).size.height*.01,)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(ProductsHome(OffersList,DemoLocalizations.of(context).title["offers"])));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.94,
                    height: MediaQuery.of(context).size.height*.055,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(h.redColor)
                    ),
                    child:Row(
                      children: [
                        Text(DemoLocalizations.of(context).title["offers"],style: TextStyle(color: Colors.white),),
                      ],
                    )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                OffersList.length==0?
                Container(
                  height: MediaQuery.of(context).size.height*.22,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator(),),
                ):
                Container(
                    height: MediaQuery.of(context).size.height*.21,
                    width: MediaQuery.of(context).size.width,
                    child:ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: OffersList.length,
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.03),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            print("sssssssss");
                            Navigator.push(context, GlobalFunction.route(ProductDetails(OffersList[index].id,OffersList[index].name)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 15
                            ),
                            height: MediaQuery.of(context).size.height*.21,
                            width: MediaQuery.of(context).size.width*.3,
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
                                      child: Image.network(GlobalVariable.URl+LastList[index].coverPhoto,
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(color: Colors.black45,height: 1,width: MediaQuery.of(context).size.width,),
                                SizedBox(height:MediaQuery.of(context).size.height*.007,),
                                Container(
                                  padding: EdgeInsets.only(left: 5,right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width*.25,
                                          child: CustomText.SubTitleText(OffersList[index].name)),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 2,),
                                Container(

                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                CustomText.CustomText10(OffersList[index].offerPrice.toString()),
                                                SizedBox(width: 7,),
                                                CustomText.CustomTextOffers(OffersList[index].price.toString())

                                              ],
                                            ),Container(
                                              padding: EdgeInsets.only(
                                                 // left: 5,right: 5
                                              ),
                                              child: CustomRate(OffersList[index].rate,11),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.add_shopping_cart)
                                      ],
                                    )
                                ),
                                SizedBox(height:MediaQuery.of(context).size.height*.01,)
                              ],
                            ),
                          ),
                        );
                      },
                    )
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(ProductsHome(LastList,DemoLocalizations.of(context).title["lastAdded"])));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.94,
                    height: MediaQuery.of(context).size.height*.055,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(h.redColor)
                    ),
                    child: Row(
                      children: [
                        Text(DemoLocalizations.of(context).title["lastAdded"],style: TextStyle(color: Colors.white),),
                      ],
                    )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
               LastList.length==0?  Container(
                 height: MediaQuery.of(context).size.height*.22,
                 width: MediaQuery.of(context).size.width,
                 child: Center(child: CircularProgressIndicator(),),
               ): Container(
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.05,
                        right: MediaQuery.of(context).size.width*.05
                    ),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: LastList.length,
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
                          Navigator.push(context, GlobalFunction.route(ProductDetails(LastList[index].id,LastList[index].name)));
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
                                    child: Image.network(GlobalVariable.URl+LastList[index].coverPhoto,
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
                                        child: CustomText.SubTitleText(LastList[index].name)),

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
                                                CustomText.CustomText10(LastList[index].offerPrice.toString()),
                                                SizedBox(width: 7,),
                                                Container(
                                                  height: 7,
                                                  padding: EdgeInsets.only(
                                                    //left: 5,right: 5
                                                  ),
                                                  child: CustomRate(LastList[index].rate,12),
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

          ),

        ),
    );
  }
}