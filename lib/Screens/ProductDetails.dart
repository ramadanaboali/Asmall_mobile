import 'dart:async';
import 'dart:io';

import 'package:ashmall/DbHelper.dart';
import 'package:ashmall/GlobalFunction.dart';
import 'package:ashmall/Model/CartModelLocal.dart';
import 'package:ashmall/Model/FavouriteLocalModel.dart';
import 'package:ashmall/Model/OneProductModel.dart';
import 'package:ashmall/Model/Product2Model.dart';
import 'package:ashmall/Model/ProductRateModel.dart';
import 'package:ashmall/Model/ProductSpecificationModel.dart';
import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Screens/CustomSearchAppBar.dart';
import 'package:ashmall/Screens/Reviews.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'CustRate.dart';
import 'ProductQuestion.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:image_picker/image_picker.dart';
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
  List<ProductColorModel>colorList=[];
  List<ProductSizeModel>sizeList=[];
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    data=await productServices.getProductDetails(prefs.getString("lang"), this.id);
    Specification=await productServices.GesProductSpefication(prefs.getString("lang"), this.id);
    colorList=await productServices.getProductColor(prefs.getString("lang"), this.id);
    sizeList=await productServices.getProductSize(prefs.getString("lang"), this.id);
    setState(() {
      lang=prefs.getString("lang");
      user_id=prefs.getString("id");
      token=prefs.getString("token");
    });
    print(data);
    print("sssssssssss");
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
   return SafeArea(
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
             CustomSearchAppBar(),
             //SizedBox(height: MediaQuery.of(context).size.height*.015,),
             Container(
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
             ),
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
                           Text(data["offerPrice"].toString(),style: TextStyle(color: Color(h.mainColor),),),
                           SizedBox(width: 10,),
                           Text(data["price"].toString(),style: TextStyle(decoration: TextDecoration.lineThrough),),

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
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [
                           GestureDetector(
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
                           SizedBox(width: 10,),
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
                           SizedBox(width: 10,),
                           GestureDetector(
                             onTap: (){
                               Navigator.push(context, GlobalFunction.route(ProductQuestion(data["id"],this.name)));
                             },
                             child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Icon(Icons.question_answer,color: Color(h.mainColor),)),
                           ),
                           SizedBox(width: 10,),
                           GestureDetector(
                             onTap: (){
                               Navigator.push(context, GlobalFunction.route(Reviews(data["id"],this.name)));
                             },
                             child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Icon(Icons.rate_review,color: Color(h.mainColor),)),
                           ),
                           SizedBox(width: 10,),
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
                           ):SizedBox(),
                         ],
                       ),
                       GestureDetector(
                           onTap: (){
                             user_id==null?print("0000"):SetRate(context,data["id"]);
                           },
                           child: CustomRate(data["rate"],15))
                     ],
                   )
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
            Container(height: 1,width: MediaQuery.of(context).size.width,color: Colors.black38,),
             SizedBox(height: MediaQuery.of(context).size.height*.005,),
            data["productSpeceficationVMs"].length==0? Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width*.065),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Image.asset("images/logo.png",
                      width:MediaQuery.of(context).size.width*.5
                  ),
                  SizedBox(height: 15,),
                  Text("No Specidication For This Product",style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold),)
                ],
              )
            ):
            Expanded(
               child: Container(
                 width: MediaQuery.of(context).size.width*.9,
                 padding: EdgeInsets.only(
                   top: 7
                 ),

                 child: ListView.builder(
                     padding: EdgeInsets.only(
                       //left: MediaQuery.of(context).size.width*.05,
                      // right: MediaQuery.of(context).size.width*.05,
                     ),
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
                             Text(Specification[index].speceficationKey),
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
             )

           ],
         ),

     ):Center(child: CircularProgressIndicator(),),
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
  void ProductDetail(List<ProductColorModel>colors,List<ProductSizeModel>size,String image,String name) {
    var SizeValue=sizeList[0].id;
    var SelectedColor=colors[0].id;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return  Container(
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
                                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                Text(name,style: TextStyle(fontSize: 16,color: Colors.black54),),
                                SizedBox(height: MediaQuery.of(context).size.height*.01,),
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
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(scrollDirection: Axis.vertical,shrinkWrap: true,primary: false,itemCount: sizeList.length,itemBuilder: (context,index){
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
                                    Text("Add To Cart ",style: TextStyle(color:Colors.white,fontSize: 13),),
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
                                "quantity":1,
                                "ColorId":SelectedColor,
                                "ProductSizeId":SizeValue
                              });
                              try
                              {
                                await dbHelper.addToCart(p1);
                                print("en tyy");
                                addProductDialog(context,"Product  Added To Shopping Cart", Container(
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
                                print('${e},,,,,,errorro addd');
                                addProductDialog(context,"Product Has Been Added Before ", Container(
                                  padding: EdgeInsets.only(top: 13),
                                  child: Icon(Icons.error,size: 50,color: Color(h.mainColor),),
                                ),);
                                Timer(Duration(seconds: 2), (){
                                  Navigator.pushNamedAndRemoveUntil(context, "/Cart", (route) => false);;
                                  // Phoenix.rebirth(context);
                                });
                              }
                            },
                          ),
                          SizedBox(height: 20,)
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
    var profileImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = profileImage;
    });

  }

}