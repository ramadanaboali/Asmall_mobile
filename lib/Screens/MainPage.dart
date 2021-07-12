import 'dart:async';

import 'package:ashmall/Model/BanarModel.dart';
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
import 'package:flutter_swiper/flutter_swiper.dart';
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
  bool adv=false;
  Map<String,dynamic>setting;
  List<BanarDetail>advList=[];
  loadData()async{
    SharedPreferences  Prefs=await SharedPreferences.getInstance();
    BestList=await productServices.getBestSeller(Prefs.getString("lang"), Prefs.getString("token"));
    OffersList=await productServices.getOffers(Prefs.getString("lang"), Prefs.getString("token"));
    LastList=await productServices.getlastAdd(Prefs.getString("lang"), Prefs.getString("token"));
    advList=await productServices.getBanar(Prefs.getString("lang"));
    setting=await productServices.getSetting(Prefs.getString("lang"));
    Prefs.setString("usage", setting["data"]["usingPolicy"]);
    Prefs.setString("privacy", setting["data"]["privacyPolicy"]);
    setting["data"]["dashboardLinkEnable"]==true?Prefs.setString("dashboardLink", setting["data"]["dashboardLink"]):print("sharrrrrrrrrrrf");
    setState(() {
      user_id=Prefs.getString("id");
    });
    if(advList.length>0){
      setState(() {
        adv=true;
      });
    }
  }
  endload(){
    Timer(Duration(seconds: 1), (){
      setState(() {
      });
      print("11111111111111111111111111111111111111111111");
    });
    Timer(Duration(seconds: 2), (){
      setState(() {
      });
      print("2222222222222222222222222222222222222222222222");
    });
    Timer(Duration(seconds: 3), (){
      loadData();
      setState(() {
      });
      print("333333333333333333333333333333333333333333333333333");
    });
    Timer(Duration(seconds: 4), (){
      loadData();
      setState(() {
      });
      print("4444444444444444444444444444444444444444444444444444");
    });
    Timer(Duration(seconds: 5), (){
      loadData();
      setState(() {
      });
      print("55555555555555555555555555555555555555555555555555555555555");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    endload();
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
                SizedBox(height: MediaQuery.of(context).size.height*.008,),
                Row(
                  children: [
                    SizedBox(  width: MediaQuery.of(context).size.width*.05,),
                    Container(
                      height: MediaQuery.of(context).size.height*.13,
                      width: MediaQuery.of(context).size.width*.95,
                      child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.only(
                        ),
                        scrollDirection: Axis.horizontal,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, GlobalFunction.route(Category()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*.15,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(200)),
                                        color: Color(h.redColor)
                                    ),
                                    child: Icon(Icons.menu,color: Colors.white,size: 30,),
                                  ),
                                  SizedBox(height: 7,),
                                  Text( DemoLocalizations.of(context).title["category"],style: TextStyle(height: 1.4,fontSize: 10,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, GlobalFunction.route(SubCategory()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*.15,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(200)),
                                        color: Colors.teal
                                    ),
                                    child: Icon(Icons.subject_rounded,color: Colors.white,size: 30,),
                                  ),
                                  SizedBox(height: 6,),
                                  Container(
                                      width: MediaQuery.of(context).size.width*.17,
                                      child: Text(DemoLocalizations.of(context).title["subcategory"],style: TextStyle(height: 1.4,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, GlobalFunction.route(Bran()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*.15,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(200)),
                                        color: Colors.green
                                    ),
                                    child: Icon(Icons.branding_watermark,color: Colors.white,size: 30,),
                                  ),
                                  SizedBox(height: 6,),
                                  Text(DemoLocalizations.of(context).title["brand"],style: TextStyle(height: 1.4,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                          ),
                          /* SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(Favourite()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.17,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(200)),
                                    color: Colors.yellow
                                ),
                                child: Icon(Icons.favorite,color: Colors.white,size: 32,),
                              ),
                              SizedBox(height: 6,),
                              Text( DemoLocalizations.of(context).title["wishlist"],style: TextStyle(height: 1.4,fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ),*/


                          SizedBox(width: 5,),
                          user_id!=null? Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, GlobalFunction.route(Orders()));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.15,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(200)),
                                            color: Colors.green
                                        ),
                                        child: Icon(Icons.border_left_outlined,color: Colors.white,size: 30,),
                                      ),
                                      SizedBox(height: 6,),
                                      Text(DemoLocalizations.of(context).title["orders"],style: TextStyle(height: 1.4,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                            ],
                          ):SizedBox(),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, GlobalFunction.route(LangSetting()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*.15,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(200)),
                                        color: Colors.blue
                                    ),
                                    child: Icon(Icons.settings,color: Colors.white,size: 30,),
                                  ),
                                  SizedBox(height: 6,),
                                  Text(DemoLocalizations.of(context).title["setting"],style: TextStyle(height: 1.4,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                adv?Container(
                  height: MediaQuery.of(context).size.height*.18,
                  width: MediaQuery.of(context).size.width*.9 ,
                  color: Colors.white,
                  child:  new Swiper(
                    itemBuilder: (BuildContext context,int index){
                      return Container(
                            height: MediaQuery.of(context).size.height*.13,
                            width: MediaQuery.of(context).size.width*.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.black12,width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image.network(GlobalVariable.URl+advList[index].photo,fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height*.13,
                                width: MediaQuery.of(context).size.width*.9,
                              ),
                            ),
                          );
                       /*   Positioned(
                              left: MediaQuery.of(context).size.width*.81,
                              top:5,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    adv=false;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    color: Color(h.mainColor)
                                  ),
                                  child: Icon(Icons.clear,color: Colors.white,size: 20,),
                                ),
                              ))*/

                    },
                    autoplay: true,
                    itemCount: advList.length,
                    pagination: new SwiperPagination(
                      margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*.27),
                      builder: new DotSwiperPaginationBuilder(
                        color: Colors.grey, activeColor: Color(h.mainColor),
                      ),

                    ),
                    control: new SwiperControl(
                        color: Colors.white,
                        size: 0
                    ),
                  ),
                ):SizedBox(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(ProductsHome(BestList,DemoLocalizations.of(context).title["bestSeller"])));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.94,
                    height: MediaQuery.of(context).size.height*.05,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 0,right: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        //color: Color(h.redColor)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(DemoLocalizations.of(context).title["bestSeller"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                      ],
                    )
                  ),
                ),
                BestList.length==0?
                Container(
                  height: MediaQuery.of(context).size.height*.17,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator(),),
                ):
                Container(
                  height: MediaQuery.of(context).size.height*.17,
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
                              right: 10
                          ),
                          height: MediaQuery.of(context).size.height*.17,
                          width: MediaQuery.of(context).size.width*.3,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12,width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white
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
                              //Container(color: Colors.black45,height: 1,width: MediaQuery.of(context).size.width,),
                              SizedBox(height: 2,),
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
                                              CustomText.CustomText10(BestList[index].offerPrice.toString()+"  "+DemoLocalizations.of(context).title["le"]),
                                             /* SizedBox(width: 7,),
                                              CustomText.CustomTextOffers(BestList[index].price.toString())*/

                                            ],
                                          ),Container(

                                            padding: EdgeInsets.only(
                                              // left: 5,right: 5
                                            ),
                                            child: CustomRate(BestList[index].rate.round(),11),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.add_shopping_cart,size: 20,)
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
                //SizedBox(height: MediaQuery.of(context).size.height*.005,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(ProductsHome(OffersList,DemoLocalizations.of(context).title["offers"])));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.94,
                    height: MediaQuery.of(context).size.height*.05,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 0,right: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        //color: Color(h.redColor)
                    ),
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(DemoLocalizations.of(context).title["offers"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                      ],
                    )
                  ),
                ),
                OffersList.length==0?
                Container(
                  height: MediaQuery.of(context).size.height*.18,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator(),),
                ):
                Container(
                    height: MediaQuery.of(context).size.height*.18,
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
                              right: 10
                            ),
                            height: MediaQuery.of(context).size.height*.18,
                            width: MediaQuery.of(context).size.width*.3,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12,width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.white
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
                                      child:LastList[index].coverPhoto==null? SizedBox():Image.network(GlobalVariable.URl+LastList[index].coverPhoto,
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                //Container(color: Colors.black45,height: 1,width: MediaQuery.of(context).size.width,),
                                SizedBox(height:2,),
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

                                Container(
                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*.3-12,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomText.CustomText10(OffersList[index].offerPrice.toString()+"  "+DemoLocalizations.of(context).title["le"]),
                                                  SizedBox(width: 5,),
                                                  CustomText.CustomTextOffers(OffersList[index].price.toString()+"  "+DemoLocalizations.of(context).title["le"])

                                                ],
                                              ),
                                            ),
                                           Container(
                                             width: MediaQuery.of(context).size.width*.3-12,
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Container(
                                                   padding: EdgeInsets.only(
                                                     // left: 5,right: 5
                                                   ),
                                                   child: CustomRate(OffersList[index].rate.round(),11),
                                                 ),
                                                 Icon(Icons.add_shopping_cart,size: 20,)
                                               ],
                                             ),
                                           )
                                          ],
                                        ),

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
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(ProductsHome(LastList,DemoLocalizations.of(context).title["lastAdded"])));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.94,
                    height: MediaQuery.of(context).size.height*.05,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 0,right: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        //color: Color(h.redColor)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(DemoLocalizations.of(context).title["lastAdded"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                      ],
                    )
                  ),
                ),
               LastList.length==0?  Container(
                 height: MediaQuery.of(context).size.height*.17,
                 width: MediaQuery.of(context).size.width,
                 child: Center(child: CircularProgressIndicator(),),
               ):
               Container(
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.03,
                       right: MediaQuery.of(context).size.width*.03
                    ),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: LastList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1/1.1
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
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white
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
                             // Divider(color: Colors.black45,thickness: 1,),
                              SizedBox(height: 2,),
                              Container(
                                padding: EdgeInsets.only(left: 3,right: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width*.22,
                                        child: CustomText.SubTitleText(LastList[index].name)),

                                  ],
                                ),
                              ),
                              SizedBox(height: 0,),
                              Container(
                                padding: EdgeInsets.only(left: 3,right: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomText.CustomText10(LastList[index].offerPrice.toString()+"  "+DemoLocalizations.of(context).title["le"]),
                                          Container(
                                            height: 7,
                                            padding: EdgeInsets.only(
                                              //left: 5,right: 5
                                            ),
                                            child: CustomRate(LastList[index].rate.round(),12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.add_shopping_cart,size: 20,)
                                    /* SizedBox(width: 7,),
                                                CustomText.CustomTextOffers(LastList[index].price.toString())*/

                                  ],
                                ),
                              ),
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