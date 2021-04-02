import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DbHelper.dart';
import '../Model/FavouriteLocalModel.dart';
import '../main.dart';



class Favourite extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Favourite>{
  home h=new home();
  DbHelper db=new DbHelper();
  List  dataLocal=[];
  loadData()async{
    dataLocal=await db.allFavorite();
    setState(() {
    });
    print(dataLocal.length.toString());
    print("ssssssssssss");
  }
  @override
  void initState() {
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              CustomAppBar(DemoLocalizations.of(context).title["wishlist"],),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * .02,),
              dataLocal.length == 0 ? Expanded(
                  child: Container(
                      padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.15),child: Center(
                    child: Column(
                      children: [
                        Image.asset("images/star.png",color: Colors.black26),
                        SizedBox(height: MediaQuery.of(context).size.height*.035,),
                        Text(DemoLocalizations.of(context).title["NoItemsInFavourite"],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26),),
                        SizedBox(height: MediaQuery.of(context).size.height*.035,),
                        GestureDetector(
                            onTap: (){
                              Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                            },
                          child: DottedBorder(
                              color: Colors.black26,
                              strokeWidth: 1.5,
                              child: Container(
                                width: MediaQuery.of(context).size.width*.6,
                                height: MediaQuery.of(context).size.height*.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  //  border: Border.all(width: 1.0,color: Colors.black26)
                                ),
                                child: Text(DemoLocalizations.of(context).title["ShppingNow"],style: TextStyle(fontSize: 12),),
                              )

                          ),
                        )
                      ],
                    ),
                  ))
              ) : Expanded(
                child: Container(
                    padding: EdgeInsets.only(
                      //left: MediaQuery.of(context).size.width*.035,
                      //right: MediaQuery.of(context).size.width*.035,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey.withOpacity(0.25),
                    ),
                    child: FutureBuilder(
                        future: db.allFavorite(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }


                          else {
                            return ListView.builder(
                              shrinkWrap: false,
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                FavoriteModelLocal c = new FavoriteModelLocal
                                    .fromMap(snapshot.data[index]);
                                //totalquantity+=int.parse(c.quantity.toString());
                                //allPrice+=double.parse(c.totalPrice.toString());
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * .12,
                                  margin: EdgeInsets.only(
                                      bottom: MediaQuery
                                          .of(context)
                                          .size
                                          .height * .01,
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .03,
                                      right: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .03
                                  ),
                                  padding: EdgeInsets.only(
                                    right: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .02,
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(GlobalVariable.URl+c.img,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * .25,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * .12,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .02,),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * .65,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * .014,
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * .014
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(c.title, style: TextStyle(
                                                      height: 1.2,
                                                      color: Color(h.mainColor),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .bold),),

                                                  GestureDetector(
                                                    onTap: (){
                                                      DeleteFromFavorite(context,c.id);
                                                    },
                                                    child: Icon(Icons.favorite,
                                                      color: Color(h.mainColor),),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * .014
                                              ),
                                              child: Text(c.description,
                                                style: TextStyle(height: 1.2,
                                                    fontSize: 10,
                                                    color: Colors.black38),
                                                maxLines: 2,
                                              ),
                                            ),

                                          ],),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }


                    )


                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  DeleteFromFavorite(BuildContext context,id) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            height: 110.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12,width: 2.0)
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center
                ,crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(alignment: Alignment.center,child: Text("تـأكيد الحذف من المفضلة",textAlign: TextAlign.center,)),
                  SizedBox(height: 25,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(

                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:Colors.blue
                            ),
                            height: MediaQuery.of(context).size.height*.035,
                            width: MediaQuery.of(context).size.width*.27,
                            alignment: Alignment.center,
                            child:   Text( "الغاء",style: TextStyle(color:Colors.white,fontSize: 8),),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:Color(h.mainColor)
                            ),
                            height: MediaQuery.of(context).size.height*.035,
                            width: MediaQuery.of(context).size.width*.27,
                            alignment: Alignment.center,
                            child:   Text("تـأكيد",style: TextStyle(color:Colors.white,fontSize: 8),),
                          ),
                          onTap: () async {
                            setState(() {
                              db.deleteFavorite(id);
                            });
                            Navigator.pop(context);
                          },
                        ),

                      ],
                    ),
                  )
                ],
              ),


            ],),
          ),
        ));
  }
}