import 'package:ashmall/Services/UserServices.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../main.dart';

class RessetPassword extends StatefulWidget{
  String email;
  RessetPassword(String email){
    this.email=email;
  }
  @override
  State<StatefulWidget> createState() {
   return RessetPasswordState(this.email);
  }
}
class RessetPasswordState extends State<RessetPassword>{
  String email;
  RessetPasswordState(String email){
    this.email=email;
  }
  TextEditingController password=new TextEditingController();
  TextEditingController confirmPassword=new TextEditingController();
  UserServices userServices =new UserServices();
  home h=new home();
  bool loader=false;
  final formKey=GlobalKey<FormState>();
  bool passVisibility=true;
  bool passVisibility2=true;
  FocusNode passwordNade=new FocusNode();
  FocusNode confirmPasswordNade=new FocusNode();
  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: (){
        Navigator.pushNamedAndRemoveUntil(context, "/loginHome", (route) => false);
      },
      child: SafeArea(child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text(DemoLocalizations.of(context).title["resetPassword"],style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          elevation: 0,
          leading: GestureDetector(child: Icon(Icons.arrow_back),onTap: (){
            Navigator.pushNamedAndRemoveUntil(context, "/loginHome", (route) => false);
          },),
          //  actions: [Icon(Icons.arrow_back)],
          iconTheme: IconThemeData(
              color: Colors.black
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*.05,
            right: MediaQuery.of(context).size.width*.05,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
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
                            focusNode: passwordNade,
                            onFieldSubmitted: (value){
                              FocusScope.of(context).requestFocus(confirmPasswordNade);
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return 'Enter Password';
                              }
                              return null;
                            },
                            obscureText: passVisibility,
                            keyboardType: TextInputType.text,
                            //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                            decoration: InputDecoration(
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
                            focusNode: confirmPasswordNade,
                            onFieldSubmitted: (value){
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return 'Enter Confirm Password';
                              }
                              if(value!=password.text){
                                return 'Password Dont Identical';
                              }
                              return null;
                            },
                            obscureText: passVisibility2,
                            keyboardType: TextInputType.text,
                            //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                              hintText:'Confirm Password' ,
                              suffixIcon:InkWell(
                                child: Icon(passVisibility2?Icons.visibility:Icons.visibility_off,color: Colors.black38,),
                                onTap: (){
                                  setState(() {
                                    passVisibility2=!passVisibility2;
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
                            controller: confirmPassword,
                          ),
                        ),
                      ],
                    ),
                  ) ,
                  SizedBox(height: 50,),
                  GestureDetector(
                    onTap: ()async{

                      print("8888888888888888888888888888888888888888888888888");
                      if(formKey.currentState.validate()){
                        setState(() {
                          loader=true;
                        });
                       Map<String,dynamic> data=await userServices.resetPassword(ParentPage.language, email, password.text,confirmPassword.text);
                        Toast.show(data["message"], context,
                            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                        if(data["status"]==200){
                          Navigator.pushNamedAndRemoveUntil(context, "/verificationDone", (route) => false);
                        }else{
                          setState(() {
                            loader=false;
                          });
                        }
                      }
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: loader?Colors.black12:Color(h.mainColor),
                      ),
                      height: MediaQuery.of(context).size.height*.065,
                      width: MediaQuery.of(context).size.width*.9,
                      alignment: Alignment.center,
                      child:   Text(DemoLocalizations.of(context).title["confirm"],style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
                    ),),
                  SizedBox(height: 25,)
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}