import 'package:ashmall/GlobalFunction.dart';
import 'package:ashmall/Model/FollowerModel.dart';
import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Screens/CustRate.dart';
import 'package:ashmall/Screens/CustomSearchAppBar.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/Services/UserServices.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'CustomText.dart';
import 'ProductDetails.dart';
import 'Store.dart';

class Follower extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return _state();
  }
}
class _state extends State<Follower>{
home h=new home();
UserServices userServices=new UserServices();
List<FollowerDetail>data;
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    data=await userServices.GetFolloers(prefs.getString("id"));
    setState(() {
    });
    print(GlobalVariable.URl+data[0].photo);
    print(data.length);
    print("*************************");
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
          body: data==null?Center(child: CircularProgressIndicator()):
          Container(
            child: Column(
              children: [
                CustomSearchAppBar(),
                SizedBox(height: 15,),
               data.length==0? Expanded(child: Column(
                 children: [
                   SizedBox(height: MediaQuery.of(context).size.height*.2,),
                   Image.asset("images/logo.png",
                   height: MediaQuery.of(context).size.height*.15,
                   ),
                   CustomText.SubTitleText("No Followers For You")
                 ],
                 
               )):Expanded(
                    child: ListView.builder(itemCount: data.length,itemBuilder: (context,index){
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, GlobalFunction.route(Store(data[index].id)));
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width*.05,
                                right: MediaQuery.of(context).size.width*.05,
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Image.network(GlobalVariable.URl+data[index].photo,
                                      height: MediaQuery.of(context).size.width*.2,
                                      width: MediaQuery.of(context).size.width*.2,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*.7-10,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data[index].name,style: TextStyle(fontSize: 13,height: 1.3),),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*.7-10,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width*.44,
                                                child: Text(data[index].email,maxLines: 1,style: TextStyle(fontSize: 10,height: 1.3),)),
                                            /*Text(data[index].gender,style: TextStyle(fontSize: 12,height: 1.5),),*/
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*.7-10,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width*.4  ,
                                                child: Text(data[index].phone,style: TextStyle(fontSize: 10,height: 1.3),)),
                                            /* CustomRate(int.parse(data[index]..toString()), 15),*/
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                          Container(
                            height:1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black38,
                          ),
                        ],
                      );
                    })
                )
              ],
            ),
          )
      ),
    );
  }
}