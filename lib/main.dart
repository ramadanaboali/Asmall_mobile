import 'package:ashmall/Screens/FirstLanguage.dart';
import 'package:ashmall/Screens/Orders.dart';
import 'package:ashmall/Screens/Profile.dart';
import 'package:ashmall/utils/app_LocalizationDeledate.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ScopeModel/AppSCoedModel.dart';
import 'ScopeModel/Base_View.dart';
import 'ScopeModel/Locator_Service.dart';
import 'Screens/Category.dart';
import 'Screens/ChooseAddress.dart';
import 'Screens/Followers.dart';
import 'Screens/ForgetPassword.dart';
import 'Screens/MainPage.dart';
import 'Screens/MainProfile.dart';
import 'Screens/ProductDetails.dart';
import 'Screens/Register.dart';
import 'Screens/Search.dart';
import 'Screens/Splash.dart';
import 'Screens/SubCategory.dart';
import 'Screens/VerificationDone.dart';
import 'Screens/Vervification.dart';
import 'Screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';
import 'Screens/Login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'DbHelper.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(Phoenix(child: ParentPage()));
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
          fontFamily: 'ArbFONTS-4_10'
      ),
      routes: <String,WidgetBuilder>{
       '/Search':(BuildContext context)=>new Search(),
        '/Category':(BuildContext context)=>new Category(),
        '/Login':(BuildContext context)=>new Login("first"),
        '/Register':(BuildContext context)=>new Register(),
        '/FirstLanguage':(BuildContext context)=>new FirstLanguage(),
        '/ForgetPassword':(BuildContext context)=>new ForgetPassword(),
        '/Profile':(BuildContext context)=>new Profile(),
        '/mainPage':(BuildContext context)=>new HomePage(0),
        '/Orders':(BuildContext context)=>new Orders(),
        '/notification':(BuildContext context)=>new HomePage(1),
        '/Cart':(BuildContext context)=>new HomePage(2),
        '/loginHome':(BuildContext context)=>new HomePage(3),
        '/MainProfile':(BuildContext context)=>new MainProfile(),
        '/verificationDone':(BuildContext context)=>new VerificationDone(),
      },
      home: Splash(),

    ));
  }
}
class ParentPage extends StatefulWidget {
  static int counter=0;
  static String user_id;
  static String language;
  static String username;
  static String email;
  static String phone;
  static String userimage;
  static double total=0.0;
  static int quantity=0;
  @override
  _State createState() => _State();
}

class _State extends State<ParentPage>
{
  static String lang;
  DbHelper db=new DbHelper();
  List dataLocal=[];
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataLocal=await db.allProduct();
    setState(() {
      lang=prefs.get('lang');
      ParentPage.language=prefs.get('lang');
      ParentPage.user_id=prefs.getString("id");
      ParentPage.counter=dataLocal.length;
      ParentPage.username=prefs.getString("username");
      ParentPage.email=prefs.getString("email");
      ParentPage.phone=prefs.getString("phone");
      ParentPage.userimage=prefs.getString("photo");
      ParentPage.total=double.parse(prefs.getString("total"));
      ParentPage.quantity=int.parse(prefs.getString("quantity"));
    });
  }

  String _message = '';
  String _tokenAccess='';
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =new  FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging =new  FirebaseMessaging();

_register()async {
    await _firebaseMessaging.getToken().then((token){
      SharedPreferences.getInstance().then((shared){
        shared.setString('device_token', token);
      });

      print('${token},,,,,,toookkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    });
    print("_____________________________________________________________________________________________________________");
  }
 void getMessage()async{
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          showNotificationsFunc(message);
          print('on message $message');
          setState(() => _message = message["notification"]["title"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"]);
    });
  }

  showNotificationsFunc(Map<String,dynamic>message)async
  {
    var android = AndroidNotificationDetails('channel_id', 'CHANNEL_NAME', 'channelDescription');
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android,ios);
    await flutterLocalNotificationsPlugin.show(0, message['notification']['title'].toString(),
        message['notification']['body'].toString(), platform);
  }
  @override
  void initState() {
    // TODO: implement initState
    //  secureScreen();
    super.initState();
    var android = new AndroidInitializationSettings('mipmap/launcher_icon');
    var ios = IOSInitializationSettings();
    var platform = InitializationSettings(android,ios);
    flutterLocalNotificationsPlugin.initialize(platform);
   getMessage();
     _register();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return home();
  }
}

