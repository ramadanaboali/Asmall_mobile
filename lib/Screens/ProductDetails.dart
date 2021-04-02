import 'package:ashmall/DbHelper.dart';
import 'package:ashmall/GlobalFunction.dart';
import 'package:ashmall/Model/CartModelLocal.dart';
import 'package:ashmall/Model/FavouriteLocalModel.dart';
import 'package:ashmall/Model/OneProductModel.dart';
import 'package:ashmall/Model/ProductRateModel.dart';
import 'package:ashmall/Model/ProductSpecificationModel.dart';
import 'package:ashmall/Screens/CustomAppBar.dart';
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
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    data=await productServices.getProductDetails(prefs.getString("lang"), this.id);
    Specification=await productServices.GesProductSpefication(prefs.getString("lang"), this.id);
    setState(() {
      lang=prefs.getString("lang");
      user_id=prefs.getString("id");
      token=prefs.getString("token");
    });

    print(Specification);
    print("wwwwwwwwwwwwwwwwwww");
  }
  home h=new home();
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
             CustomAppBar(this.name),
             SizedBox(height: MediaQuery.of(context).size.height*.015,),
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
                               CartMedelLocal p1=new CartMedelLocal({
                                 "id":data["id"].toString(),
                                 "name":data["name"],
                                 "img":data["imagesPaths"][0],
                                 "description":data["description"],
                                 "price":double.parse(data["offerPrice"].toString()),
                                 "totalPrice":double.parse(data["offerPrice"].toString()),
                                 "quantity":1
                               });
                               try
                               {
                                 await dbHelper.addToCart(p1);
                                 Toast.show(
                                     "Product has Been Added To Shopping Cart", context,
                                     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                 Navigator.pop(context);
                               }
                               catch(e)
                               {
                                 print('${e},,,,,,errorro addd');
                                 Toast.show(
                                     "Product Has Been Added Before", context,
                                     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                 Navigator.pushNamed(context, '/Cart');
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
            data["productSpeceficationDtos"].length==0? Container(
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
            height: 170.0,
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
                      }
                    },
                  ),
                  SizedBox(height: 8,),
                ],
              ),


            ],),
          ),
        ));
  }
}