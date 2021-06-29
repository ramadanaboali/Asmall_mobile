import 'package:ashmall/utils/app_Localization.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustomAppBar.dart';
import '../main.dart';


class Notifications extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State <Notifications>{
  home h=new home();
  var lang;
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      lang=prefs.getString("lang");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: (){
        Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
      },
      child: SafeArea(child: Scaffold(
        body:Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: Icon(ParentPage.language=="ar"?Icons.arrow_forward_ios_rounded:Icons.arrow_back_ios_rounded,color: Colors.white,size: 25,)),
                      Text(DemoLocalizations.of(context).title["Notifications"],style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                      GestureDetector(
                          onTap: (){
                          //  Navigator.pushNamedAndRemoveUntil(context, "/notification", (route) => false);
                          },
                          child: Icon(Icons.notifications,color: Colors.white,size: 25,))
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*.035,
                          right: MediaQuery.of(context).size.width*.035,
                          top: MediaQuery.of(context).size.height*.02
                      ),
                      //height: MediaQuery.of(context).size.height*.8,
                      child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context,index){
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height*.01,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.black12,width: 1.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width*.04,
                                  right: MediaQuery.of(context).size.width*.04,
                                  top: MediaQuery.of(context).size.height*.0135,
                                  bottom: MediaQuery.of(context).size.height*.0135
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text("20-10-2020   02:50 AM",style: TextStyle(color: Colors.black45,height: .99,fontSize: 9),),
                                      ],
                                    )
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(1000)),
                                            color: Color(h.mainColor)
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Icon(Icons.notifications_none_outlined,color: Colors.white,size: 18,),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Notification Title",style: TextStyle(fontSize: 12,color: Colors.black54),),
                                          Text("one line description of notifiction",style: TextStyle(fontSize: 10,color: Colors.black54),),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          })),
                )
              ],
            ),
          ),



      )),
    );
  }
}