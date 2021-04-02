import 'dart:io';

import 'package:ashmall/Screens/ChangePassword.dart';
import 'package:ashmall/Screens/Login.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/UserServices.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../GlobalFunction.dart';
import '../main.dart';
import 'CustomAppBar.dart';
class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Profile>{
  home h=new home();
  final formKey=GlobalKey<FormState>();
  UserServices userServices=new UserServices();
  bool passVisibility=true;
  TextEditingController username=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController name =new TextEditingController();
  TextEditingController email =new TextEditingController();
  TextEditingController phone =new TextEditingController();
  FocusNode emailNode=new FocusNode();
  FocusNode phoneNode=new FocusNode();
  var error=-1;
  var user_id;
  String image;
  Map<String,dynamic>data;
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      user_id=prefs.getString("id");
    });
    if(user_id!=null){
      data=await userServices.getUserInfo(prefs.getString("lang"), user_id, prefs.getString("token"));
      setState(() {
        name.text=data["data"]["name"];
        email.text=data["data"]["email"];
        phone.text=data["data"]["phone"];
        image=GlobalVariable.URl+data["data"]["photo"];
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: user_id!=null?Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
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
                          child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 25,)),
                      Text("Profile",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                      GestureDetector(
                          onTap: (){
                            Navigator.pushNamedAndRemoveUntil(context, "/notification", (route) => false);
                          },
                          child: Icon(Icons.notifications,color: Colors.white,size: 25,))
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                Container(
                    width: MediaQuery.of(context).size.width*.9,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(1000),),
                                    border: Border.all(color: Colors.black12,width: 3)
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "images/default_user.png",
                                    fit: BoxFit.fill,
                                    image:image==null?"":image,
                                    height: MediaQuery.of(context).size.height*.14,
                                    width:MediaQuery.of(context).size.height*.14,
                                  ),
                                )
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height*.1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.camera_alt_outlined,color: Color(h.mainColor),size: 20,),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.005,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.text12Bold("Name", Colors.black87),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: error==-1?Colors.grey.withOpacity(0.1):Colors.white,
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),

                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value){
                      FocusScope.of(context).requestFocus(emailNode);
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return '';
                      }
                      return null;
                    },
                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder:  new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedErrorBorder:new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      errorBorder:new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red)
                      ),
                      suffixIcon: Icon(Icons.edit_rounded),
                      hintText:'' ,
                      errorStyle: TextStyle(fontSize: 0),
                      hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                    controller: name,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.text12Bold("Email", Colors.black87),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: error==-1?Colors.grey.withOpacity(0.1):Colors.white,
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),

                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value){
                      FocusScope.of(context).requestFocus(phoneNode);
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return '';
                      }
                      return null;
                    },
                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder:  new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedErrorBorder:new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      errorBorder:new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red)
                      ),
                      suffixIcon: Icon(Icons.edit_rounded),
                      hintText:'رقم الهاتف' ,
                      errorStyle: TextStyle(fontSize: 0),
                      hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                    controller: email,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.text12Bold("Phone ", Colors.black87),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: error==-1?Colors.grey.withOpacity(0.1):Colors.white,
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),

                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value){
                      FocusScope.of(context).requestFocus(emailNode);
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return '';
                      }
                      return null;
                    },
                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder:  new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedErrorBorder:new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      errorBorder:new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red)
                      ),
                      suffixIcon: Icon(Icons.edit),
                      hintText:'' ,
                      errorStyle: TextStyle(fontSize: 0),
                      hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                    controller: phone,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.025,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(ChangePassword(email.text)));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*.05,),
                      Text("تغير كلمة المرور",style: TextStyle(color: Color(h.mainColor),fontWeight: FontWeight.bold,decoration: TextDecoration.underline),)
                      ,SizedBox(width: MediaQuery.of(context).size.width*.05,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ):
       Login(),
      ),
    );
  }
  File selectedImage;
  pickImage( ) async {
    var profileImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = profileImage;
    });

  }
  sendImagePick(File fileImage,BuildContext context)async
  {
    if (fileImage != null) {
      try {
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        Dio dio = Dio();

        ///we used uri.encode to enable upload  image with arabic name
        // var url =Uri.encodeFull(createPath('user/editProfileImage'));
        var url = "${GlobalVariable.URl}ar/doctor/uploadCertificates";
        print(url);
        String fileName = basename(fileImage.path);
        // print('${fileName},,,,fileName');
        //print('${pathImage.path},,,,imagePath.path');

        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(
              fileImage.path, filename: fileName
              , contentType: MediaType('image', fileName
              .split('.')
              .last)),
          "doctor_id": int.parse(this.user_id)/*int.parse(sharedPreferences.getString('UserID'))*/,
        });
        print(formData.fields);
        print("ssssssssssssssssss");
        Response response = await dio.post(url, data: formData);
        print('${response.data},,,,,,,,fields');
        if (response.statusCode == 200) {
          Map<String, dynamic>map = response.data;
          Toast.show(
              map['Data'], context,
              duration: Toast.LENGTH_SHORT,
              gravity: Toast.BOTTOM);

        }
        else {
          return null;
        }
      }
      catch (e) {
        print('${e}imageuploaderror');
      }
    }
    else {
      pickImage();
    }}
  setData(var key,var value) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}

class CustomText{

  static Widget text12(String text){
    return Text(text,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black54),);
  }

  static Widget text12Bold(String text,Color color){
    return Text(text,style: TextStyle(height: 1.3,fontSize: 12,fontWeight: FontWeight.bold,color: color));
  }
  static Widget text12Boldcenter(String text,Color color){
    return Text(text,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: color),textAlign: TextAlign.center);
  }
  static Widget titleTextColor(String text,Color color){
    return Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: color),);
  }

  }

