import 'package:ashmall/GlobalFunction.dart';
import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Model/VendorModel.dart';
import 'package:ashmall/Screens/CustRate.dart';
import 'package:ashmall/Screens/CustomSearchAppBar.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../main.dart';
import 'Chat.dart';
import 'CustomText.dart';
import 'ProductDetails.dart';
import 'VendorCategory.dart';

class Store extends StatefulWidget{
  var id;
  Store(var id){
    this.id=id;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.id);
  }
}
class _state extends State<Store>{
  var id;
  _state(var id){
    this.id=id;
  }
  int indexContent=0;
  home h=new home();
  List <ProductDetail>data;
  List<ProductDetail>lastAdded;
  List<VendorGallary>gallary;
  Map<String,dynamic>responce;
  List<SubCategoryVm>vendorCategory;
ProductServices productServices=new ProductServices();
Map<String,dynamic>followerStatus;
bool disableFollow=true;
var user_id;
loadData()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  responce=await productServices.getvendorData(prefs.getString("lang"), id);
  data=await productServices.getVendorProduct(prefs.getString("lang"), id);
  lastAdded=await productServices.getVendorLastAdded(prefs.getString("lang"), id);
  gallary=await productServices.getVendorGallery(prefs.getString("lang"), id);
  vendorCategory=await productServices.getVendorGategory(prefs.getString("lang"), id);
  setState(() {
  });
 if(prefs.getString("id")!=null){
   followerStatus=await productServices.getFollowStatus(prefs.getString("lang"), prefs.getString("token"), id, prefs.getString("id"));
 }
  setState(() {
    disableFollow=true;
    user_id=prefs.getString("id");
  });
  print(vendorCategory.length);
  print("*************************");
}
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController1.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
 if(responce["data"]["video"]!=null){
   _videoPlayerController1 = VideoPlayerController.network(GlobalVariable.URL2+responce["data"]["video"]);
   _chewieController = ChewieController(
       videoPlayerController: _videoPlayerController1,
       autoPlay: true,
       aspectRatio: 3.8 / 3,
       looping: false,
       allowPlaybackSpeedChanging: false,
       allowedScreenSleep: true
   );
 }
  List content=[
    gallary==null?SizedBox(): Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.02,),
            Container(
              height: MediaQuery.of(context).size.height*.21,
              width: MediaQuery.of(context).size.width*.9 ,
              color: Colors.white,
              child:  new Swiper(
                itemBuilder: (BuildContext context,int index){
                  return  Container(
                    height: MediaQuery.of(context).size.height*.21,
                    width: MediaQuery.of(context).size.width*.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(GlobalVariable.URl+gallary[index].image,fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height*.13,
                        width: MediaQuery.of(context).size.width*.9,
                      ),
                    ),
                  );
                },
                autoplay: true,
                itemCount: gallary.length,
                pagination: new SwiperPagination(
                  margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*.4),
                  builder: new DotSwiperPaginationBuilder(
                    color: Colors.black, activeColor: Color(h.mainColor),
                  ),

                ),
                control: new SwiperControl(
                    color: Colors.white,
                    size: 0
                ),
              ),
            ),
            responce["data"]["video"]!=null?Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.2,
                    right: MediaQuery.of(context).size.width*.05,
                    left: MediaQuery.of(context).size.width*.05
                ),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Chewie(
                          controller: _chewieController,
                        ),
                      ),
                    ),
                  ],
                )):SizedBox()
          ],
        ),
      ),
    ),
    data==null?Expanded(child:Center(child: CircularProgressIndicator()),):
    Expanded(child: GridView.builder(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width*.05,
          right: MediaQuery.of(context).size.width*.05
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: data.length,
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
            Navigator.push(context, GlobalFunction.route(ProductDetails(data[index].id,data[index].name)));
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
                      child: Image.network(GlobalVariable.URl+data[index].coverPhoto,
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
                                  child:Text(data[index].name,maxLines: 1,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),

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
                                  CustomText.CustomText10(data[index].offerPrice.toString()+"  "+DemoLocalizations.of(context).title["le"]),
                                  SizedBox(width: 7,),
                                  Container(
                                    height: 7,
                                    padding: EdgeInsets.only(
                                      //left: 5,right: 5
                                    ),
                                    child: CustomRate(data[index].rate.round(),10),
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
    ),),
    lastAdded==null?Expanded(child:Center(child: CircularProgressIndicator()),):
    Expanded(child: GridView.builder(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width*.05,
          right: MediaQuery.of(context).size.width*.05
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: lastAdded.length,
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
            Navigator.push(context, GlobalFunction.route(ProductDetails(lastAdded[index].id,lastAdded[index].name)));
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
                      child: Image.network(GlobalVariable.URl+lastAdded[index].coverPhoto,
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
                                  child:Text(lastAdded[index].name,maxLines: 1,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),

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
                                  CustomText.CustomText10(lastAdded[index].offerPrice.toString()+"  "+DemoLocalizations.of(context).title["le"]),
                                  SizedBox(width: 7,),
                                  Container(
                                    height: 7,
                                    padding: EdgeInsets.only(
                                      //left: 5,right: 5
                                    ),
                                    child: CustomRate(lastAdded[index].rate.round(),10),
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
    ),),
  ];
   return /*WillPopScope(
     onWillPop: (){
       _chewieController.dispose();
       _videoPlayerController1.dispose();
     },*/
     SafeArea(
       child: Scaffold(
         backgroundColor: Colors.white,
         body: gallary==null||lastAdded==null||vendorCategory==null||responce==null||data==null?Center(child: CircularProgressIndicator()):Container(
           height: MediaQuery.of(context).size.height,
           child: Column(
             children: [
               CustomSearchAppBar(),
               Container(
                 padding: EdgeInsets.only(
                   left: MediaQuery.of(context).size.width*.05,
                   right: MediaQuery.of(context).size.width*.05,
                 ),
                 child: Row(
                   children: [
                     ClipRRect(
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                       child: Image.network(GlobalVariable.URl+responce["data"]["photo"],
                       height: MediaQuery.of(context).size.width*.2,
                       width: MediaQuery.of(context).size.width*.2,
                         fit: BoxFit.fill,
                       ),
                     ),
                     SizedBox(width: 10,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                       Container(
                         width: MediaQuery.of(context).size.width*.7-10,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               children: [
                                 Container(
                                     width: MediaQuery.of(context).size.width*.4,
                                     child: Text(responce["data"]["name"],style: TextStyle(fontSize: 13,height: 1.3),maxLines: 1,)),
                                 SizedBox(width: 5,),
                                 responce["data"]["credibility"]==true?Icon(Icons.check_circle_outline,color: Colors.green,size: 18,):SizedBox()
                               ],
                             ),
                             user_id!=null? GestureDetector(
                               onTap: ()async{
                                 setState(() {
                                   disableFollow=false;
                                 });
                                    SharedPreferences pref=await SharedPreferences.getInstance();
                                    if(followerStatus["data"]==true){
                                      productServices.deleteFollower(pref.getString("lang"), pref.getString("token"), id, pref.getString("id"));
                                       print("Unfollowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
                                    }
                                    else{
                                      productServices.addFollowers(pref.getString("lang"), pref.getString("token"), id, pref.getString("id"));
                                      print("followwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
                                    }
                                    loadData();

                               },
                               child: Container(
                                 width: MediaQuery.of(context).size.width*.2,
                                 height: MediaQuery.of(context).size.height*.03,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.all(Radius.circular(5)),
                                     color: disableFollow==false?Colors.black38:Color(h.mainColor)
                                 ),
                                 alignment: Alignment.center,
                                 child: Text(followerStatus["data"]==true?"Un Follow":"Follow",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
                               ),
                             ):SizedBox(),
                           ],
                         ),
                       ),
                         Container(
                           width: MediaQuery.of(context).size.width*.7-10,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                   width: MediaQuery.of(context).size.width*.44,
                                   child: Text(responce["data"]["email"],maxLines: 1,style: TextStyle(fontSize: 10,height: 1.3),)),
                             Text("Followers : ${responce["data"]["numbersOfFollowers"]}",style: TextStyle(fontSize: 12,height: 1.5),),
                             ],
                           ),
                         ),
                         Container(
                           width: MediaQuery.of(context).size.width*.7-10,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                width: MediaQuery.of(context).size.width*.4  ,
                                   child: Text(responce["data"]["phone"],style: TextStyle(fontSize: 10,height: 1.3),)),
                               CustomRate(int.parse(responce["data"]["rate"].toString()), 15),
                             ],
                           ),
                         ),
                       ],
                     )
                   ],
                 ),
               ),
              /* SizedBox(height: 8,),
               Container(
                   width: MediaQuery.of(context).size.width*.94,
                   height: MediaQuery.of(context).size.height*.04,
                   alignment: Alignment.centerLeft,
                   padding: EdgeInsets.only(left: 0,right: 0),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     //color: Color(h.redColor)
                   ),
                   child: Row(
                     children: [
                       Text(DemoLocalizations.of(context).title["lastAdded"],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                     ],
                   )
               ),*/
               SizedBox(height: 7,),
               Container(
                 height: MediaQuery.of(context).size.height*.04,
                 width: MediaQuery.of(context).size.width*.9,
                 decoration: BoxDecoration(
                   color: Colors.white,
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     GestureDetector(
                       onTap: (){
                         setState(() {
                           indexContent=0;
                         });
                       },
                       child: Container(
                         height: MediaQuery.of(context).size.height*.04,
                         width: MediaQuery.of(context).size.width*.27,
                         decoration: BoxDecoration(
                              border: Border(
                                 bottom: BorderSide(
                                   color:indexContent==0?Color(h.mainColor):Colors.white,
                                   width: 1.5,
                                 )),
                             color: Colors.white
                         ),
                         alignment: Alignment.center,
                         child: Text("Home",style: TextStyle(color: Colors.black)),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                          _chewieController.dispose();
                         _videoPlayerController1.dispose();
                         setState(() {
                           indexContent=1;
                         });
                       },
                       child: Container(
                         height: MediaQuery.of(context).size.height*.04,
                         width: MediaQuery.of(context).size.width*.27,
                         decoration: BoxDecoration(
                            border: Border(
                               bottom: BorderSide(
                                 color:indexContent==1?Color(h.mainColor):Colors.white,
                                 width: 1.5,
                               )),
                             color: Colors.white
                         ),
                         alignment: Alignment.center,
                         child: Text("All Items",style: TextStyle(color: Colors.black)),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         _chewieController.dispose();
                         _videoPlayerController1.dispose();
                         setState(() {
                           indexContent=2;
                         });
                       },
                       child: Container(
                         height: MediaQuery.of(context).size.height*.04,
                         width: MediaQuery.of(context).size.width*.27,
                         decoration: BoxDecoration(
                              border: Border(
                                 bottom: BorderSide(
                                   color:indexContent==2?Color(h.mainColor):Colors.white,
                                   width: 1.5,
                                 )),
                             color: Colors.white
                         ),
                         alignment: Alignment.center,
                         child: Text("New Arrival",style: TextStyle(color: Colors.black),),
                       ),
                     )
                   ],
                 ),
               ),
               SizedBox(height: 7,),
               /*Container(
                 height:1,
                 width: MediaQuery.of(context).size.width,
                 color: Colors.black38,
               ),*/
               content[indexContent],
               Container(
                 height: MediaQuery.of(context).size.height*.055,
                 width: MediaQuery.of(context).size.width*.9,
                  decoration: BoxDecoration(

                  ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, GlobalFunction.route(VendorCategory(responce["data"]["id"],this.vendorCategory)));
                         _chewieController.dispose();
                         _videoPlayerController1.dispose();
                       },
                       child: Container(
                         height: MediaQuery.of(context).size.height*.05,
                         width: MediaQuery.of(context).size.width*.43,
                         decoration: BoxDecoration(
                             color: Color(h.mainColor),
                             borderRadius: BorderRadius.all(Radius.circular(5))
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                              ),
                              child: Icon(Icons.menu,color: Colors.white,size: 25,),
                            ),
                            SizedBox(height: 20,),
                            Text( DemoLocalizations.of(context).title["category"],style: TextStyle(color: Colors.white,height: 1.4,fontSize: 14,fontWeight: FontWeight.bold),)
                          ],
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, GlobalFunction.route(Chat()));
                         _chewieController.dispose();
                         _videoPlayerController1.dispose();
                       },
                       child: Container(
                         height: MediaQuery.of(context).size.height*.05,
                         width: MediaQuery.of(context).size.width*.43,
                         decoration: BoxDecoration(
                             color: Color(h.mainColor),
                             borderRadius: BorderRadius.all(Radius.circular(5))
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Container(
                               padding: EdgeInsets.all(6),
                               decoration: BoxDecoration(
                               ),
                               child: Icon(Icons.chat,color: Colors.white,size: 25,),
                             ),
                             SizedBox(height: 20,),
                             Text("Chat",style: TextStyle(color: Colors.white,height: 1.4,fontSize: 14,fontWeight: FontWeight.bold),)
                           ],
                         ),
                       ),
                     )
                   ],
                 ),
               ),
               SizedBox(height: 7,),

             ],
           ),
         )
       ),
     );
  }
}