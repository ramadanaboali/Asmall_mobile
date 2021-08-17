import 'package:ashmall/Model/CityModel.dart';
import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Services/UserServices.dart';
import 'package:ashmall/main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Register>{
  home h=new home();
  List<CityDetail>Cites=[];
  UserServices userServices =new UserServices();
  final formKey=GlobalKey<FormState>();
  bool passVisibility=true;
  bool passVisibility2=true;
  TextEditingController name=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController confirmPassword=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  FocusNode emailNade=new FocusNode();
  FocusNode phoneNade=new FocusNode();
  FocusNode passwordNade=new FocusNode();
  FocusNode confirmPasswordNade=new FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Register");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        child: Column(
          children: [
             CustomAppBar(DemoLocalizations.of(context).title['register']),
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
                              Icon(Icons.person ),
                              Container(
                                width: MediaQuery.of(context).size.width*.8,
                                decoration: BoxDecoration(
                                  /* borderRadius:BorderRadius.all(Radius.circular(30)),
                              color: Colors.white,*/
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  onFieldSubmitted: (value){
                                    FocusScope.of(context).requestFocus(emailNade);
                                  },
                                  validator: (value){
                                    if(value.isEmpty){
                                      return DemoLocalizations.of(context).title['entername'];
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 12),
                                    contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                    hintText:DemoLocalizations.of(context).title['name'] ,
                                    hintStyle: TextStyle(fontSize: 12,color: Colors.black38),
                                  ),
                                  controller: name,
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
                              Icon(Icons.markunread ),
                              Container(
                                width: MediaQuery.of(context).size.width*.8,
                                decoration: BoxDecoration(
                                  /* borderRadius:BorderRadius.all(Radius.circular(30)),
                              color: Colors.white,*/
                                ),
                                child: TextFormField(
                                  focusNode: emailNade,
                                  onFieldSubmitted: (value){
                                    FocusScope.of(context).requestFocus(phoneNade);
                                  },
                                  validator: (value){
                                    if(value.isEmpty){
                                      return  DemoLocalizations.of(context).title['EnterYourEmail'];
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                    hintText:DemoLocalizations.of(context).title['Email'] ,
                                    hintStyle: TextStyle(fontSize: 12,color: Colors.black38),
                                  ),
                                  controller: email,
                                ),
                              ),
                            ],),
                        ),
                        SizedBox(height: 25,),
                        //////////////////
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.phone_android ),
                              Container(
                                width: MediaQuery.of(context).size.width*.8,
                                decoration: BoxDecoration(
                                  /* borderRadius:BorderRadius.all(Radius.circular(30)),
                              color: Colors.white,*/
                                ),
                                child: TextFormField(
                                  focusNode: phoneNade,
                                  onFieldSubmitted: (value){
                                    FocusScope.of(context).requestFocus(passwordNade);
                                  },
                                  validator: (value){
                                    if(value.isEmpty){
                                      return DemoLocalizations.of(context).title['enterphone'];
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                    hintText:DemoLocalizations.of(context).title['phone'] ,
                                    hintStyle: TextStyle(fontSize: 12,color: Colors.black38),
                                  ),
                                  controller: phone,
                                ),
                              ),
                            ],),
                        ),
                        ////////////////
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
                                      return DemoLocalizations.of(context).title['EnterYourPassword'];
                                    }
                                    return null;
                                  },
                                  obscureText: passVisibility,
                                  keyboardType: TextInputType.text,
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                    hintText:DemoLocalizations.of(context).title['Password'],
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
                                      return DemoLocalizations.of(context).title['PasswordIdentical'];
                                    }
                                 if(value!=password.text){
                                   return DemoLocalizations.of(context).title['PasswordIdentical'];
                                 }
                                    return null;
                                  },
                                  obscureText: passVisibility2,
                                  keyboardType: TextInputType.text,
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                    hintText:DemoLocalizations.of(context).title['confirmpassword'] ,
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
                        SizedBox(height: 25,),
                        GestureDetector(
                          onTap: ()async{
                            if(formKey.currentState.validate()){
                              SharedPreferences pref=await SharedPreferences.getInstance();
                            Map<String,dynamic>data =await userServices.registerServices("en", name.text, email.text, password.text, phone.text,pref.getString("device_token"));
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
                            child:   Text(DemoLocalizations.of(context).title['register'],style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
                          ),),
                        SizedBox(height: 25,)
                      ],
                    ),
                  ),
                ),
              ),
            ),


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