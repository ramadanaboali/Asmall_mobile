import 'dart:async';
import 'dart:io';
import 'package:ashmall/DbHelper.dart';
import 'package:ashmall/GlobalFunction.dart';
import 'package:ashmall/Model/CartModelLocal.dart';
import 'package:ashmall/Model/FavouriteLocalModel.dart';
import 'package:ashmall/Model/OneProductModel.dart';
import 'package:ashmall/Model/Product1Model.dart';
import 'package:ashmall/Model/Product2Model.dart';
import 'package:ashmall/Model/ProductGallaryModel.dart';
import 'package:ashmall/Model/ProductRateModel.dart';
import 'package:ashmall/Model/ProductSpecificationModel.dart';
import 'package:ashmall/Model/QuestionModel.dart';
import 'package:ashmall/Model/SemillarModel.dart';
import 'package:ashmall/Model/SidesModel.dart';
import 'package:ashmall/Screens/BuyNow.dart';
import 'package:ashmall/Screens/ChooseAddress.dart';
import 'package:ashmall/Screens/CustomSearchAppBar.dart';
import 'package:ashmall/Screens/Reviews.dart';
import 'package:ashmall/Screens/Store.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import '../HomePage.dart';
import 'Chat.dart';
import 'CustRate.dart';
import 'CustomText.dart';
import 'Login.dart';
import 'Orders.dart';
import 'ProductQuestion.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:image_picker/image_picker.dart';
import 'ViewRate.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProductDetails extends StatefulWidget{
  var id;
  var name;
  ProductDetails(var id,var name){
    this.id=id;
    this.name=name;
  }
  @override
  State<StatefulWidget> createState() {
return _state(this.id,this.name);
  }
}
class  _state extends State<ProductDetails>{
  final formKey=GlobalKey<FormState>();
  TextEditingController comment=new TextEditingController();
  var id;
  double rate=0.0;
  var name;
  DbHelper dbHelper=new DbHelper();
  _state(var id,var name){
    this.id=id;
    this.name=name;
  }
  ProductServices productServices=new ProductServices();
  Map<String,dynamic>data;
  List<String>Images=[];
  List<ProductSpecifiction>Specification=[];
  var token;
  var user_id;
  var lang;
  var address_id;
  List<ProductColorModel>colorList=[];
  List<ProductSizeModel>sizeList=[];
  List<SemillarDetail>SimillarProducts=[];
  List<SemillarDetail>RecomendationProducts=[];
  List<ProductRateDetail>ratelist=[];
  List<SidesDetail>sidesList=[];
  List<QuestionDetail>questions=[];
  List<ProductRateDetail>reviews=[];
  List<ProductGallaryDetail>gallary=[];
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    data=await productServices.getProductDetails(prefs.getString("lang"), this.id);
    Specification=await productServices.GesProductSpefication(prefs.getString("lang"), this.id);
    colorList=await productServices.getProductColor(prefs.getString("lang"), this.id);
    sizeList=await productServices.getProductSize(prefs.getString("lang"), this.id);
     SimillarProducts=await productServices.getSemillarProduct(prefs.getString("lang"), this.id);
     ratelist=await productServices.getProductRateWithImage(prefs.getString("lang"), this.id);
    sidesList=await productServices.getProductSides(prefs.getString("lang"), this.id);
    questions=await productServices.GetQuestion(prefs.getString("lang"), this.id);
    reviews=await productServices.getProductRate(prefs.getString("lang"), this.id);
    RecomendationProducts=await productServices.getRecomendationProduct(prefs.getString("lang"), data["vendorId"]);
    gallary=await productServices.getProductGallary(this.id);
    setState(() {
      lang=prefs.getString("lang");
      user_id=prefs.getString("id");
      address_id=prefs.getString("address_id");
      token=prefs.getString("token");
    });
     if(prefs.getString("id")!=null){
       Map<String,dynamic>responce=await productServices.addWatch(lang, this.id, prefs.getString("id"));
       print(responce.toString()+"rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
     }
     print(gallary.length);
     print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  }
  home h=new home();
  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController1.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  TextEditingController searchKey=new TextEditingController();
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: (){
       Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
       //_chewieController.dispose();
     //  _videoPlayerController1.dispose();
     },
     child: SafeArea(
       child: Scaffold(
         resizeToAvoidBottomInset: false,
          body: data!=null?Container(
          child:  Column(
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
                           hintText:DemoLocalizations.of(context).title["Search"],
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
               /*CustomAppBar(this.name),*/
               Container(
                 child: Column(
                   children: [
                     SizedBox(height: MediaQuery.of(context).size.height*.015,),
                     Container(
                       padding: EdgeInsets.only(
                           left: MediaQuery.of(context).size.width*.03,
                           right: MediaQuery.of(context).size.width*.03
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           GestureDetector(child: Icon(Icons.arrow_back),onTap: (){
                             Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                           },),
                           GestureDetector(
                             onTap: (){
                               Navigator.pushNamed(context, "/Search");
                             },
                             child: Container(
                               width: MediaQuery.of(context).size.width*.57,
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
                             child:Stack(
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
                               print("http://"+data["shareLink"]);
                               print("******************************************************8");
                               share("http://"+data["shareLink"]);
                             },
                             child: Container(
                               padding: EdgeInsets.all(5),
                               child: Icon(Icons.share_rounded),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               CustomSearchAppBar.menu(context);
                             },
                             child: Row(
                               children: [
                                 Container(
                                   padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
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
                                 SizedBox(width: 2,)
                               ],
                             ),
                           ),




                         ],
                       ),
                     ),
                     //CustomAppBar(DemoLocalizations.of(context).title["category"]),
                     SizedBox(height: MediaQuery.of(context).size.height*.015,),
                   ],
                 ),
               ),
               Expanded(
                 child:SingleChildScrollView(
                   child: Column(
                     children: [
                       Container(
                         height: MediaQuery.of(context).size.height*.3,
                         width: MediaQuery.of(context).size.width*.9,
                         child:ListView.builder(
                             scrollDirection: Axis.horizontal,
                             itemCount: gallary.length,itemBuilder: (context,index){

                           if(gallary[index].type=="Video"){
                             _videoPlayerController1 = VideoPlayerController.network(GlobalVariable.URl+gallary[index].attachment);
                             _chewieController = ChewieController(
                               videoPlayerController: _videoPlayerController1,
                               autoPlay: false,
                               aspectRatio: 6.5 / 4,
                               looping: false,
                               allowPlaybackSpeedChanging: false,
                               autoInitialize: true,
                               isLive: false,
                               placeholder: Container(
                                 height: MediaQuery.of(context).size.height*.3,
                                 width: MediaQuery.of(context).size.width*.9,
                                 color: Colors.red,
                                 child: Center(
                                   child: Icon(Icons.play_arrow),
                                 ),
                               ),
                               allowedScreenSleep: true
                             );
                           }

                           return gallary[index].type=="Video"?Container(
                             height: MediaQuery.of(context).size.height * 0.4,
                             width: MediaQuery.of(context).size.width*.9,
                             child: Chewie(
                               controller: _chewieController,
                             ),
                           ):Container(
                             height: MediaQuery.of(context).size.height*.3,
                             width: MediaQuery.of(context).size.width*.9 ,
                             child:   ClipRRect(
                               borderRadius: BorderRadius.all(Radius.circular(5)),
                               child: Image.network(GlobalVariable.URl+gallary[index].attachment,fit: BoxFit.fill,height: MediaQuery.of(context).size.height*.27 ,
                                 width: MediaQuery.of(context).size.width,
                               ),
                             ),
                           );
                         })
                       ),
                       /*Container(
                         height: MediaQuery.of(context).size.height*.3,
                         width: MediaQuery.of(context).size.width*.9 ,
                         color: Colors.white,
                         child:  new Swiper(
                           itemBuilder: (BuildContext context,int index){
                             return Column(children: [
                               ClipRRect(
                                 borderRadius: BorderRadius.all(Radius.circular(5)),
                                 child: Image.network(GlobalVariable.URl+data["imagesPaths"][index],fit: BoxFit.fill,height: MediaQuery.of(context).size.height*.27 ,
                                   width: MediaQuery.of(context).size.width,
                                 ),
                               ) ,

                             ],);
                           },
                           autoplay: true,
                           itemCount: data["imagesPaths"].length,
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
                       ),*/
                       SizedBox(height: MediaQuery.of(context).size.height*.015,),
                       Container(
                         width: MediaQuery.of(context).size.width*.9 ,
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(data["name"]),
                                 Row(
                                   children: [
                                     Text(data["offerPrice"].toString()+"  "+DemoLocalizations.of(context).title["le"],style: TextStyle(color: Color(h.mainColor),),),
                                     SizedBox(width: 10,),
                                     Text(data["price"].toString()+"  "+DemoLocalizations.of(context).title["le"],style: TextStyle(decoration: TextDecoration.lineThrough),),

                                   ],
                                 )
                               ],
                             ),
                             SizedBox(height: 7,),
                             Container(
                                 width: MediaQuery.of(context).size.width*.9 ,
                                 child: Text(data["description"],maxLines: 2,
                                   style: TextStyle(fontSize: 12),)),
                             SizedBox(height: 7,),
                             Container(
                               color: Colors.black26,
                               height: 1,
                               width:MediaQuery.of(context).size.width ,
                             ),
                             SizedBox(height: 7,),
                              Row(
                               children: [
                                 Text(DemoLocalizations.of(context).title["sellProducts"],style: TextStyle(color: Colors.black54,fontSize: 15),),
                                 SizedBox(width: 10,),
                                 Text(data["numberOfSellerItems"].toString(),style: TextStyle(color: Color(h.mainColor),fontWeight: FontWeight.bold,fontSize: 18),)
                               ],
                             ),
                             Container(
                               color: Colors.black26,
                               height: 1,
                               width:MediaQuery.of(context).size.width ,
                             ),
                             SizedBox(height: 7,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   children: [
                                     /*    GestureDetector(
                                 onTap: () async {
                                   // Navigator.pushNamed(context, '/Cart');
                                 if(sizeList.length==0&&colorList.length==0){
                                   CartMedelLocal p1=new CartMedelLocal({
                                     "id":data["id"].toString(),
                                     "name":data["name"],
                                     "img":data["imagesPaths"][0],
                                     "description":data["description"],
                                     "price":double.parse(data["offerPrice"].toString()),
                                     "totalPrice":double.parse(data["offerPrice"].toString()),
                                     "quantity":1,
                                     "ColorId":null,
                                     "ProductSizeId":null
                                   });
                                   try
                                   {
                                     await dbHelper.addToCart(p1);
                                     addProductDialog(context,"Product has Been Added To Shopping Cart", Container(
                                       padding: EdgeInsets.only(top: 13),
                                       child: Icon(Icons.check_circle,size: 50,color: Color(h.mainColor),),
                                     ),);
                                     Timer(Duration(seconds: 2), (){
                                       Navigator.pushNamedAndRemoveUntil(context, "/Cart", (route) => false);;
                                       // Phoenix.rebirth(context);
                                     });
                                   }
                                   catch(e)
                                   {
                                     addProductDialog(context,"Product Has Been Added Before ", Container(
                                       padding: EdgeInsets.only(top: 13),
                                       child: Icon(Icons.error,size: 50,color: Color(h.mainColor),),
                                     ),);
                                     Timer(Duration(seconds: 2), (){
                                       Navigator.pushNamedAndRemoveUntil(context, "/Cart", (route) => false);;
                                       // Phoenix.rebirth(context);
                                     });
                                   }
                                 }else{
                                   ProductDetail(colorList, sizeList, data["imagesPaths"][0], data["name"]);
                                 }
                                 },
                                 child: Container(
                                     padding: EdgeInsets.all(5),
                                     child: Icon(Icons.add_shopping_cart,color: Color(h.mainColor),)),
                               ),
                               SizedBox(width: 10,),*/
                                     GestureDetector(
                                       onTap: () async {
                                         FavoriteModelLocal favoriteModel = FavoriteModelLocal({
                                           'id': data["id"].toString(),
                                           'title':data["name"],
                                           "description":data["description"],
                                           "img":data["imagesPaths"][0].toString(),
                                           'price': double.parse(data["offerPrice"].toString()),
                                         });
                                         int x=await   triggerFavourite(data["id"],favoriteModel);
                                         // print('${x},,,,,,favorite');
                                         if (mounted) setState(() {});
                                         if(x==1)
                                         {
                                           Toast.show(
                                               "Product Has Been Added To Favourite", context,
                                               duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                         }
                                         else{
                                           Toast.show(
                                               "Product Has Been Removed From Favourite", context,
                                               duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                         }

                                       },
                                       child: FutureBuilder<int>(
                                         future: getFavouriteStatus(data["id"]),
                                         builder: (  context,snapData){
                                           int x = snapData.data;
                                           return Container(
                                             padding: EdgeInsets.all(2),
                                             child: Icon(x==1?Icons.favorite:Icons.favorite_border,
                                               color:Color(h.mainColor),size: 25,),
                                           );
                                         },
                                       ),
                                     ),
                                  /*   SizedBox(width: 10,),
                                     GestureDetector(
                                       onTap: (){
                                         Navigator.push(context, GlobalFunction.route(ProductQuestion(data["id"],this.name)));
                                       },
                                       child: Container(
                                           padding: EdgeInsets.all(5),
                                           child: Icon(Icons.question_answer,color: Color(h.mainColor),)),
                                     ),*/
                                    /* SizedBox(width: 10,),
                                     GestureDetector(
                                       onTap: (){
                                         Navigator.push(context, GlobalFunction.route(Reviews(data["id"],this.name)));
                                       },
                                       child: Container(
                                           padding: EdgeInsets.all(5),
                                           child: Icon(Icons.rate_review,color: Color(h.mainColor),)),
                                     ),*/
                                  /*   SizedBox(width: 10,),
                                     data["video"]!=null?
                                     GestureDetector(
                                       onTap: (){
                                         print(GlobalVariable.URL2+data["video"]);
                                         showVideoItem(GlobalVariable.URL2+data["video"]);
                                       },
                                       child: Container(
                                         height: 22,
                                         width: 25,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(5),
                                             color: Color(h.mainColor)
                                         ),
                                         child: Icon(Icons.play_arrow,color: Colors.white,size: 15,),
                                       ),
                                     ):SizedBox(),*/
                                  /*   SizedBox(width: 10,),
                                     GestureDetector(
                                       onTap: (){
                                         Navigator.push(context, GlobalFunction.route(Chat()));
                                       },
                                       child: Container(
                                           padding: EdgeInsets.all(5),
                                           child: Icon(Icons.chat_bubble_outline_outlined,color: Color(h.mainColor),)),
                                     ),*/
                                   ],
                                 ),
                                 GestureDetector(
                                     onTap: (){
                                       user_id==null?print("0000"):SetRate(context,data["id"]);
                                     },
                                     child: CustomRate(data["rate"].round(),15))
                               ],
                             ),
                           ],
                         ),
                       ),
                       /*     SizedBox(height: MediaQuery.of(context).size.height*.01,),
               Container(
                   width: MediaQuery.of(context).size.width*.9,
                   padding: EdgeInsets.only(
                     top: MediaQuery.of(context).size.height*.015,
                     bottom: MediaQuery.of(context).size.height*.015,
                     left:12,
                     right: 12
                   ),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     color: Color(h.mainColor)
                   ),
                   child: Text(DemoLocalizations.of(context).title["Reviews"],style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color: Colors.white),),
               ),*/
                       SizedBox(height: MediaQuery.of(context).size.height*.005,),
                       Container(height: 1,width: MediaQuery.of(context).size.width*.9,color: Colors.black38,),
                       colorList.length==0?SizedBox():Column(
                           children: [
                             SizedBox(height: MediaQuery.of(context).size.height*.008,),
                             Container(
                               width: MediaQuery.of(context).size.width*.9,
                               child: Row(
                                 children: [
                                   Text(DemoLocalizations.of(context).title["colors"],style: TextStyle(color: Color(h.mainColor),fontSize: 16,fontWeight: FontWeight.bold),)
                                 ],
                               ),
                             ),
                             SizedBox(height: MediaQuery.of(context).size.height*.008,),
                           ],
                         ),
                       colorList.length==0?SizedBox():
                       Container(
                         height: MediaQuery.of(context).size.height*.1,
                         width: MediaQuery.of(context).size.width,
                         child: ListView.builder(
                             padding: EdgeInsets.only(left: 10,right: 10)
                             ,scrollDirection: Axis.horizontal,shrinkWrap: true,primary: false,itemCount: colorList.length,itemBuilder: (context,index){
                           return GestureDetector(
                             onTap: (){
                               ShowImage(context,GlobalVariable.URl+colorList[index].imageColor);
                             },
                             child: Container(
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.all(Radius.circular(10)),
                                     border: Border.all(color:Colors.green,width: 1),
                                     color: Colors.white
                                 ),
                                 margin: EdgeInsets.all(3),
                                 padding: EdgeInsets.all(3),
                                 child:  Image.network(GlobalVariable.URl+colorList[index].imageColor,
                                   height: MediaQuery.of(context).size.height*.1,
                                   width: MediaQuery.of(context).size.width*.3,
                                 )
                             ),
                           );
                         }),
                       ),
                       data["productSpeceficationVMs"].length==0?SizedBox():
                       Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.008,),
                          Container(
                            width: MediaQuery.of(context).size.width*.9,
                            child: Row(
                              children: [
                                Text(DemoLocalizations.of(context).title["specification"],style: TextStyle(color: Color(h.mainColor),fontSize: 16,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*.008,),
                        ],
                      ),
                       data["productSpeceficationVMs"].length==0?
                       SizedBox():Container(
                         width: MediaQuery.of(context).size.width*.9,
                         padding: EdgeInsets.only(
                             top: 7
                         ),

                         child: ListView.builder(
                             padding: EdgeInsets.only(
                               //left: MediaQuery.of(context).size.width*.05,
                               // right: MediaQuery.of(context).size.width*.05,
                             ),
                             shrinkWrap: true,
                             primary: false,
                             itemCount: Specification.length,itemBuilder: (context,index){
                           return Container(
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.all(Radius.circular(10)),
                                   border: Border.all(color: Colors.black12,width: 1),
                                   color: Colors.black12.withOpacity(.05)
                               ),
                               width: MediaQuery.of(context).size.width,
                               margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*.01,),
                               padding: EdgeInsets.only(
                                   top: MediaQuery.of(context).size.height*.01,
                                   bottom: MediaQuery.of(context).size.height*.01,
                                   left:12,
                                   right: 12
                               ),

                               child: Column(
                                 children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(Specification[index].speceficationName),
                                       Text(Specification[index].value)
                                     ],
                                   ),
                                   /* SizedBox(height: 5,),
                             Container(
                               height: 1,
                               width: MediaQuery.of(context).size.width,
                               color: Colors.black12,
                             )*/
                                 ],
                               )
                           );
                         }),
                       ),
                      ratelist.length==0?SizedBox():
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                         // border: Border.all(color: Colors.black54,width: 1)
                        ),
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height*.008,),
                                Container(
                                  width: MediaQuery.of(context).size.width*.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Cusstomer Reviews",style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.bold),),
                                      GestureDetector(
                                          onTap: (){
                                            user_id==null?print("0000"):SetRate(context,data["id"]);
                                          },
                                          child: CustomRate(data["rate"].round(),15))
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*.008,),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Container(
                              height: MediaQuery.of(context).size.height*.12,
                              width: MediaQuery.of(context).size.width*.9,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                 itemCount: ratelist.length,itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, GlobalFunction.route(ViewRate(ratelist[index])));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*.2,
                                    height: MediaQuery.of(context).size.height*.12,
                                    child: Row(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context).size.width*.2-8,
                                            height: MediaQuery.of(context).size.height*.12,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                child: Image.network(GlobalVariable.URl+ratelist[index].photo,fit: BoxFit.cover,))),
                                        SizedBox(width: 8,)
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                       SizedBox(height: MediaQuery.of(context).size.height*.01,),
                       reviews.length==0?SizedBox():GestureDetector(
                         onTap: (){
                           Navigator.push(context, GlobalFunction.route(Reviews(data["id"],this.name)));
                         },
                         child: Container(
                           width: MediaQuery.of(context).size.width*.9,
                           padding: EdgeInsets.only(top: 8,bottom: 8),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(DemoLocalizations.of(context).title["reviews"],style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.bold),),
                               Text(DemoLocalizations.of(context).title["seeAll"],style: TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.bold),)
                             ],
                           ),
                         ),
                       ),
                       Container(
                         width: MediaQuery.of(context).size.width*.9,
                         child: ListView.builder(primary: false,shrinkWrap: true,itemCount: reviews.length>2?2:reviews.length,itemBuilder: (context,index){
                           return Container(
                             width: MediaQuery.of(context).size.width*.9,
                             margin: EdgeInsets.only(bottom:index==reviews.length-1?MediaQuery.of(context).size.height*.05:MediaQuery.of(context).size.height*.01,),
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
                                               child: reviews[index].userPhoto==null?Icon(Icons.person,):Image.network(GlobalVariable.URl+reviews[index].userPhoto,fit: BoxFit.fill,)),
                                         ),
                                         SizedBox(width: 5,),
                                         Container(
                                             width: MediaQuery.of(context).size.width*.55,
                                             child: Text(reviews[index].userName,maxLines: 1,))
                                       ],
                                     ),
                                     CustomRate(reviews[index].rateNum.round(),12)
                                   ],
                                 ),
                                 SizedBox(height: 8,),
                                 Container(
                                   padding: EdgeInsets.only(left: 0,right: 0),
                                   child: Row(
                                     children: [
                                       Container(
                                         width:reviews[index].photo==null?MediaQuery.of(context).size.width*.6-20:MediaQuery.of(context).size.width*.68-20,
                                         child: Text(reviews[index].comment,
                                           maxLines: 3,textAlign: TextAlign.start,style: TextStyle(fontSize: 12),),
                                       ),
                                       reviews[index].photo!=null?Image.network(GlobalVariable.URL2.toString()+reviews[index].photo.toString(),
                                         width: MediaQuery.of(context).size.width*.2,
                                         height: MediaQuery.of(context).size.height*.12,
                                         fit: BoxFit.fill,
                                       ):SizedBox()
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: 8,),
                               ],
                             ),
                           );
                         }),
                       ),
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context, GlobalFunction.route(ProductQuestion(data["id"],this.name)));
                         },
                         child: Container(
                           width: MediaQuery.of(context).size.width*.9,
                           padding: EdgeInsets.only(top: 8,bottom: 8),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(DemoLocalizations.of(context).title["question"],style: TextStyle(color: Color(h.mainColor),fontSize: 16,fontWeight: FontWeight.bold),),
                               Text(questions.length==0?DemoLocalizations.of(context).title["addQuestion"]:DemoLocalizations.of(context).title["seeAll"],style: TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.bold),)
                             ],
                           ),
                         ),
                       ),
                       Container(
                         child: ListView.builder(shrinkWrap: true,primary: false,itemCount: questions.length>2?2:questions.length,itemBuilder: (context,index){
                           return Container(
                             width: MediaQuery.of(context).size.width*.9,
                             //height: MediaQuery.of(context).size.height*.12,
                             padding: EdgeInsets.only(
                               left: MediaQuery.of(context).size.width*.03,
                               right: MediaQuery.of(context).size.width*.03,
                               top: MediaQuery.of(context).size.height*.01 ,
                               bottom: MediaQuery.of(context).size.height*.01 ,

                             ),
                             margin: EdgeInsets.only(
                                 left: MediaQuery.of(context).size.width*.05,
                                 bottom:MediaQuery.of(context).size.height*.01 ,
                                 right: MediaQuery.of(context).size.width*.05
                             ),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(15)),
                                 border: Border.all(color: Colors.black12,width: 1),
                                 color: Colors.white
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Row(
                                       children: [
                                         Row(children: [
                                           CircleAvatar(
                                             minRadius: 13,
                                             maxRadius: 14,
                                             child: ClipRRect(
                                                 borderRadius: BorderRadius.all(Radius.circular(1000)),
                                                 child: Image.network(GlobalVariable.URl+questions[index].questionDto.userPhoto.toString())),
                                           ),
                                           SizedBox(width: 3,),
                                           Container(
                                               width: MediaQuery.of(context).size.width*.46-15,
                                               child: Text(questions[index].questionDto.userName.toString(),maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(h.mainColor)),)),
                                         ],),
                                         Container(
                                           width: MediaQuery.of(context).size.width*.28,
                                           child: Row(
                                             children: [
                                               Text(questions[index].questionDto.creationDate.toString(),style: TextStyle(fontSize:8,color: Colors.black),),
                                               SizedBox(width: 3,),
                                               Text(questions[index].questionDto.creationTime.toString(),style: TextStyle(fontSize: 8,color: Colors.black),),
                                             ],
                                           ),
                                         )
                                       ],
                                     ),
                                     SizedBox(height: 5,),
                                     Row(children: [
                                       SizedBox(width: 30,height: 15,),
                                       Container(
                                           width: MediaQuery.of(context).size.width*.68,
                                           child: Text(questions[index].questionDto.questionText,style: TextStyle(fontSize: 12,color: Colors.black),)),
                                     ],),
                                   ],
                                 ),
                               ],
                             ),
                           );
                         }),
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*.01,),
                       Container(
                         child: Column(
                           children: [
                             Container(
                               padding: EdgeInsets.only(
                                 left: MediaQuery.of(context).size.width*.05,
                                 right: MediaQuery.of(context).size.width*.05,
                                 bottom: 5,top: 5
                               ),
                               child: Row(
                                 children: [
                                   Text(DemoLocalizations.of(context).title["SimillarProduct"],style: TextStyle(color: Color(h.mainColor),fontSize: 16,fontWeight: FontWeight.bold),),
                                 ],
                               ),
                             ),
                             Container(
                               child: GridView.builder(
                                 padding: EdgeInsets.only(
                                     left: MediaQuery.of(context).size.width*.05,
                                     right: MediaQuery.of(context).size.width*.05,
                                   bottom: 30
                                 ),
                                 primary: false,
                                 shrinkWrap: true,
                                 itemCount: SimillarProducts.length,
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
                                      Navigator.push(context, GlobalFunction.route(ProductDetails(SimillarProducts[index].id,SimillarProducts[index].name)));
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
                                                 child: Image.network(GlobalVariable.URl+SimillarProducts[index].coverPhoto,
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
                                                             child:Text(SimillarProducts[index].name,maxLines: 1,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),

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
                                                             CustomText.CustomText10(SimillarProducts[index].offerPrice.toString()+"  "+DemoLocalizations.of(context).title["le"]),
                                                             SizedBox(width: 3,),
                                                             Container(
                                                               height: 7,
                                                               padding: EdgeInsets.only(
                                                                 //left: 5,right: 5
                                                               ),
                                                               child: CustomRate(SimillarProducts[index].rate.round(),9),
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
                               ),
                             )
                           ],
                         ),
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*.0,),
                       Container(
                         child: Column(
                           children: [
                             Container(
                               padding: EdgeInsets.only(
                                   left: MediaQuery.of(context).size.width*.05,
                                   right: MediaQuery.of(context).size.width*.05,
                                   bottom: 5,top: 5
                               ),
                               child: Row(
                                 children: [
                                   Text(DemoLocalizations.of(context).title["SellerRecommendations"],style: TextStyle(color: Color(h.mainColor),fontSize: 16,fontWeight: FontWeight.bold),),
                                 ],
                               ),
                             ),
                             Container(
                               child: GridView.builder(
                                 padding: EdgeInsets.only(
                                     left: MediaQuery.of(context).size.width*.05,
                                     right: MediaQuery.of(context).size.width*.05,
                                     bottom: 30
                                 ),
                                 primary: false,
                                 shrinkWrap: true,
                                 itemCount: RecomendationProducts.length,
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
                                       Navigator.push(context, GlobalFunction.route(ProductDetails(RecomendationProducts[index].id,RecomendationProducts[index].name)));
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
                                                 child: Image.network(GlobalVariable.URl+RecomendationProducts[index].coverPhoto,
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
                                                             child:Text(RecomendationProducts[index].name,maxLines: 1,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),

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
                                                             CustomText.CustomText10(RecomendationProducts[index].offerPrice.toString()+"  "+DemoLocalizations.of(context).title["le"]),
                                                             SizedBox(width: 3,),
                                                             Container(
                                                               height: 7,
                                                               padding: EdgeInsets.only(
                                                                 //left: 5,right: 5
                                                               ),
                                                               child: CustomRate(RecomendationProducts[index].rate.round(),9),
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
                               ),
                             )
                           ],
                         ),
                       ),
                       sidesList.length==0?SizedBox():
                       Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(10)),
                            // border: Border.all(color: Colors.black54,width: 1)
                         ),
                         padding: EdgeInsets.all(3),
                         child: Column(
                           children: [
                             Column(
                               children: [
                                 //SizedBox(height: MediaQuery.of(context).size.height*.008,),
                                 Container(
                                   width: MediaQuery.of(context).size.width*.9,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(DemoLocalizations.of(context).title["MoreDetails"],style: TextStyle(color: Color(h.mainColor),fontSize: 16,fontWeight: FontWeight.bold),),
                                     ],
                                   ),
                                 ),
                               //  SizedBox(height: MediaQuery.of(context).size.height*.008,),
                               ],
                             ),
                             SizedBox(height: 5,),
                             Container(
                             //  height: MediaQuery.of(context).size.height*.18,
                               width: MediaQuery.of(context).size.width*.9,
                               child: ListView.builder(
                                 shrinkWrap: true,primary: false,
                                   itemCount: sidesList.length,itemBuilder: (context,index){
                                 return GestureDetector(
                                   onTap: (){
                                     ShowImage(context, GlobalVariable.URl+sidesList[index].sideImage);
                                   },
                                   child: Container(
                                     width: MediaQuery.of(context).size.width*.9,
                                     height: MediaQuery.of(context).size.height*.25,
                                     margin: EdgeInsets.only(bottom: 10),
                                     child: Row(
                                       children: [
                                         Container(
                                             width: MediaQuery.of(context).size.width*.9-8,
                                             height: MediaQuery.of(context).size.height*.25,
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                                               //  border: Border.all(color: Colors.green,width: 1)
                                             ),
                                             child: Column(
                                               children: [
                                                Row(
                                                  children: [
                                                    SizedBox(width:10),
                                                    Text(sidesList[index].title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                                                  ],
                                                ),
                                                 SizedBox(height:5),
                                                 Expanded(
                                                   child: ClipRRect(
                                                       borderRadius: BorderRadius.all(Radius.circular(10)),
                                                       child: Image.network(GlobalVariable.URl+sidesList[index].sideImage,fit: BoxFit.fill,
                                                         width: MediaQuery.of(context).size.width*.9-8,
                                                         height: MediaQuery.of(context).size.height*.25,)),
                                                 ),

                                               ],
                                             )),
                                         SizedBox(width: 8,)
                                       ],
                                     ),
                                   ),
                                 );
                               }),
                             )
                           ],
                         ),
                       ),
                     ],
                   ),
                 )
               ),
               Container(
                 height: MediaQuery.of(context).size.height*.065,
                 width: MediaQuery.of(context).size.width,
                color: Color(h.mainColor),
                padding: EdgeInsets.only(top: 1),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, GlobalFunction.route(Store(data["vendorId"])));
                      },
                      child: Container(
                        width:  MediaQuery.of(context).size.width*.2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white,width: 1)
                        ),
                        alignment: Alignment.center,
                        child:Text(DemoLocalizations.of(context).title["store"],style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async{
                        if(sizeList.length==0&&colorList.length==0){
                          CartMedelLocal p1=new CartMedelLocal({
                            "id":data["id"].toString(),
                            "name":data["name"],
                            "img":data["imagesPaths"][0],
                            "description":data["description"],
                            "price":double.parse(data["offerPrice"].toString()),
                            "totalPrice":double.parse(data["offerPrice"].toString()),
                            "quantity":1,
                            "ColorId":null,
                            "ProductSizeId":null,
                            "selectItem":1
                          });
                          try
                          {
                            SharedPreferences prefs=await SharedPreferences.getInstance();
                            await dbHelper.addToCart(p1);
                            setState((){
                              ParentPage.counter=ParentPage.counter+1;
                              ParentPage.total=ParentPage.total+double.parse(data["offerPrice"].toString());
                              ParentPage.quantity= ParentPage.quantity+1;
                            });
                            prefs.setString("total", ParentPage.total.toString());
                            prefs.setString("quantity", ParentPage.quantity.toString());
                         /*   addProductDialog(context,"Product has Been Added To Shopping Cart", Container(
                              padding: EdgeInsets.only(top: 13),
                              child: Icon(Icons.check_circle,size: 50,color: Color(h.mainColor),),
                            ),);*/
                            Timer(Duration(seconds: 2), (){
                              Navigator.pushNamedAndRemoveUntil(context, "/Cart", (route) => false);;
                              // Phoenix.rebirth(context);
                            });
                          }
                          catch(e)
                          {
                            addProductDialog(context,"Product Has Been Added Before ", Container(
                              padding: EdgeInsets.only(top: 13),
                              child: Icon(Icons.error,size: 50,color: Color(h.mainColor),),
                            ),);
                            Timer(Duration(seconds: 2), (){
                              Navigator.pushNamedAndRemoveUntil(context, "/Cart", (route) => false);;
                              // Phoenix.rebirth(context);
                            });
                          }
                        }else{
                          ProductDetail(colorList, sizeList, data["imagesPaths"][0], data["name"],data["offerPrice"].toString(),data["description"]);
                        }
                      },
                      child: Container(
                        width:  MediaQuery.of(context).size.width*.4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 1)
                        ),
                        child:Text(DemoLocalizations.of(context).title["addtocart"],style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async{
                        SharedPreferences prefs=await SharedPreferences.getInstance();
                        //  loadData();
                        if(ParentPage.user_id!=null){
                          if(colorList.length==0&&sidesList.length==0){
                            Navigator.push(context, GlobalFunction.route(BuyNow(data["name"], data["coverPhoto"], data["price"].toString(), data["id"], null, null,1)));
                          }
                          else
                            BuyProductDetail(colorList, sizeList, data["imagesPaths"][0], data["name"],data["offerPrice"].toString(),data["description"]);
                        }
                        else{
                          Navigator.push(context, GlobalFunction.route(Login("buy")));
                        }

                      },
                      child: Container(
                        width:  MediaQuery.of(context).size.width*.4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 1)
                        ),
                        child:Text(DemoLocalizations.of(context).title["buynow"],style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
               )

             ],
           ),

       ):Center(child: CircularProgressIndicator(),),
       ),
     ),
   );
  }
  Future<int> triggerFavourite(String productId,FavoriteModelLocal favoriteModel) async {
    int status = await getFavouriteStatus(productId);
    if (status == 0) {
      dbHelper.addToFavorite(favoriteModel);
      return 1;
    } else {
      dbHelper.deleteFavorite(productId);
      return 0;
    }
  }
  Future<int> getFavouriteStatus(String productId) async {
    bool found = await dbHelper.isProductFoundInFavouriteTable(productId);
    if (found == true) {
      return 1;
    } else {
      return 0;
    }
  }
  SetRate(BuildContext context,var ProductId) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            height: MediaQuery.of(context).size.height*.35,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12,width: 2.0)
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center
                ,crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 Form(
                   key: formKey,
                   child: Column(
                     children: [
                       Container(
                         width: MediaQuery.of(context).size.width*.8,
                         decoration: BoxDecoration(
                           /* borderRadius:BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white,*/
                         ),
                         child: TextFormField(
                           keyboardType: TextInputType.text,
                           validator: (value){
                             if(value.isEmpty){
                               return "Enter comment";
                             }
                             return null;
                           },
                           //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                           decoration: InputDecoration(
                             errorStyle: TextStyle(fontSize: 11),
                             contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                             hintText:"Enter Comment",
                             hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                             suffixIconConstraints: BoxConstraints(
                                 maxHeight: 50,
                                 minHeight: 30,
                                 maxWidth: 70,
                                 minWidth: 50
                             ) ,
                           ),
                           controller: comment,
                         ),
                       ),
                       SizedBox(height: 10,),
                       GestureDetector(
                         onTap: (){
                           pickImage(context);
                         },
                         child: Column(
                           children: [
                             Container(
                               height: MediaQuery.of(context).size.height*.06,
                               width: MediaQuery.of(context).size.width,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                               ),
                               padding: EdgeInsets.only(
                                 top: MediaQuery.of(context).size.height*.015,
                                 bottom: MediaQuery.of(context).size.height*.015,
                               ),
                               child: Text(selectedImage==null?"Choose File":selectedImage.path.substring(0,50),style: TextStyle(fontSize: 12,color: Colors.black38),),
                             ),
                             Container(
                               height: 1,
                               width: MediaQuery.of(context).size.width,
                               color: Colors.black38,
                             )
                           ],
                         ),
                       )
                     ],
                   ),
                 ),
                  SizedBox(height: 15,),
                  SmoothStarRating(
                    rating:rate,
                      isReadOnly: false,
                    size: 30,
                    filledIconData: Icons.star,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    onRated: (val){
                      setState(() {
                        rate=val;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    child: Container(
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:Colors.blue
                      ),
                      height: MediaQuery.of(context).size.height*.045,
                      width: MediaQuery.of(context).size.width*.5,
                      alignment: Alignment.center,
                      child:   Text( "تاكيد",style: TextStyle(color:Colors.white,fontSize: 10),),
                    ),
                    onTap: ()async{
                      if(formKey.currentState.validate()){
                        ProductServices.SetRateServices(selectedImage, context, user_id, comment.text, int.parse(rate.floor().toString()),  ProductId);

                      }
                      /*if(formKey.currentState.validate()){
                        Map<String,dynamic>responce=await productServices.SetRate(lang, token, comment.text, int.parse(rate.floor().toString()), ProductId, user_id);
                        Navigator.pop(context);
                        setState(() {
                          comment.text="";
                          rate=0.0;
                        });
                        if(responce["status"]==200){
                          Toast.show(
                              "Your Comment Has Been Added", context,
                              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                        }
                        else{
                          Toast.show(
                              "You Have Add Comment Before", context,
                              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                        }
                      }*/
                    },
                  ),
                  SizedBox(height: 8,),
                ],
              ),


            ],),
          ),
        ));
  }
  void ProductDetail(List<ProductColorModel>colors,List<ProductSizeModel>size,String image,String name,var price,var description) {
    var SizeValue=sizeList[0].id;
    var SelectedColor=colors[0].id;
    int counter =1;
       showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return  Scaffold(
                  backgroundColor:Colors.transparent,
                  body: Container(
                    // height: MediaQuery.of(context).size.height*.75,
                    child: Column(
                      children: [
                        Expanded(child:SizedBox()),
                         Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)
                                )),
                            child: SingleChildScrollView(
                              child: Container(
                                // height: MediaQuery.of(context).size.height*.75,
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width*.05,
                                    right:  MediaQuery.of(context).size.width*.05
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20)
                                    )),
                                child: ListView(
                                  shrinkWrap: true,primary: false,
                                  children:[
                                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.black12
                                      ),
                                      width: MediaQuery.of(context).size.width*.1,
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width*.37,
                                          right: MediaQuery.of(context).size.width*.37
                                      ),
                                      height: 5,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                                onTap: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                                                        color: Color(h.mainColor)
                                                    ),
                                                    padding: EdgeInsets.all(2),
                                                    child: Icon(Icons.clear,size: 20,color: Colors.white,))),
                                          ],
                                        )
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*.015,),
                                    Container(
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: Image.network(GlobalVariable.URl+image,
                                                width: MediaQuery.of(context).size.width*.9,
                                                height: MediaQuery.of(context).size.height*.2,
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*.025,),
                                    Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(name,style: TextStyle(fontSize: 16,color: Colors.black54),),
                                       Row(
                                         children: [
                                           GestureDetector(
                                             onTap: (){
                                               setState((){
                                                 counter=counter+1;
                                               });
                                             },
                                             child: Container(
                                                 padding: EdgeInsets.all(1.5),
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.all(Radius.circular(100)),
                                                   border: Border.all(color: Color(h.mainColor),width: 1.5)
                                                 ),
                                                 child: Icon(Icons.add,size: 18,)),
                                           ),
                                           SizedBox(width: 15,),
                                           Text(counter.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                                           SizedBox(width: 15,),
                                           GestureDetector(
                                             onTap: (){
                                             if(counter>1){
                                               setState((){
                                                 counter=counter-1;
                                               });
                                             }
                                             },
                                             child: Container(
                                               padding: EdgeInsets.all(1.5),
                                                 decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.all(Radius.circular(100)),
                                                     border: Border.all(color: Color(h.mainColor),width: 1.5)
                                                 ),
                                                 child: Icon(Icons.remove,size: 18,)),
                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*.7,
                                          child:Text(description,style: TextStyle(fontSize: 10,color: Colors.black54),maxLines: 3,)
                                        ),
                                        Text(price+"  "+DemoLocalizations.of(context).title["le"],style: TextStyle(color: Color(h.mainColor)),)
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*.025,),
                                    /* SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "images/logo.png",
                                      image:image==null?"":GlobalVariable.URl+image,
                                      width: MediaQuery.of(context).size.width*.9,
                                      height: MediaQuery.of(context).size.height*.15,
                                      fit: BoxFit.cover,
                                    ),
                                  ),*/
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          colorList.length==0||colorList==null?  SizedBox():
                                          Column(
                                            children: [
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                              Text(DemoLocalizations.of(context).title["selectColor"],style: TextStyle(fontSize: 16,color: Colors.black54),),
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                            ],
                                          ),
                                          Container(
                                            height: MediaQuery.of(context).size.height*.1,
                                            width: MediaQuery.of(context).size.width,
                                            child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,primary: false,itemCount: colorList.length,itemBuilder: (context,index){
                                              return GestureDetector(
                                                onTap: (){
                                                  setState((){
                                                    SelectedColor=colorList[index].id;
                                                  });
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        border: Border.all(color: SelectedColor==colorList[index].id?Color(h.mainColor):Colors.white,width: 1),
                                                        color: Colors.white
                                                    ),
                                                    margin: EdgeInsets.all(3),
                                                    padding: EdgeInsets.all(3),
                                                    child:  Image.network(GlobalVariable.URl+colorList[index].imageColor,
                                                      height: MediaQuery.of(context).size.height*.1,
                                                    )
                                                ),
                                              );
                                            }),
                                          ),
                                          sizeList.length==0||sizeList==null?  SizedBox():
                                          Column(
                                            children: [
                                              SizedBox(height: MediaQuery.of(context).size.height*.02,),
                                              Text(DemoLocalizations.of(context).title["selectSize"],style: TextStyle(fontSize: 16,color: Colors.black54),),
                                              SizedBox(height: MediaQuery.of(context).size.height*.00,),
                                            ],
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: ListView.builder(padding: EdgeInsets.zero,scrollDirection: Axis.vertical,shrinkWrap: true,primary: false,itemCount: sizeList.length,itemBuilder: (context,index){
                                              return GestureDetector(
                                                onTap: (){
                                                  setState((){
                                                    SizeValue=sizeList[index].id;
                                                  });
                                                },
                                                child: Container(
                                                    child: Row(
                                                      children: [
                                                        Radio(groupValue: SizeValue,value: sizeList[index].id,onChanged: (val){
                                                          setState((){
                                                            SizeValue=sizeList[index].id;
                                                          });
                                                        },),
                                                        SizedBox(width: 8,),
                                                        Text(sizeList[index].sizeValue,style: TextStyle(color: Colors.black54,fontSize: 12),)
                                                      ],
                                                    )
                                                ),
                                              );
                                            }),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    GestureDetector(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                            //right:  MediaQuery.of(context).size.width*.2,
                                            //left:  MediaQuery.of(context).size.width*.2
                                          ),
                                          decoration:BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Color(h.mainColor),
                                          ),
                                          height: MediaQuery.of(context).size.height*.06,
                                          width: MediaQuery.of(context).size.width*.8,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.width*.07,
                                            right: MediaQuery.of(context).size.width*.07,
                                          ),
                                          child:   Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(DemoLocalizations.of(context).title["addtocart"],style: TextStyle(color:Colors.white,fontSize: 13),),
                                            ],
                                          )
                                      ),
                                      onTap: () async {
                                        print(data["id"].toString());
                                        CartMedelLocal p1=new CartMedelLocal({
                                          "id":data["id"],
                                          "name":data["name"],
                                          "img":data["imagesPaths"][0],
                                          "description":data["description"],
                                          "price":double.parse(data["offerPrice"].toString()),
                                          "totalPrice":double.parse(data["offerPrice"].toString()),
                                          "quantity":counter,
                                          "ColorId":SelectedColor,
                                          "ProductSizeId":SizeValue,
                                          "selectItem":1
                                        });
                                        try
                                        {
                                          await dbHelper.addToCart(p1);
                                          SharedPreferences prefs=await SharedPreferences.getInstance();
                                          setState((){
                                            ParentPage.counter=ParentPage.counter+1;
                                            ParentPage.total=ParentPage.total+(double.parse(data["offerPrice"].toString())*counter);
                                            ParentPage.quantity= ParentPage.quantity+counter;
                                          });
                                          prefs.setString("total", ParentPage.total.toString());
                                          prefs.setString("quantity", ParentPage.quantity.toString());
                                          print("en tyy");
                                          /*    addProductDialog(context,"Product  Added To Shopping Cart", Container(
                                          padding: EdgeInsets.only(top: 13),
                                          child: Icon(Icons.check_circle,size: 50,color: Color(h.mainColor),),
                                        ),);*/
                                          Timer(Duration(seconds: 2), (){
                                            Navigator.pushNamedAndRemoveUntil(context, "/Cart", (route) => false);;
                                            // Phoenix.rebirth(context);
                                          });
                                        }
                                        catch(e)
                                        {
                                          print('${e},,,,,,errorro addd');
                                          addProductDialog(context,"Product Has Been Added Before ", Container(
                                            padding: EdgeInsets.only(top: 13),
                                            child: Icon(Icons.error,size: 50,color: Color(h.mainColor),),
                                          ),);
                                          Timer(Duration(seconds: 2), (){
                                            Navigator.pushNamedAndRemoveUntil(context, "/Cart", (route) => false);
                                            // Phoenix.rebirth(context);
                                          });
                                        }
                                      },
                                    ),
                                    SizedBox(height: 15,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),


                  )
                );
              });
        });
  }
  void BuyProductDetail(List<ProductColorModel>colors,List<ProductSizeModel>size,String image,String name,var price,var description) {
    var SizeValue=sizeList[0].id;
    var SelectedColor=colors[0].id;
    int counter =1;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return  Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    child: Column(
                      children: [
                        Expanded(child: Container(color: Colors.transparent,),),
                        Container(
                          // height: MediaQuery.of(context).size.height*.75,
                          child: Container(
                            // height: MediaQuery.of(context).size.height*.75,
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width*.05,
                                right:  MediaQuery.of(context).size.width*.05
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)
                                )),
                            child: ListView(
                              primary: false,shrinkWrap: true,
                              children:[
                                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.black12
                                  ),
                                  width: MediaQuery.of(context).size.width*.1,
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width*.37,
                                      right: MediaQuery.of(context).size.width*.37
                                  ),
                                  height: 5,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                                                    color: Color(h.mainColor)
                                                ),
                                                padding: EdgeInsets.all(2),
                                                child: Icon(Icons.clear,size: 20,color: Colors.white,))),
                                      ],
                                    )
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                                Container(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        child: Image.network(GlobalVariable.URl+image,
                                          width: MediaQuery.of(context).size.width*.9,
                                          height: MediaQuery.of(context).size.height*.2,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*.025,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(name,style: TextStyle(fontSize: 16,color: Colors.black54),),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setState((){
                                              counter=counter+1;
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(1.5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  border: Border.all(color: Color(h.mainColor),width: 1.5)
                                              ),
                                              child: Icon(Icons.add,size: 18,)),
                                        ),
                                        SizedBox(width: 15,),
                                        Text(counter.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                                        SizedBox(width: 15,),
                                        GestureDetector(
                                          onTap: (){
                                            if(counter>1){
                                              setState((){
                                                counter=counter-1;
                                              });
                                            }
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(1.5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  border: Border.all(color: Color(h.mainColor),width: 1.5)
                                              ),
                                              child: Icon(Icons.remove,size: 18,)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*.025,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width*.7,
                                        child:Text(description,style: TextStyle(fontSize: 10,color: Colors.black54),maxLines: 3,)
                                    ),
                                    Text(price+"  "+DemoLocalizations.of(context).title["le"],style: TextStyle(color: Color(h.mainColor)),)
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*.025,),

                                /* SizedBox(height: MediaQuery.of(context).size.height*.01,),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: FadeInImage.assetNetwork(
                              placeholder: "images/logo.png",
                              image:image==null?"":GlobalVariable.URl+image,
                              width: MediaQuery.of(context).size.width*.9,
                              height: MediaQuery.of(context).size.height*.15,
                              fit: BoxFit.cover,
                            ),
                          ),*/
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      colorList.length==0||colorList==null?  SizedBox():
                                      Column(
                                        children: [
                                          SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                          Text(DemoLocalizations.of(context).title["selectColor"],style: TextStyle(fontSize: 16,color: Colors.black54),),
                                          SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                        ],
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height*.1,
                                        width: MediaQuery.of(context).size.width,
                                        child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,primary: false,itemCount: colorList.length,itemBuilder: (context,index){
                                          return GestureDetector(
                                            onTap: (){
                                              setState((){
                                                SelectedColor=colorList[index].id;
                                              });
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    border: Border.all(color: SelectedColor==colorList[index].id?Color(h.mainColor):Colors.white,width: 1),
                                                    color: Colors.white
                                                ),
                                                margin: EdgeInsets.all(3),
                                                padding: EdgeInsets.all(3),
                                                child:  Image.network(GlobalVariable.URl+colorList[index].imageColor,
                                                  height: MediaQuery.of(context).size.height*.1,
                                                )
                                            ),
                                          );
                                        }),
                                      ),
                                      sizeList.length==0||sizeList==null?  SizedBox():
                                      Column(
                                        children: [
                                          SizedBox(height: MediaQuery.of(context).size.height*.02,),
                                          Text(DemoLocalizations.of(context).title["selectSize"],style: TextStyle(fontSize: 16,color: Colors.black54),),
                                          SizedBox(height: MediaQuery.of(context).size.height*.0,),
                                        ],
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,shrinkWrap: true,primary: false,itemCount: sizeList.length,itemBuilder: (context,index){
                                          return GestureDetector(
                                            onTap: (){
                                              setState((){
                                                SizeValue=sizeList[index].id;
                                              });
                                            },
                                            child: Container(
                                                child: Row(
                                                  children: [
                                                    Radio(groupValue: SizeValue,value: sizeList[index].id,onChanged: (val){
                                                      setState((){
                                                        SizeValue=sizeList[index].id;
                                                      });
                                                    },),
                                                    SizedBox(width: 8,),
                                                    Text(sizeList[index].sizeValue,style: TextStyle(color: Colors.black54,fontSize: 12),)
                                                  ],
                                                )
                                            ),
                                          );
                                        }),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*.03,),
                                GestureDetector(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                        //right:  MediaQuery.of(context).size.width*.2,
                                        //left:  MediaQuery.of(context).size.width*.2
                                      ),
                                      decoration:BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(h.mainColor),
                                      ),
                                      height: MediaQuery.of(context).size.height*.06,
                                      width: MediaQuery.of(context).size.width*.8,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width*.07,
                                        right: MediaQuery.of(context).size.width*.07,
                                      ),
                                      child:   Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(DemoLocalizations.of(context).title["buynow"],style: TextStyle(color:Colors.white,fontSize: 13),),
                                        ],
                                      )
                                  ),
                                  onTap: () async {
                                    Navigator.push(context, GlobalFunction.route(BuyNow(data["name"], data["coverPhoto"], data["price"].toString(), data["id"], SelectedColor, SizeValue,counter)));
                                  },
                                ),
                                SizedBox(height: 20,)
                              ],
                            ),
                          ),


                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  addProductDialog(BuildContext context,String message,Widget widgeticon) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            height: 160.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                border: Border.all(color: Colors.black12,width: 2.0),
                color: Colors.white
            ),
            child: Stack(children: <Widget>[
              Column(
                //mainAxisAlignment: MainAxisAlignment.center
                // ,crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(alignment: Alignment.center,child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Container(

                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  color: Colors.white
                              ),
                              // padding:EdgeInsets.all(2),
                              child: Icon(Icons.clear,color: Colors.white,size: 14,),
                            ),
                           widgeticon,

                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                                    color: Color(h.mainColor)
                                ),
                                padding:EdgeInsets.all(2.5),
                                child: Icon(Icons.clear,color: Colors.white,size: 20,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10,),
                      Text("$message",style: TextStyle(color: Color(h.mainColor),fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      // Text("${title}",textAlign: TextAlign.center,)
                    ],
                  )),
                ],
              ),


            ],),
          ),
        ));
  }
  showVideoItem(String videoPath) {
    _videoPlayerController1 = VideoPlayerController.network(videoPath);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      aspectRatio: 3 / 3,
      looping: false,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) =>  WillPopScope(
        onWillPop: ()async{
          _chewieController.pause();
          //_videoPlayerController1.pause();
          Navigator.of(context).pop();
          return true;
        },
        child: Scaffold(
          backgroundColor:Colors.transparent ,
          body: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  bottom: MediaQuery.of(context).size.height * 0.2,
                  right: MediaQuery.of(context).size.width*.05,
                  left: MediaQuery.of(context).size.width*.05
              ),
              color: Colors.white,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                  Positioned(
                      left: MediaQuery.of(context).size.width*.05,
                      child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            size: 30.0,
                          ),
                          onPressed: () {
                            _chewieController.pause();
                            // _chewieController.exitFullScreen();
                            //_chewieController.dispose();
                            Navigator.of(context).pop();

                            //_videoPlayerController1.dispose();
                          }))
                ],
              )),
        ),
      ),
    );
  }
  File selectedImage;
  pickImage(BuildContext context ) async {
    ImagePicker picker =new ImagePicker();
    var profileImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
   //   selectedImage = profileImage;
    });

  }
  Future<void> share(String url) async {
    await FlutterShare.share(
        title: 'Product Details',
        text: '',
        linkUrl: url,
        chooserTitle: 'Product'
    );
  }
  ShowImage(BuildContext context,String url) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            padding: EdgeInsets.only(

            ),
            height: 300.0,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                border: Border.all(color: Colors.black12,width: 2.0),
                color: Colors.white
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            color: Color(h.mainColor)
                        ),
                        padding: EdgeInsets.all(3),
                        child: Icon(Icons.clear,color: Colors.white,),
                      ),
                    ),
                  ],
                ),
                Image.network(url,fit:BoxFit.fill,
                  height: 250.0,
                  width: 200,
                ),
              ],
            )

          ),
        ));
  }
}