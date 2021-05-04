import 'file:///D:/projects/ashmall/lib/Screens/CustomAppBar.dart';
import 'package:ashmall/Services/UserServices.dart';
import 'package:ashmall/main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Login>{
  home h=new home();

  UserServices userServices=new UserServices();
  bool passVisibility=true;
  final formKey=GlobalKey<FormState>();
  TextEditingController username=new TextEditingController();
  TextEditingController password=new TextEditingController();
  var lang;
  var link;
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      lang=prefs.getString("lang");
      link=prefs.getString("dashboardLink");
    });
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
    //  resizeToAvoidBottomPadding: false,
      /*appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text("Login",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        elevation: 0,
        leading: GestureDetector(child: Icon(Icons.arrow_back),onTap: (){Navigator.pop(context);},),
        //  actions: [Icon(Icons.arrow_back)],
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),*/
      body:  Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.07,
                width: MediaQuery.of(context).size.width,
                color: Color(h.mainColor),
                padding: EdgeInsets.only(
                  left: 10,
                  right: 20,

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                        },
                        child: Icon(lang=="en"?Icons.arrow_back_ios_rounded:Icons.arrow_forward_ios_rounded,color: Colors.white,size: 25,)),
                    Text(DemoLocalizations.of(context).title["login"],style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.notifications,color: Color(h.mainColor),size: 25,))
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.05,
                        right: MediaQuery.of(context).size.width*.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 25,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.markunread ),
                                Container(
                                  width: MediaQuery.of(context).size.width*.8,
                                  decoration: BoxDecoration(
                                    /* borderRadius:BorderRadius.all(Radius.circular(30)),
                                color: Colors.white,*/
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (value){
                                      if(value.isEmpty){
                                        return DemoLocalizations.of(context).title['EnterYourEmail'];
                                      }
                                      return null;
                                    },
                                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 11),
                                      contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                      hintText:DemoLocalizations.of(context).title['Email'] ,
                                      hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                                      suffixIconConstraints: BoxConstraints(
                                          maxHeight: 50,
                                          minHeight: 30,
                                          maxWidth: 70,
                                          minWidth: 50
                                      ) ,
                                    ),
                                    controller: username,
                                  ),
                                ),
                              ],),
                          ),
                          SizedBox(height: 25,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.https_rounded ),
                                Container(
                                  width: MediaQuery.of(context).size.width*.8,
                                  decoration: BoxDecoration(
                                    /*borderRadius:BorderRadius.all(Radius.circular(30)),
                                color: Colors.white,*/
                                  ),
                                  child: TextFormField(
                                    validator: (value){
                                      if(value.isEmpty){
                                        return DemoLocalizations.of(context).title['EnterYourPassword'];
                                      }
                                      return null;
                                    },
                                    obscureText: passVisibility,
                                    keyboardType: TextInputType.text,
                                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 11),
                                      contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                      hintText:DemoLocalizations.of(context).title['Password'] ,
                                      suffixIcon:InkWell(
                                        child: Icon(passVisibility?Icons.visibility:Icons.visibility_off,color: Colors.black38,),
                                        onTap: (){
                                          setState(() {
                                            passVisibility=!passVisibility;
                                          });
                                        },
                                      ) ,
                                      hintStyle: TextStyle(fontSize: 12,color: Colors.black38),
                                      suffixIconConstraints: BoxConstraints(
                                          maxHeight: 50,
                                          minHeight: 30,
                                          maxWidth: 70,
                                          minWidth: 50
                                      ) ,
                                    ),
                                    controller: password,
                                  ),
                                ),
                              ],
                            ),
                          ) ,
                          SizedBox(height: 35,),
                          GestureDetector(
                            onTap: () async {

                              if(formKey.currentState.validate()){
                                Map<String,dynamic>data=await userServices.login("en",username.text.trim().toString(), password.text.trim().toString());
                                if(data["status"]==200){
                                  setData("token",data["user"]["token"]);
                                  setData("id",data["user"]["id"]);
                                  setState(() {
                                    ParentPage.user_id=data["user"]["id"];
                                  });
                                  Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                                }else{
                                  Toast.show(
                                      "${data["message"]}", context,
                                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                }
                              }
                            },
                            child: Container(
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(h.mainColor),
                              ),
                              height: MediaQuery.of(context).size.height*.065,
                              width: MediaQuery.of(context).size.width*.9,
                              alignment: Alignment.center,
                              child:   Text(DemoLocalizations.of(context).title["login"],style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
                            ),),
                          SizedBox(height: 15,),
                          link==null?  SizedBox():
                          GestureDetector(
                            onTap: (){
                              launchURL(link);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*.065,
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(h.mainColor),
                              ),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              child:  Text(" تسجيل الدخول كبائع",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w700)),
                            ),
                          ),
                          SizedBox(height: 15,),
                         Container(
                           width: MediaQuery.of(context).size.width*.9,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                             GestureDetector(onTap: (){Navigator.pushNamed(context, "/ForgetPassword");},child: Text(DemoLocalizations.of(context).title["ForgetPassword"],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54)))
                           ],),
                         )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DemoLocalizations.of(context).title["DontHaveACount"]+"?"),
                    GestureDetector(onTap: (){Navigator.pushNamed(context, "/Register");},child: Text(DemoLocalizations.of(context).title["SignUp"],style: TextStyle(color: Color(h.mainColor),fontWeight: FontWeight.bold),))
                  ],
                ),
              ),
              SizedBox(height: 25,)

            ],
          ),
        ),


    ));
  }
  setData(var key,var value) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }}
}