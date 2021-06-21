import 'package:ashmall/Model/OrdersModel.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalFunction.dart';
import '../HomePage.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import '../main.dart';
import 'CustomAppBar.dart';

class Orders extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Orders>{
  List<String>Category=["InProcess","OnGoing","Delivered","Rejected"];
  List<OrdersDetail>data;
  ProductServices productServices=new ProductServices();
  var lang;
  loadData(String Status)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    data=await productServices.getAllOrders(prefs.getString("lang"), prefs.getString("id"),Status);
    setState(() {
      lang=prefs.getString("lang");
    });
    print(data.length);
    print("sssssssssssssss");
  }
  String SelectedCategory;
  home h=new home();
  int index=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SelectedCategory=Category[0];
    loadData(Category[0]);
  }
  @override
  Widget build(BuildContext context) {
    List<String>Category1=[DemoLocalizations.of(context).title["InProcess"],DemoLocalizations.of(context).title["OnGoing"],
      DemoLocalizations.of(context).title["Delivered"],DemoLocalizations.of(context).title["Rejected"]];
    List<Widget>content=[
      Expanded(child: ListView.builder(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height*.025,
              bottom: MediaQuery.of(context).size.height*.03
          ),
          itemCount: 10,itemBuilder: (context,index){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height*.12,
          margin: EdgeInsets.only(
              bottom:MediaQuery.of(context).size.height*.01,
              left: MediaQuery.of(context).size.width*.03,
              right:  MediaQuery.of(context).size.width*.03
          ),
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*.02,
          ),
          child: Row(
            children: [
              Image.asset("images/food.png",
                width: MediaQuery.of(context).size.width*.25,
                height: MediaQuery.of(context).size.height*.12,
                fit: BoxFit.cover,
              ),
              SizedBox(width:MediaQuery.of(context).size.width*.02,),
              Container(
                width: MediaQuery.of(context).size.width*.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.height*.005,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("وجبة عائلية",style: TextStyle(height: .7,color: Color(h.mainColor),fontSize: 17,fontWeight: FontWeight.bold),),
                        Row(children: [
                          Icon(Icons.bookmark,color: Colors.blue,),
                        ],)
                      ],
                    ),
                    Text("هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق،",
                      style: TextStyle(height: 1.0,fontSize: 11,color: Colors.black38),maxLines: 2,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height*.01,),
                  ],),
              )
            ],
          ),
        );
      })),
    ];
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: (){
        Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
      },
      child: SafeArea(child: Scaffold(
        body: Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*.07,
                  width: MediaQuery.of(context).size.width,
                  color: Color(h.mainColor),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 20,

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                          },
                          child: Icon(ParentPage.language=="en"?Icons.arrow_back_ios_rounded:Icons.arrow_forward_ios_rounded,color: Colors.white,size: 25,)),
                      Text(DemoLocalizations.of(context).title["Orders"],style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                      GestureDetector(
                          onTap: (){
                           // Navigator.pop(context);
                          },
                          child: Icon(Icons.notifications,color: Colors.white,size: 25,))
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Container(
                  height: MediaQuery.of(context).size.height*.055,
                  child: ListView.builder(
                    shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.05,
                        right: MediaQuery.of(context).size.width*.05,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: Category.length,
                      itemBuilder: (context,index)
                      {
                        return GestureDetector(
                          onTap: (){
                            loadData(Category[index]);
                            setState(() {
                              SelectedCategory=Category[index];
                            });
                          },
                          child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 100,
                                      alignment: Alignment.center,
                                      child: Text(Category1[index],maxLines:1,style: TextStyle(height: 1.5,color: SelectedCategory==Category[index]?Color(h.mainColor):Colors.black54,fontSize: 16,fontWeight: FontWeight.bold),)),
                                  SizedBox(height: 7,),
                                  SelectedCategory==Category[index]?  Container(height:2,color: Color(h.mainColor),
                                    width: 100,
                                  ):SizedBox()

                                ],
                              )        ),
                        );
                      }
                  ),
                ),
              data==null?Expanded(
                child: Container(
                    padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.1),child: Center(
                  child: CircularProgressIndicator(),
                )),
              ): data.length==0?
              Expanded(
                 child: Container(
                     padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.1),child: Center(
                   child: Column(
                     children: [
                       Image.asset("images/orders.png",color: Colors.black38,
                         height: MediaQuery.of(context).size.height*.25,
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*.035,),
                       Text(DemoLocalizations.of(context).title["noOrders"],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),),
                       SizedBox(height: MediaQuery.of(context).size.height*.035,),
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context, GlobalFunction.route(HomePage(0)));
                         },
                         child: DottedBorder(
                             color: Color(h.mainColor),
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
                 )),
               ):Expanded(child: ListView.builder(
                     padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*.0,
                         bottom: MediaQuery.of(context).size.height*.04
                    ),
                    itemCount: data.length,itemBuilder: (context,index){
                   return   Container(
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.03,right:  MediaQuery.of(context).size.width*.04,left:  MediaQuery.of(context).size.width*.04,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black12.withOpacity(.08),width: 1),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.03),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                            width:MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width*.05,
                              top: MediaQuery.of(context).size.height*.015,
                              bottom: MediaQuery.of(context).size.height*.015,
                              left: MediaQuery.of(context).size.width*.05,
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,

                                decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
                                  color: Color(h.mainColor),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                    Text(data[index].orderDate.toString().substring(0,10),style: TextStyle(color: Colors.white,height: .8,fontSize: 16,fontWeight: FontWeight.bold),),
                                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                  ],
                                ),
                              ),
                                Container(
                                  width:MediaQuery.of(context).size.width*.9,
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width*.05,
                                    top: MediaQuery.of(context).size.height*.01,
                                    // bottom: MediaQuery.of(context).size.height*.01,
                                    left: MediaQuery.of(context).size.width*.05,
                                  ),
                                  child: ListView.builder(
                                      itemCount: data[index].orderItems.length,
                                      primary: false,
                                      shrinkWrap: true,
                                      itemBuilder: (context,i){
                                        return Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*.75,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                   Row(
children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(GlobalVariable.URL2+data[index].orderItems[i].productCoverPhoto,
                                                    width: MediaQuery.of(context).size.width*.2,
                                                      height: MediaQuery.of(context).size.height*.06,
fit: BoxFit.fill,
                                                    ),
      ),
                                                  SizedBox(width: 5,),
                                                  Row(
                                                    children: [
                                                      Text(data[index].orderItems[i].productName,style: TextStyle(fontSize: 12,color: Colors.black54)),

                                                    ],
                                                  ),
],
                                                   ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),
                                                      border: Border.all(color: Color(h.mainColor),width: 1)
                                                    ),
                                                    padding: EdgeInsets.all(3),
                                                      child: Text(data[index].orderItems[i].quantity.toString(),style: TextStyle(fontSize: 12,color: Colors.black54))),
                                                  /*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*/
                                                  Text(data[index].orderItems[i].price.toString(),style: TextStyle(fontSize: 12,color: Colors.black54),),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 3,),
                                            i==data[index].orderItems.length-1?Column(
                                              children: [
                                                Divider(color: Colors.black38,thickness: 1,),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*.75,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Total",style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),),
                                                      /*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*/
                                                      Text(data[index].totalPrice.toString(),style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ):SizedBox()
                                          ],
                                        );
                                      }),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                              ],)
                        ),
                      ],
                    ),

                  ),
                  );
                }))
              ],
            ),
          ),

      )),
    );
  }
}