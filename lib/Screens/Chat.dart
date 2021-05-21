import 'package:ashmall/Screens/CustomSearchAppBar.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Chat>{
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              CustomSearchAppBar(),
              SizedBox(height: MediaQuery.of(context).size.height*.25,),
              Image.asset("images/logo.png",
              height: MediaQuery.of(context).size.height*.2,
              ),
              SizedBox(height: 15,),
              Text(DemoLocalizations.of(context).title["chatsoon"],style: TextStyle(color: Colors.black54,fontSize: 22),)
            ],
          ),
        ),
      ),
     ),
   );
  }
}