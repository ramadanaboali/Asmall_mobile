import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'CustomText.dart';

class LangSetting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<LangSetting>{
  home h=new home();
  bool notifiction=true;
  int type;
  setData(String key,String value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  clearData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("lang");
  }
  String language;
  loadData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language=prefs.get('lang');
    });
    print(language);
    print("sssssssssssssssssss");
    if(language=="ar")
    {
      print("1");
      setState(() {
        type=1;
      });
    }
    else{
      print("2222222");
      setState(() {
        type=2;
      });
    }
    print(type);
    print("0000000000000000000");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Container(
            child: Column(
              children: [
                CustomAppBar(DemoLocalizations.of(context).title["langSetting"]),
                SizedBox(height: MediaQuery.of(context).size.height*.07,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*.8,
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color:type==2? Color(h.mainColor):Colors.white,),
                            SizedBox( width: MediaQuery.of(context).size.width*.02,),
                            GestureDetector(
                              onTap: (){
                                clearData();
                                setData('lang', 'en');
                                Phoenix.rebirth(context);
                                setState(() {
                                  type=2;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width*.7,
                                height: MediaQuery.of(context).size.height*.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.black12,width: 1),
                                  color: type==2?Color(h.mainColor):Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("English",style: TextStyle(color:type==2? Colors.white:Colors.black54,fontSize: 16),),
                                    SizedBox(width: MediaQuery.of(context).size.width*.1,),
                                    Image.asset("images/en.png",width: 35,height: 20,fit: BoxFit.cover,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width*.8,
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color:type==1? Color(h.mainColor):Colors.white,),
                            SizedBox( width: MediaQuery.of(context).size.width*.02,),
                            GestureDetector(
                              onTap: (){
                                clearData();
                                setData('lang', 'ar');
                                Phoenix.rebirth(context);
                                setState(() {
                                  type=1;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width*.7,
                                height: MediaQuery.of(context).size.height*.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.black12,width: 1),
                                  color: type==1?Color(h.mainColor):Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("عربي",style: TextStyle(fontSize: 16,color:type==1? Colors.white:Colors.black54),),
                                    SizedBox(width: MediaQuery.of(context).size.width*.18,),
                                    Image.asset("images/ar.png",width: 35,height: 20,fit: BoxFit.cover,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.1,)



              ],
            ),
          ),
        ),
      ),
    );
  }
}