import 'package:ashmall/ScopeModel/AppSCoedModel.dart';
import 'package:ashmall/ScopeModel/Base_View.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class FirstLanguage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<FirstLanguage>{
  home h=new home();
  setData(String key,String value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  clearData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<AppModel>(builder:(context,child,model)=>Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.09,),
            Image.asset("images/logo.png",
              height: MediaQuery.of(context).size.height*.3,
              fit: BoxFit.cover,
              color: Color(h.mainColor),
            ),
            Expanded(child: SizedBox()),
            GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height*.06,
                  width: MediaQuery.of(context).size.width*.6,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*.04,
                  ),
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),color: Color(h.mainColor),
                  ),
                  child:   Text("English",style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),


                ),
                onTap:
                    (){
                  model.changeDirectionToEn();
                  // clearData();
                  setData('lang', 'en');
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/mainPage',
                          (Route<dynamic> route) => false);
                }
            ),
            GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height*.06,
                  width: MediaQuery.of(context).size.width*.6,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*.03,
                  ),
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),color:Color(h.mainColor),
                  ),
                  alignment: Alignment.center,
                  child:  Text("عربي",style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),

                ),
                onTap: (){
                  model.changeDirectionToArabic();
                  setData('lang', 'ar');
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/mainPage',
                          (Route<dynamic> route) => false);
                }
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.1,),
          ],
        ),
      ),
    ));
  }
}