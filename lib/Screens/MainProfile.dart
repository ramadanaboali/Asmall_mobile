import 'package:ashmall/Screens/CustomText.dart';
import 'package:ashmall/Screens/Login.dart';
import 'package:ashmall/Screens/Orders.dart';
import 'package:ashmall/Screens/ProfileSetting.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/UserServices.dart';
import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalFunction.dart';
import 'Favourite.dart';

class MainProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return _state();
  }
}
class _state extends State<MainProfile>{
  home h=new home();
  UserServices  userServices=new UserServices();
  Map<String,dynamic>data;
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();

      data=await userServices.getUserInfo(prefs.getString("lang"), prefs.getString("id"), prefs.getString("token"));
      setState(() {
      });
      print(data);
      print("ssssssssssss");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }
  @override
  Widget build(BuildContext context) {
    return ParentPage.user_id!=null?SafeArea(child:
    Scaffold(
      body: data==null?Center(child: CircularProgressIndicator(),):
      Container(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.015,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 10,),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.asset("images/ar.png",width: 30,height: 21,fit: BoxFit.fill,),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(ProfileSetting()));
                  },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.settings,size: 25,color: Colors.black54,)),
                ),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.015,),
            Container(
              width: MediaQuery.of(context).size.width*.94,
              padding: EdgeInsets.only(top: 3,bottom: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12,width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                    child:FadeInImage.assetNetwork(
                      placeholder: "images/user.jpg",
                      image:"http://"+data["data"]["photo"],
                      width: MediaQuery.of(context).size.width*.2,
                      height: MediaQuery.of(context).size.width*.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.TitleText(data["data"]["name"]==null?"":data["data"]["name"]),
                      CustomText.SubTitleText(data["data"]["email"]==null?"":data["data"]["email"]),
                      CustomText.SubTitleText(data["data"]["phone"]==null?"":data["data"]["phone"])
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.015,),
            Container(
              width: MediaQuery.of(context).size.width*.94,
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, GlobalFunction.route(Favourite()));
                    },
                    child: Column(
                      children: [
                        Icon(Icons.favorite_border,size: 35,),
                        CustomText.SubTitleText("Wish List")
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),

                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.015,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, GlobalFunction.route(Orders()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.94,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.TitleText("Orders"),
                    CustomText.SubTitleText("See All >>"),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.015,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, GlobalFunction.route(Orders()));
              },
              child: Container(
                //height: MediaQuery.of(context).size.height*.2,
                width: MediaQuery.of(context).size.width*.94,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black12,width: 1.0)
                ),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*.04,
                  right: MediaQuery.of(context).size.width*.04,
                  top: MediaQuery.of(context).size.height*.02,
                  bottom:  MediaQuery.of(context).size.height*.02
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ImageIcon(AssetImage("images/process.png",),size: 60,color: Colors.black38,),
                        CustomText.SubTitleText("InProcess")
                      ],
                    ),
                    SizedBox(width:  MediaQuery.of(context).size.width*.04,),
                    Column(
                      children: [
                        ImageIcon(AssetImage("images/inWay.png",),size: 60,color: Colors.black38,),
                        CustomText.SubTitleText("OnGoing")
                      ],
                    ),
                    SizedBox(width:  MediaQuery.of(context).size.width*.04,),
                    Column(
                      children: [
                        Icon(Icons.check_circle,color: Colors.black26,size: 60,),
                        CustomText.SubTitleText("Delivered")
                      ],
                    ),
                    SizedBox(width:  MediaQuery.of(context).size.width*.04,),
                    Column(
                      children: [
                        Icon(Icons.cancel,color: Colors.black26,size: 60,),
                        CustomText.SubTitleText("Rejected")
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.015,),
            GestureDetector(
              onTap: (){
                logout();
                Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
              },
              child: Container(
                height: MediaQuery.of(context).size.height*.06,
                width: MediaQuery.of(context).size.width*.94,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black12,width: 1.0),
                  color: Color(h.mainColor)
                ),
                alignment: Alignment.center,
                child: Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.035,),
           Expanded(child:  Image.asset("images/logo.png",color: Colors.black38,)),
            SizedBox(height: MediaQuery.of(context).size.height*.035,),
          ],
        ),
      ),
    )):Login();
  }
  logout()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.remove("id");
    prefs.remove("token");
    ParentPage.user_id=null;
    setState(() {
    });
  }
}