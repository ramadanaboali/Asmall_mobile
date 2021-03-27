import 'package:ashmall/Screens/AllBrand.dart';
import 'package:ashmall/Screens/Category.dart';
import 'package:ashmall/Screens/Search.dart';
import 'Screens/MainPage.dart';
import 'Screens/ProductDetails.dart';
import 'Screens/Splash.dart';
import 'Screens/SubCategory.dart';
import 'Screens/VerificationDone.dart';
import 'Screens/Vervification.dart';
import 'Screens/test.dart';
import 'file:///D:/projects/ashmall/lib/Screens/ForgetPassword.dart';
import 'file:///D:/projects/ashmall/lib/Screens/Register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';
import 'Screens/Login.dart';

void main() {
  runApp(home());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class home extends StatelessWidget {
  int mainColor=0xffff3185;
  int redColor=0xffff4747;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(accentColor: Color(0xffff3185),
          primaryColor: Color(0xffff4747),
          fontFamily: '29ltbukra'
      ),
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
       '/Search':(BuildContext context)=>new Search(),
        '/Category':(BuildContext context)=>new Category(),
        '/Login':(BuildContext context)=>new Login(),
        '/Register':(BuildContext context)=>new Register(),
        '/ForgetPassword':(BuildContext context)=>new ForgetPassword(),
        '/mainPage':(BuildContext context)=>new HomePage(0),
        '/notification':(BuildContext context)=>new HomePage(1),
      },
      home: Splash(),

    );
  }
}

