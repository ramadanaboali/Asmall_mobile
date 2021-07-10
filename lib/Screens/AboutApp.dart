import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }

}
class _state extends State<AboutApp>{
  String txt="s";
  Map<String,dynamic>data;
  home h=new home();
  ProductServices productServices=new ProductServices();
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    data=await productServices.getSetting(prefs.getString("lang"));
    setState((){});
    print(data);
    print("sssssssssssssssssss");
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
      body: SingleChildScrollView(
        child: data==null?Container(
            height: MediaQuery.of(context).size.height*.9,
            child: Center(child: CircularProgressIndicator(),)):Container(
          child: Column(
            children: [
              CustomAppBar("عن التطبيق"),
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              Image.asset("images/logo.png",
                width: MediaQuery.of(context).size.width*.55,
                color: Color(h.mainColor),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              Container(height: 1.5,width: MediaQuery.of(context).size.width*.94,color: Colors.black54,),
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                 left: MediaQuery.of(context).size.width*.07,
                  right: MediaQuery.of(context).size.width*.07
                ),
                child: Text(data["data"]["aboutApplication"],style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: (){
                          ShareUrl(data["data"]["twitterLink"]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            color: Color(h.mainColor)
                          ),
                            padding: EdgeInsets.all(3),
                            child: ImageIcon(AssetImage("images/icon/twitter.png"),size: 35,color: Colors.white,))),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        ShareUrl(data["data"]["whatsappLink"]);
                      },
                      child:Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              color: Color(h.mainColor)
                          ),
                          padding: EdgeInsets.all(3),
                          child: ImageIcon(AssetImage("images/icon/whats.png"),size: 35,color: Colors.white,)),),
                    SizedBox(width: 10,),
                    GestureDetector(
                        onTap: (){
                          ShareUrl(data["data"]["instgramLink"]);
                        },child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            color: Color(h.mainColor)
                        ),
                        padding: EdgeInsets.all(3),
                        child: ImageIcon(AssetImage("images/icon/inst.png"),size: 35,color: Colors.white,))),
               /*     SizedBox(width: 10,),
                    GestureDetector(
                        onTap: (){
                          ShareUrl(data["data"]["snapchat"]);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                color: Color(h.mainColor)
                            ),
                            padding: EdgeInsets.all(3),
                            child: ImageIcon(AssetImage("images/icon/snap.png"),size: 35,color: Colors.white,))),*/
                    SizedBox(width: 10,),
                    GestureDetector(
                        onTap: (){
                          ShareUrl(data["data"]["facebookLink"]);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                color: Color(h.mainColor)
                            ),
                            padding: EdgeInsets.all(3),
                            child: ImageIcon(AssetImage("images/icon/face.png"),size: 35,color: Colors.white,))),
                  ],
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    ));
  }
  ShareUrl(String url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}