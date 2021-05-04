import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsagePolices extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }

}
class _state extends State<UsagePolices>{
  String txt;
  home h=new home();
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    txt=prefs.getString("usage");
    setState((){});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        child: Column(
          children: [
            CustomAppBar("سياسة الاستخدام"),
            SizedBox(height: MediaQuery.of(context).size.height*.02,),
            Image.asset("images/logo.png",
              width: MediaQuery.of(context).size.width*.55,
              color: Color(h.mainColor),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.02,),
            Container(height: 1.5,width: MediaQuery.of(context).size.width*.94,color: Colors.black54,),
            SizedBox(height: MediaQuery.of(context).size.height*.02,),
            Container(
              width: MediaQuery.of(context).size.width*.9,
              child: Text(txt,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    ));
  }
}