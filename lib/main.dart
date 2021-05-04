import 'package:ashmall/Screens/FirstLanguage.dart';
import 'package:ashmall/Screens/Profile.dart';
import 'package:ashmall/utils/app_LocalizationDeledate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ScopeModel/AppSCoedModel.dart';
import 'ScopeModel/Base_View.dart';
import 'ScopeModel/Locator_Service.dart';
import 'Screens/Category.dart';
import 'Screens/MainPage.dart';
import 'Screens/MainProfile.dart';
import 'Screens/ProductDetails.dart';
import 'Screens/Search.dart';
import 'Screens/Splash.dart';
import 'Screens/SubCategory.dart';
import 'Screens/VerificationDone.dart';
import 'Screens/Vervification.dart';
import 'Screens/test.dart';
import 'file:///D:/projects/ashmall/lib/Screens/ForgetPassword.dart';
import 'file:///D:/projects/ashmool/lib/Screens/Register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';
import 'Screens/Login.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
      Phoenix(child: ParentPage()));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class home extends StatelessWidget {
  int mainColor=0xffff4747;
  int redColor=0xffff4747;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BaseView<AppModel>(builder:(context,child,model)=>MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", ""), // OR Locale('ar', 'AE') OR Other RTL locales
        Locale("ar", ""),
      ],
      //locale:  Locale("ar", ""),
      locale: _State.lang==null?model.appLocal:Locale(_State.lang),
      theme:ThemeData(accentColor: Color(0xffff3185),
          primaryColor: Color(0xffff4747),
          fontFamily: 'Cairo'
      ),
      routes: <String,WidgetBuilder>{
       '/Search':(BuildContext context)=>new Search(),
        '/Category':(BuildContext context)=>new Category(),
        '/Login':(BuildContext context)=>new Login(),
        '/Register':(BuildContext context)=>new Register(),
        '/FirstLanguage':(BuildContext context)=>new FirstLanguage(),
        '/ForgetPassword':(BuildContext context)=>new ForgetPassword(),
        '/Profile':(BuildContext context)=>new Profile(),
        '/mainPage':(BuildContext context)=>new HomePage(0),
        '/notification':(BuildContext context)=>new HomePage(1),
        '/Cart':(BuildContext context)=>new HomePage(2),
        '/MainProfile':(BuildContext context)=>new MainProfile(),
      },
      home: Splash(),

    ));
  }
}
class ParentPage extends StatefulWidget {
  static int counter;
  static String user_id;
  static String language;
  @override
  _State createState() => _State();
}

class _State extends State<ParentPage>
{
  static String lang;
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lang=prefs.get('lang');
      ParentPage.language=prefs.get('lang');
      ParentPage.user_id=prefs.getString("id");
    });
  }





  @override
  void initState() {
    // TODO: implement initState
    //  secureScreen();
    super.initState();
    loadData();

  }
  @override
  Widget build(BuildContext context) {
    return home();
  }
}

