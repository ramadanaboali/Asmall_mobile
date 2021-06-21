import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
class OrderSuccess extends StatefulWidget{
  int quantity;
  String order_id;
  double total;
  double tax;
  OrderSuccess(int quantity,String order_id,double totle,double tax){
    this.quantity=quantity;
    this.order_id=order_id;
    this.total=totle;
    this.tax=tax;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.quantity,this.order_id,this.total,this.tax);
  }
}
class _state extends State<OrderSuccess>{
  int quantity;
  String order_id;
  double total;
  double tax;
  _state(int quantity,String order_id,double totle,double tax){
    this.quantity=quantity;
    this.order_id=order_id;
    this.total=totle;
    this.tax=tax;
  }
  home h=new home();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width:  MediaQuery.of(context).size.width,
            child:Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.1,),
                Icon(Icons.check_circle,size: 150,color: Color(h.mainColor),),
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Text(DemoLocalizations.of(context).title["ordersuccess"],style: TextStyle(color: Color(h.mainColor),fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: MediaQuery.of(context).size.height*.025,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black12,width: 1),
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*.9,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                            color: Colors.grey.withOpacity(.3)
                        ),
                        alignment: Alignment.center,
                        child: Text(DemoLocalizations.of(context).title["BillDetail"],style:TextStyle(fontSize: 16),),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*.05,
                          right: MediaQuery.of(context).size.width*.05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(DemoLocalizations.of(context).title["totalquantity"],style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.3,
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(ParentPage.quantity.toString(),style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.3,
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(DemoLocalizations.of(context).title["Totalorders"],style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.3,
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(ParentPage.total.toString(),style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.3,
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.03,),
                Text(DemoLocalizations.of(context).title["total"]+  " ${ParentPage.total}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: MediaQuery.of(context).size.height*.03,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                          setState(() {
                            ParentPage.total=0.0;
                            ParentPage.quantity=0;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom:MediaQuery.of(context).size.height*.03),
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10),color: Color(h.mainColor),),
                          height: MediaQuery.of(context).size.height*.06,
                          width: MediaQuery.of(context).size.width*.43,
                          alignment: Alignment.center,
                          child:    Text(DemoLocalizations.of(context).title["home"],style: TextStyle(color:Colors.white,fontSize: 15),),

                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.pushNamedAndRemoveUntil(context, "/Orders", (route) => false);
                          setState(() {
                            ParentPage.total=0.0;
                            ParentPage.quantity=0;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom:MediaQuery.of(context).size.height*.03),
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10),color: Color(h.mainColor),),
                          height: MediaQuery.of(context).size.height*.06,
                          width: MediaQuery.of(context).size.width*.43,
                          alignment: Alignment.center,
                          child:    Text(DemoLocalizations.of(context).title["orders"],style: TextStyle(color:Colors.white,fontSize: 15),),

                        ),
                      ),
                    ],
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