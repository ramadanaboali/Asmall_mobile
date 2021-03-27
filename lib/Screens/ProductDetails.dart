import 'package:ashmool/DbHelper.dart';
import 'package:ashmool/GlobalFunction.dart';
import 'package:ashmool/Model/CartModelLocal.dart';
import 'package:ashmool/Model/FavouriteLocalModel.dart';
import 'package:ashmool/Model/OneProductModel.dart';
import 'package:ashmool/Model/ProductRateModel.dart';
import 'package:ashmool/Services/GlobalVarible.dart';
import 'package:ashmool/Services/ProductServices.dart';
import 'package:ashmool/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:toast/toast.dart';

import 'CustRate.dart';
import 'ProductQuestion.dart';

class ProductDetails extends StatefulWidget{
  var id;
  ProductDetails(var id){
    this.id=id;
  }
  @override
  State<StatefulWidget> createState() {
return _state(this.id);
  }
}
class  _state extends State<ProductDetails>{
  var id;
  DbHelper dbHelper=new DbHelper();
  _state(var id){
    this.id=id;
  }
  ProductServices productServices=new ProductServices();
  Map<String,dynamic>data;
  List<String>Images=[];
  List<ProductRateDetail>rate=[];
  loadData() async {
    data=await productServices.getProductDetails("en", this.id);
    rate=await productServices.getProductRate("en", this.id);
    setState(() {
    });
    print(rate.length);
   // print(data);
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
     body: data!=null?Container(
       child:  Column(
           children: [
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
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
             ),
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
                                 child: Icon(Icons.add_shopping_cart)),
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
                               Navigator.push(context, GlobalFunction.route(ProductQuestion()));
                             },
                             child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Icon(Icons.question_answer)),
                           ),
                         ],
                       ),
                       CustomRate(data["rate"],15)
                     ],
                   )
                 ],
               ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.01,),
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
               child: Text("Reviews",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color: Colors.white),),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.01,),
            rate.length==0? Expanded(child: Center(child: Text("No Reviews"),),):
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
                                    child: rate[index].userPhoto==null?Icon(Icons.person,):Image.network(GlobalVariable.URl+rate[index].userPhoto)),
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
                       Container(
                         width: MediaQuery.of(context).size.width*.75,
                         child: Text(rate[index].comment,
                         maxLines: 3,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
                       ),
                       SizedBox(height: 8,),
                     ],
                   ),
                 );
               }),
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
}