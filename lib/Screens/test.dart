import 'package:ashmool/Model/ProductModel.dart';
import 'package:ashmool/Screens/CustRate.dart';
import 'package:ashmool/Services/GlobalVarible.dart';
import 'package:ashmool/Services/ProductServices.dart';
import 'package:ashmool/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Test extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Test>{
  TextEditingController searchKey=new TextEditingController();
  home h=new home();
  List <ProductDetail>BestList=[];
  List <ProductDetail>OffersList=[];
  List <ProductDetail>LastList=[];
  ProductServices productServices=new ProductServices();
  loadData()async{
    SharedPreferences  Prefs=await SharedPreferences.getInstance();
    BestList=await productServices.getBestSeller("en", Prefs.getString("token"));
    OffersList=await productServices.getOffers("en", Prefs.getString("token"));
    LastList=await productServices.getlastAdd("en", Prefs.getString("token"));
    setState(() {
    });
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
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: Color(0xffff7db4),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.05,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  height: MediaQuery.of(context).size.height*.05,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    onTap: (){
                      Navigator.pushNamed(context, "/Search");
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
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Container(
                  height: MediaQuery.of(context).size.height*.13,
                  width: MediaQuery.of(context).size.width*.9,
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
                          Navigator.pushNamed(context, "/Category");
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
                              Text("Categories",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width*.2,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white
                              ),
                              child: Icon(Icons.favorite,color: Colors.red,size: 35,),
                            ),
                            SizedBox(height: 8,),
                            Text("Wish List",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width*.2,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.green
                              ),
                              child: Icon(Icons.ac_unit,color: Colors.white,size: 35,),
                            ),
                            SizedBox(height: 8,),
                            Text("Best Seller",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width*.2,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.green
                              ),
                              child: Icon(Icons.ac_unit,color: Colors.white,size: 35,),
                            ),
                            SizedBox(height: 8,),
                            Text("Offers",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width*.2,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.green
                              ),
                              child: Icon(Icons.ac_unit,color: Colors.white,size: 35,),
                            ),
                            SizedBox(height: 8,),
                            Text("Last Added",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),

                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*.94,
                  height: MediaQuery.of(context).size.height*.06,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(h.redColor)
                  ),
                  child: Text("Best Seller",style: TextStyle(color: Colors.white),),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  height: MediaQuery.of(context).size.height*.2,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: BestList.length,
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.03),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(
                            left: 10
                        ),
                        height: MediaQuery.of(context).size.height*.2,
                        width: MediaQuery.of(context).size.width*.25,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)
                                ),
                                child: Image.network(GlobalVariable.URl+BestList[index].coverPhoto,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 4,),
                            Container( padding: EdgeInsets.only(
                                left: 5,right: 5
                            ),child: Text(BestList[index].name,style: TextStyle(fontSize: 10),maxLines: 1,)),
                            SizedBox(height: 2,),
                            Container(
                              width: MediaQuery.of(context).size.width*.22,
                              height: 13,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(BestList[index].price.toString(),style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold)),
                                  SizedBox(width: 7,),
                                  Container(
                                    width: 35,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Color(h.redColor)
                                    ),
                                    child: Text("-${BestList[index].offerPrice}%",style: TextStyle(fontSize: 9,color: Colors.white,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 2,),
                            Container(
                              height: 7,
                              padding: EdgeInsets.only(
                                  left: 5,right: 5
                              ),
                              child: CustomRate(BestList[index].rate,11),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                Container(
                  width: MediaQuery.of(context).size.width*.94,
                  height: MediaQuery.of(context).size.height*.06,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(h.redColor)
                  ),
                  child: Text("Offers",style: TextStyle(color: Colors.white),),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  height: MediaQuery.of(context).size.height*.2,
                  width: MediaQuery.of(context).size.width,
                  child:ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: OffersList.length,
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.03),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(
                            left: 10
                        ),
                        height: MediaQuery.of(context).size.height*.2,
                        width: MediaQuery.of(context).size.width*.25,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)
                                ),
                                child: Image.network(GlobalVariable.URl+OffersList[index].coverPhoto,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 4,),
                            Container( padding: EdgeInsets.only(
                                left: 5,right: 5
                            ),child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(OffersList[index].name,style: TextStyle(fontSize: 10),maxLines: 1,textAlign: TextAlign.start,)
                              ],
                            )),
                            SizedBox(height: 2,),
                            Container(
                              width: MediaQuery.of(context).size.width*.22,
                              height: 13,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(OffersList[index].price.toString(),style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold)),
                                  SizedBox(width: 7,),
                                  Container(
                                    width: 35,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Color(h.redColor)
                                    ),
                                    child: Text("-${OffersList[index].offerPrice}%",style: TextStyle(fontSize: 9,color: Colors.white,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 2,),
                            Container(
                                height: 7,
                                padding: EdgeInsets.only(
                                    left: 5,right: 5
                                ),
                                child: CustomRate(OffersList[index].rate,11)
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      );
                    },
                  )
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                Container(
                  width: MediaQuery.of(context).size.width*.94,
                  height: MediaQuery.of(context).size.height*.06,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(h.redColor)
                  ),
                  child: Text("Last Added",style: TextStyle(color: Colors.white),),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
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
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1/1.3
                    ),
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(
                        ),
                        height: MediaQuery.of(context).size.height*.2,
                        width: MediaQuery.of(context).size.width*.25,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)
                                ),
                                child: Image.network(GlobalVariable.URl+LastList[index].coverPhoto,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 4,),
                            Container(
                                padding: EdgeInsets.only(left: 5,right: 5),
                                child: Text(LastList[index].name,style: TextStyle(fontSize: 10),maxLines: 1,)),
                            SizedBox(height: 2,),
                            Container(

                              height: 13,
                              padding: EdgeInsets.only(left: 5,right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(LastList[index].price.toString(),style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold)),
                                  SizedBox(width: 7,),
                                  Container(
                                    width: 35,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Color(h.redColor)
                                    ),
                                    child: Text("-${LastList[index].offerPrice}%",style: TextStyle(fontSize: 9,color: Colors.white,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 2,),
                            Container(
                                height: 7,
                                padding: EdgeInsets.only(
                                    left: 5,right: 5
                                ),
                                child: CustomRate(LastList[index].rate,11),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),

          ),

        ),
      ),
    );
  }
}