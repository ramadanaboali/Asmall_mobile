import 'dart:io';
import 'package:intl/intl.dart';
import 'package:ashmall/Screens/ChangePassword.dart';
import 'package:ashmall/Screens/Login.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/UserServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../GlobalFunction.dart';
import '../main.dart';
import 'CustomAppBar.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<Profile> {
  home h = new home();
  var gender;
  var token;
  final formKey = GlobalKey<FormState>();
  UserServices userServices = new UserServices();
  bool passVisibility = true;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  FocusNode emailNode = new FocusNode();
  FocusNode phoneNode = new FocusNode();
  var error = -1;
  var user_id;
  String image;
  Map<String, dynamic> data;
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString("id");
      finaldate = prefs.getString("date");
      token = prefs.getString("token");
    });
    if (user_id != null) {
      data = await userServices.getUserInfo(
          prefs.getString("lang"), user_id, prefs.getString("token"));
      setState(() {
        name.text = data["data"]["name"];
        email.text = data["data"]["email"];
        phone.text = data["data"]["phone"];
        image = "https://" + data["data"]["photo"];
        gender = data["data"]["gender"];
      });
      setState(() {});
    }
  }

  var finaldate;
  var today = DateFormat.yMMMd().format(new DateTime.now());
  void callDatePicker(BuildContext context) async {
    var order = await getDate(context);
    setState(() {
      finaldate = DateFormat('yyyy-MM-dd').format(order);
    });
    print(finaldate);
  }

  Future<DateTime> getDate(BuildContext context) {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/MainProfile", (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          body: data != null
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .07,
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
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        "/MainProfile", (route) => false);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                              Text(
                                "Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        "/notification", (route) => false);
                                  },
                                  child: Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 25,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * .9,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    pickImage(context);
                                    loadData();
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(1000),
                                              ),
                                              border: Border.all(
                                                  color: Colors.black12,
                                                  width: 3)),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(1000)),
                                            child: Image.network(
                                              image,
                                              fit: BoxFit.fill,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .14,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .14,
                                            ),
                                          )),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 3,
                                                blurRadius: 3,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Color(h.mainColor),
                                            size: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .005,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.text12Bold("Name", Colors.black87),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: error == -1
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.white,
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {}
                              FocusScope.of(context).requestFocus(emailNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  right: 15, left: 15, top: 0, bottom: 0),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              errorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              suffixIcon: Icon(Icons.edit_rounded),
                              hintText: '',
                              errorStyle: TextStyle(fontSize: 0),
                              hintStyle: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            controller: name,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.text12Bold("Email", Colors.black87),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: error == -1
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.white,
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {}
                              FocusScope.of(context).requestFocus(phoneNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  right: 15, left: 15, top: 0, bottom: 0),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              errorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              suffixIcon: Icon(Icons.edit_rounded),
                              hintText: 'رقم الهاتف',
                              errorStyle: TextStyle(fontSize: 0),
                              hintStyle: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            controller: email,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.text12Bold("Phone ", Colors.black87),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: error == -1
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.white,
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {}
                              FocusScope.of(context).requestFocus(emailNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  right: 15, left: 15, top: 0, bottom: 0),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              errorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              suffixIcon: Icon(Icons.edit),
                              hintText: '',
                              errorStyle: TextStyle(fontSize: 0),
                              hintStyle: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            controller: phone,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.text12Bold(
                                  "Birth Date", Colors.black87),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        GestureDetector(
                          onTap: () {
                            callDatePicker(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.height * .065,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 15, bottom: 15),
                            child: CustomText.text12Bold(
                                finaldate == null ? "Select Date" : finaldate,
                                Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .05,
                            right: MediaQuery.of(context).size.width * .05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText.text12Bold("Gender", Colors.black87),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    gender = "Male";
                                  });
                                },
                                child: Row(
                                  children: [
                                    CustomText.text12("Male"),
                                    Radio(
                                        value: "Male",
                                        groupValue: gender,
                                        onChanged: (val) {
                                          setState(() {
                                            gender = "Male";
                                          });
                                        })
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    gender = "Female";
                                  });
                                },
                                child: Row(
                                  children: [
                                    CustomText.text12("Female"),
                                    Radio(
                                        value: "Female",
                                        groupValue: gender,
                                        onChanged: (val) {
                                          setState(() {
                                            gender = "Female";
                                          });
                                        })
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            await userServices.editProfile(user_id, name.text,
                                email.text, phone.text, gender, null);
                            pref.setString("date", finaldate);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/MainProfile", (route) => false);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.height * .065,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color(h.mainColor)),
                            alignment: Alignment.center,
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                        /*GestureDetector(
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
                  )*/
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
        ),
      ),
    );
  }

  File selectedImage;
  pickImage(BuildContext context) async {
    ImagePicker picker = new ImagePicker();
    var profileImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(profileImage.path);
    });
    await UserServices.updateAvatar(selectedImage, context, user_id);
    data = await userServices.getUserInfo("en", user_id, token);

    name.text = data["data"]["name"];
    email.text = data["data"]["email"];
    phone.text = data["data"]["phone"];
    image = "https://" + data["data"]["photo"];
    gender = data["data"]["gender"];
    ParentPage.username = data["data"]["name"];
    ParentPage.email = data["data"]["email"];
    ParentPage.phone = data["data"]["phone"];
    setState(() {});
  }

  setData(var key, var value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}

class CustomText {
  static Widget text12(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
    );
  }

  static Widget text12Bold(String text, Color color) {
    return Text(text,
        style: TextStyle(
            height: 1.3,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color));
  }

  static Widget text12Boldcenter(String text, Color color) {
    return Text(text,
        style:
            TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
        textAlign: TextAlign.center);
  }

  static Widget titleTextColor(String text, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
    );
  }
}
