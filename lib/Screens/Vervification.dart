import 'package:ashmall/Screens/ResetPassword.dart';
import 'package:ashmall/Screens/VerificationDone.dart';
import 'package:ashmall/Services/UserServices.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../GlobalFunction.dart';
import '../main.dart';
import 'CustomAppBar.dart';

class verification extends StatefulWidget {
  String email;
  String type;
  @override
  verification(String email,String type){
    this.email=email;
    this.type=type;
  }
  State<StatefulWidget> createState() {
    return verificationState(email,type);
  }
}

class verificationState extends State<verification> {
  String email;
  String type;
  Map<String,dynamic> data;
  UserServices userServices=new UserServices();
  verificationState(String email,String type){
    this.email=email;
    this.type=type;
  }
  home h = new home();
  bool loader=false;
  final foemKey = GlobalKey<FormState>();
  TextEditingController n1=new TextEditingController();
  TextEditingController n2=new TextEditingController();
  TextEditingController n3=new TextEditingController();
  TextEditingController n4=new TextEditingController();
  TextEditingController n5=new TextEditingController();
  TextEditingController n6=new TextEditingController();
  final nod0 = FocusNode();
  final nod1 = FocusNode();
  final nod2 = FocusNode();
  final nod3 = FocusNode();
  final nod4 = FocusNode();
  final nod5 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: (){
        Navigator.pushNamedAndRemoveUntil(context, "/loginHome", (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
         // resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.black26,
            title: Text(DemoLocalizations.of(context).title["verification"],style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
            elevation: 0,
            leading: GestureDetector(child: Icon(Icons.arrow_back),onTap: (){
              Navigator.pushNamedAndRemoveUntil(context, "/loginHome", (route) => false);
            },),
            //  actions: [Icon(Icons.arrow_back)],
            iconTheme: IconThemeData(
                color: Colors.black
            ),
          ),

          body:  Container(
              child: Column(
                children: [
                 //CustomAppBar("Activation "),
                  Container(
                    //  height: MediaQuery.of(context).size.height * .9,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.035,
                        right: MediaQuery.of(context).size.width*.035,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
                          ),
                          color: Colors.white),
                      child: Column(

                          children: [

                            SizedBox(
                              height: MediaQuery.of(context).size.height * .07,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * .8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${DemoLocalizations.of(context).title["entercode"]}  ${this.email}",
                                      style: TextStyle(height: 1.6,fontSize: 16, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .07,
                            ),

                          ])),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*.035,
                          right: MediaQuery.of(context).size.width*.035,
                        ),
                        color: Colors.white,
                        child: ListView(
                          children: [
                            Form(
                              key: foemKey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * .125,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      autofocus: true,
                                      focusNode: nod0,
                                      maxLength: 1,
                                      onChanged:(val) {
                                        if(val.isEmpty){

                                        }else
                                          FocusScope.of(context).requestFocus(nod1);
                                      },
                                      //  onFieldSubmitted:
                                      validator: (value) {
                                        if (value.isEmpty) return 'Error';
                                        return null;
                                      },
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22, fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide:
                                            BorderSide(color: Colors.black12)),
                                        focusedBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        errorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        focusedErrorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                        counterStyle: TextStyle(fontSize: 0),
                                      ),
                                      controller: n1,

                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * .125,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      maxLength: 1,
                                      onChanged: (val) {
                                        if(val.isEmpty){
                                          print("00000000000000000000000000000000");
                                          FocusScope.of(context).requestFocus(nod0);
                                        }else
                                          FocusScope.of(context).requestFocus(nod2);
                                      },
                                      focusNode: nod1,
                                      validator: (value) {
                                        if (value.isEmpty) return 'Error';
                                        return null;
                                      },
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22, fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide:
                                            BorderSide(color: Colors.black12)),
                                        focusedBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        errorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        focusedErrorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                        counterStyle: TextStyle(fontSize: 0),
                                      ),
                                      controller: n2,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * .125,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      maxLength: 1,
                                      onChanged: (val) {
                                        if(val.isEmpty){
                                          FocusScope.of(context).requestFocus(nod1);
                                        }else
                                          FocusScope.of(context).requestFocus(nod3);
                                      },
                                      focusNode: nod2,
                                      validator: (value) {
                                        if (value.isEmpty) return 'Error';
                                        return null;
                                      },
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22, fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide:
                                            BorderSide(color: Colors.black12)),
                                        focusedBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        errorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        focusedErrorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                        counterStyle: TextStyle(fontSize: 0),
                                      ),
                                      controller: n3,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * .125,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      maxLength: 1,
                                      validator: (value) {
                                        if (value.isEmpty) return 'Error';
                                        return null;
                                      },
                                      focusNode: nod3,
                                      onChanged: (val) {
                                        if(val.isEmpty){
                                          FocusScope.of(context).requestFocus(nod2);
                                        }else
                                          FocusScope.of(context).requestFocus(nod4);
                                      },
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22, fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide:
                                            BorderSide(color: Colors.black12)),
                                        focusedBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        errorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        focusedErrorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                        counterStyle: TextStyle(fontSize: 0),
                                      ),
                                      controller: n4,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * .125,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      maxLength: 1,
                                      validator: (value) {
                                        if (value.isEmpty) return 'Error';
                                        return null;
                                      },
                                      focusNode: nod4,
                                      onChanged: (val) {
                                        if(val.isEmpty){
                                          FocusScope.of(context).requestFocus(nod3);
                                        }else
                                          FocusScope.of(context).requestFocus(nod5);
                                      },
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22, fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide:
                                            BorderSide(color: Colors.black12)),
                                        focusedBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        errorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        focusedErrorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                        counterStyle: TextStyle(fontSize: 0),
                                      ),
                                      controller: n5,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * .125,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      maxLength: 1,
                                      validator: (value) {
                                        if (value.isEmpty) return 'Error';
                                        return null;
                                      },
                                      focusNode: nod5,
                                      onChanged: (val) {
                                        if(val.isEmpty){
                                          FocusScope.of(context).requestFocus(nod4);
                                        }else
                                          FocusScope.of(context).requestFocus(FocusNode());

                                      },
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22, fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide:
                                            BorderSide(color: Colors.black12)),
                                        focusedBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        errorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black12)),
                                        focusedErrorBorder: new OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.red)),
                                        counterStyle: TextStyle(fontSize: 0),
                                      ),
                                      controller: n6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .05,
                            ),
                            /*Container(
                                 margin: EdgeInsets.only(
                                     right: MediaQuery.of(context).size.width * .05),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [

                                     Text(translator.translate("NotRecived"),
                                         style: TextStyle(
                                           fontSize: 13,
                                           color: Colors.black54,
                                         )),
                                *//*     FlatButton(
                                         child: Text(
                                           translator.translate("resend"),
                                           style: TextStyle(color: Color(h.mainColor)),
                                         ),
                                         onPressed: null),*//*
                                   ],
                                 ),
                               ),*/
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),
                            GestureDetector(
                              onTap: ()async{
                                if (foemKey.currentState.validate())
                                {
                                  setState(() {
                                    loader=true;
                                  });
                                  Map<String,dynamic>data=await userServices.checkCodeForgetPassword(email, n1.text+n2.text+n3.text+n4.text+n5.text+n6.text,ParentPage.language);
                                 print(data);
                                 print("9999999999999999999999999999999999999999999999999999");
                                  Toast.show(
                                      "${data["message"]}", context,
                                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                  print(data["message"]);
                                  print("7777777777777777777777777777777777777777777777777777777777");
                                  if(data["status"]==200){
                                    Navigator.push(context, GlobalFunction.route(RessetPassword(email)));
                                  }else{
                                    setState(() {
                                      loader=false;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width * .05,
                                    left: MediaQuery.of(context).size.width * .05),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:loader?Colors.black12:Color(h.mainColor),
                                ),
                                height: MediaQuery.of(context).size.height * .06,
                                width: MediaQuery.of(context).size.width * .9,
                                alignment: Alignment.center,
                                child:  Text(DemoLocalizations.of(context).title["confirm"], style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),

        ),
      ),
    );
  }
}
