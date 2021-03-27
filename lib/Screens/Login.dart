import 'file:///D:/projects/ashmool/lib/Screens/CustomAppBar.dart';
import 'package:ashmool/Services/UserServices.dart';
import 'package:ashmool/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Login>{
  home h=new home();
  final formKey=GlobalKey<FormState>();
  UserServices userServices=new UserServices();
  bool passVisibility=true;
  TextEditingController username=new TextEditingController();
  TextEditingController password=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
              CustomAppBar("Login"),
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
                                        return 'Enter Your Email';
                                      }
                                      return null;
                                    },
                                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 11),
                                      contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                      hintText:'Email' ,
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
                                        return 'Enter Your Password';
                                      }
                                      return null;
                                    },
                                    obscureText: passVisibility,
                                    keyboardType: TextInputType.text,
                                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 11),
                                      contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                      hintText:'Password' ,
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
                              setData("token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJNdWhhbW1hZEVsUmF5YW5BY2Nlc3NUb2tlbiIsImp0aSI6ImRjMGMxMzNlLTJkMjUtNDNiNS1hMmRmLWQ2ZjE1Y2VhYzJhYiIsImlhdCI6IjMvMTMvMjAyMSA0OjI5OjA3IFBNIiwiSWQiOiJjZWJmMmFkNy1hMTc1LTRlODQtYjUwYS03NDBlZWVmYTNjZGYiLCJVc2VyTmFtZSI6Ik11aGFtbWFkIFJheWFuIiwiRW1haWwiOiJlbHJpYW55MjAxN0BnbWFpbC5jb20iLCJleHAiOjE2MTU3MzkzNDcsImlzcyI6Ik11aGFtbWFkRWxSYXlhblNlcnZpY2UiLCJhdWQiOiJNdWhhbW1hZEVsUmF5YW5DbGllbnQifQ.KeKFXpyzWQYchOCw1oZ9EOYvPZMGjl9eVPsgXN5XHhs");
                              if(formKey.currentState.validate()){
                                Map<String,dynamic>data=await userServices.login("en",username.text.trim().toString(), password.text.trim().toString());
                                if(data["status"]==200){
                                  setData("token",data["user"]["token"]);
                                  setData("id",data["user"]["id"]);
                                  Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                                }else{
                                  Toast.show(
                                      "ddddddddddddddddd/*${data["message"]}*/", context,
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
                              child:   Text("Login",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
                            ),),
                          SizedBox(height: 15,),
                         Container(
                           width: MediaQuery.of(context).size.width*.9,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                             GestureDetector(onTap: (){Navigator.pushNamed(context, "/ForgetPassword");},child: Text("Forget Password",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54)))
                           ],),
                         )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont Have ACount?"),
                    GestureDetector(onTap: (){Navigator.pushNamed(context, "/Register");},child: Text(" Sign Up",style: TextStyle(color: Color(h.mainColor),fontWeight: FontWeight.bold),))
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
}