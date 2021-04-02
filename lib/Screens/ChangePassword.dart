import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Services/UserServices.dart';
import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget{
  String email;
  ChangePassword(String email){
    this.email=email;
  }
  @override
  State<StatefulWidget> createState() {
   return _state(this.email);
  }
}
class _state extends State<ChangePassword>{
  String email;
  _state(String email){
    this.email=email;
  }
  home h=new home();
  TextEditingController password=new TextEditingController();
  TextEditingController newPassword=new TextEditingController();
  TextEditingController newPassword2=new TextEditingController();
  FocusNode newPasswordNode=new FocusNode();
  FocusNode newPasswordNode2=new FocusNode();
  final formKey=GlobalKey<FormState>();
  UserServices userServices=new UserServices();
  bool passVisibility1=true;
  bool passVisibility2=true;
  bool passVisibility3=true;
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       body: Container(
         child:Column(
           children: [
             CustomAppBar("تغير كلمة المرور"),
             Form(
               key: formKey,
               child: Container(
                 padding: EdgeInsets.only(
                   left: MediaQuery.of(context).size.width*.05,
                   right: MediaQuery.of(context).size.width*.05
                 ),
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
                               onFieldSubmitted: (value){
                                 FocusScope.of(context).requestFocus(newPasswordNode);
                               },
                               validator: (value){
                                 if(value.isEmpty){
                                   return 'Enter Confirm Password';
                                 }
                                 return null;
                               },
                               obscureText: passVisibility1,
                               keyboardType: TextInputType.text,
                               //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                 hintText:'Old Password' ,
                                 suffixIcon:InkWell(
                                   child: Icon(passVisibility1?Icons.visibility:Icons.visibility_off,color: Colors.black38,),
                                   onTap: (){
                                     setState(() {
                                       passVisibility1=!passVisibility1;
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
                               onFieldSubmitted: (value){
                                 FocusScope.of(context).requestFocus(newPasswordNode);
                               },
                               validator: (value){
                                 if(value.isEmpty){
                                   return 'Enter Confirm Password';
                                 }
                                 return null;
                               },
                               obscureText: passVisibility2,
                               keyboardType: TextInputType.text,
                               //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                 hintText:'new Password' ,
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
                               controller: newPassword,
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
                               onFieldSubmitted: (value){
                                 FocusScope.of(context).requestFocus(newPasswordNode);
                               },
                               validator: (value){
                                 if(value.isEmpty){
                                   return 'Enter Confirm new Password';
                                 }
                                 if(value!=newPassword.text){
                                   return 'new Password Dont Identical';
                                 }
                                 return null;
                               },
                               obscureText: passVisibility3,
                               keyboardType: TextInputType.text,
                               //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                 hintText:'Confirm new Password',
                                 suffixIcon:InkWell(
                                   child: Icon(passVisibility3?Icons.visibility:Icons.visibility_off,color: Colors.black38,),
                                   onTap: (){
                                     setState(() {
                                       passVisibility3=!passVisibility3;
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
                               controller: newPassword2,
                             ),
                           ),
                         ],
                       ),
                     ) ,
                     SizedBox(height: 25,),
                     GestureDetector(
                       onTap: ()async{
                         if(formKey.currentState.validate()){
                           SharedPreferences prefs=await SharedPreferences.getInstance();
                           Map<String,dynamic>data=await userServices.resetPassword(prefs.getString("lang"), this.email, password.text);
                           print(data);
                           print("sssssssssssssssssssss");
                  /*         Map<String,dynamic>data =await userServices.registerServices("en", name.text.trim(), email.text.trim(), password.text.trim(), phone.text.trim(), address.text.trim());
                           if(data["status"]==200){
                             setData("token",data["user"]["token"]);
                             setData("id",data["user"]["id"]);
                             Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                           }else{
                             Toast.show(
                                 "${data["message"]}", context,
                                 duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                           }*/
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
                         child:   Text("Change Password",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
                       ),),
                   ],
                 ),
               ),
             )
           ],
         ),
       ),
     ),
   );
  }
}