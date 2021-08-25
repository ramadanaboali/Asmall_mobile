import 'dart:async';

import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/Services/UserServices.dart';
import 'package:ashmall/main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Login extends StatefulWidget {
  var type;
  Login(var type) {
    this.type = type;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.type);
  }
}

class _state extends State<Login> {
  var type;
  _state(var type) {
    this.type = type;
  }
  bool loader = true;
  bool vendorloader = true;
  home h = new home();
  UserServices userServices = new UserServices();
  ProductServices productServices = new ProductServices();
  bool passVisibility = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  FocusNode passwordNode = new FocusNode();
  var lang;
  var link;
  Map<String, dynamic> setting;
  AccessToken _accessToken;
  bool _checking = true;
  Future<void> _appleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print(credential);

      setState(() {
        loader = false;
      });
      SharedPreferences pref = await SharedPreferences.getInstance();
      Map<String, dynamic> data = await userServices.social_login(
          "en",
          credential.givenName,
          credential.email,
          credential.userIdentifier,
          "",
          pref.getString("device_token"));
      if (data["status"] == 200) {
        setData("token", data["user"]["token"]);
        setData("id", data["user"]["id"]);
        setData("username", data["user"]["name"]);
        setData("email", data["user"]["email"]);
        // setData("phone", data["user"]["phone"]);
        setData("photo", data["user"]["photo"]);
        setState(() {
          ParentPage.user_id = data["user"]["id"];
          ParentPage.username = data["user"]["name"];
          ParentPage.email = data["user"]["email"];
          ParentPage.phone = data["user"]["phone"];
          ParentPage.userimage = data["user"]["photo"];
        });
        if (type == "first")
          Navigator.pushNamedAndRemoveUntil(
              context, "/mainPage", (route) => false);
        else
          Navigator.pop(context);
      } else {
        setState(() {
          loader = true;
        });
        Toast.show("${data["message"]}", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } on FacebookAuthException catch (e) {
      Toast.show(e.errorCode + " : " + e.message, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      print("111111111111111111111111111111111111111111111111111111111111");
    }
  }

  Future<void> _login() async {
    try {
      // by default the login method has the next permissions ['email','public_profile']
      AccessToken accessToken = await FacebookAuth.instance.login();
      // print(accessToken.toJson());
      // get the user data
      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
      setState(() {
        loader = false;
      });
      SharedPreferences pref = await SharedPreferences.getInstance();
      Map<String, dynamic> data = await userServices.social_login(
          "en",
          userData["name"],
          userData["email"],
          userData["id"],
          userData["picture"]["data"]["url"],
          pref.getString("device_token"));
      if (data["status"] == 200) {
        setData("token", data["user"]["token"]);
        setData("id", data["user"]["id"]);
        setData("username", data["user"]["name"]);
        setData("email", data["user"]["email"]);
        // setData("phone", data["user"]["phone"]);
        setData("photo", data["user"]["photo"]);
        setState(() {
          ParentPage.user_id = data["user"]["id"];
          ParentPage.username = data["user"]["name"];
          ParentPage.email = data["user"]["email"];
          ParentPage.phone = data["user"]["phone"];
          ParentPage.userimage = data["user"]["photo"];
        });
        await FacebookAuth.instance.logOut();
        if (type == "first")
          Navigator.pushNamedAndRemoveUntil(
              context, "/mainPage", (route) => false);
        else
          Navigator.pop(context);
      } else {
        setState(() {
          loader = true;
        });
        Toast.show("${data["message"]}", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          Toast.show("You have a previous login operation in progress", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          break;
        case FacebookAuthErrorCode.CANCELLED:
          Toast.show("login cancelled", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          break;
        case FacebookAuthErrorCode.FAILED:
          Toast.show("login failed", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          break;
      }
    }

    // setState(() {
    //   _checking = false;
    // });
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
      // clientId:
      //     "499289536123-3r47p9rg5dsu223mm4r86ognln7b1rlp.apps.googleusercontent.com",
      // scopes: <String>[
      //   'email',
      //   'https://www.googleapis.com/auth/contacts.readonly',
      // ],
      );
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      if (_googleSignIn.currentUser != null) {
        print('''name:${_googleSignIn.currentUser.email}''');
        setState(() {
          loader = false;
        });
        SharedPreferences pref = await SharedPreferences.getInstance();
        Map<String, dynamic> data = await userServices.social_login(
            "en",
            _googleSignIn.currentUser.displayName,
            _googleSignIn.currentUser.email,
            _googleSignIn.currentUser.id,
            _googleSignIn.currentUser.photoUrl,
            pref.getString("device_token"));
        await _googleSignIn.signOut();
        if (data["status"] == 200) {
          setData("token", data["user"]["token"]);
          setData("id", data["user"]["id"]);
          setData("username", data["user"]["name"]);
          setData("email", data["user"]["email"]);
          // setData("phone", data["user"]["phone"]);
          setData("photo", data["user"]["photo"]);
          setState(() {
            ParentPage.user_id = data["user"]["id"];
            ParentPage.username = data["user"]["name"];
            ParentPage.email = data["user"]["email"];
            ParentPage.phone = data["user"]["phone"];
            ParentPage.userimage = data["user"]["photo"];
          });

          if (type == "first")
            Navigator.pushNamedAndRemoveUntil(
                context, "/mainPage", (route) => false);
          else
            Navigator.pop(context);
        } else {
          setState(() {
            loader = true;
          });
          Toast.show("${data["message"]}", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      } else {
        Toast.show("sign in Failed", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } catch (error) {
      Toast.show(error, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      print(error);
      print("111111111111111111111111111111111111111111111111111111111111");
    }
  }

  loadData() async {
    print("romio in login page");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setting = await productServices.getSetting(prefs.getString("lang"));
    setting["data"]["dashboardLinkEnable"] == true
        ? prefs.setString("dashboardLink", setting["data"]["dashboardLink"])
        : print("sharrrrrrrrrrrf");
    setState(() {
      lang = prefs.getString("lang");
      link = prefs.getString("dashboardLink");
    });
  }

  Map<String, dynamic> _userData;
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
            context, "/mainPage", (route) => false);
      },
      child: SafeArea(
          child: Scaffold(
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
        body: Container(
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
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/mainPage", (route) => false);
                        },
                        child: Icon(
                          ParentPage.language == "ar"
                              ? Icons.arrow_back_ios_rounded
                              : Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 25,
                        )),
                    Text(
                      DemoLocalizations.of(context).title["login"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.notifications,
                          color: Color(h.mainColor),
                          size: 25,
                        ))
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
                        left: MediaQuery.of(context).size.width * .05,
                        right: MediaQuery.of(context).size.width * .05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.markunread),
                                Container(
                                  width: MediaQuery.of(context).size.width * .8,
                                  decoration: BoxDecoration(
                                      /* borderRadius:BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white,*/
                                      ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(passwordNode);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return DemoLocalizations.of(context)
                                            .title['EnterYourEmail'];
                                      }
                                      return null;
                                    },
                                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 11),
                                      contentPadding: EdgeInsets.only(
                                          right: 15,
                                          left: 15,
                                          top: 0,
                                          bottom: 0),
                                      hintText: DemoLocalizations.of(context)
                                          .title['Email'],
                                      hintStyle: TextStyle(
                                          fontSize: 12, color: Colors.black38),
                                      suffixIconConstraints: BoxConstraints(
                                          maxHeight: 50,
                                          minHeight: 30,
                                          maxWidth: 70,
                                          minWidth: 50),
                                    ),
                                    controller: username,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.https_rounded),
                                Container(
                                  width: MediaQuery.of(context).size.width * .8,
                                  decoration: BoxDecoration(
                                      /*borderRadius:BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white,*/
                                      ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return DemoLocalizations.of(context)
                                            .title['EnterYourPassword'];
                                      }
                                      return null;
                                    },
                                    focusNode: passwordNode,
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    obscureText: passVisibility,
                                    keyboardType: TextInputType.text,
                                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 11),
                                      contentPadding: EdgeInsets.only(
                                          right: 15,
                                          left: 15,
                                          top: 0,
                                          bottom: 0),
                                      hintText: DemoLocalizations.of(context)
                                          .title['Password'],
                                      suffixIcon: InkWell(
                                        child: Icon(
                                          passVisibility
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black38,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            passVisibility = !passVisibility;
                                          });
                                        },
                                      ),
                                      hintStyle: TextStyle(
                                          fontSize: 12, color: Colors.black38),
                                      suffixIconConstraints: BoxConstraints(
                                          maxHeight: 50,
                                          minHeight: 30,
                                          maxWidth: 70,
                                          minWidth: 50),
                                    ),
                                    controller: password,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (formKey.currentState.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  loader = false;
                                });
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                Map<String, dynamic> data =
                                    await userServices.login(
                                        "en",
                                        username.text.trim().toString(),
                                        password.text.trim().toString(),
                                        pref.getString("device_token"));
                                if (data["status"] == 200) {
                                  setData("token", data["user"]["token"]);
                                  setData("id", data["user"]["id"]);
                                  setData("username", data["user"]["name"]);
                                  setData("email", data["user"]["email"]);
                                  setData("phone", data["user"]["phone"]);
                                  setData("photo", data["user"]["photo"]);
                                  setState(() {
                                    ParentPage.user_id = data["user"]["id"];
                                    ParentPage.username = data["user"]["name"];
                                    ParentPage.email = data["user"]["email"];
                                    ParentPage.phone = data["user"]["phone"];
                                    ParentPage.userimage =
                                        data["user"]["photo"];
                                  });
                                  if (type == "first")
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, "/mainPage", (route) => false);
                                  else
                                    Navigator.pop(context);
                                } else {
                                  setState(() {
                                    loader = true;
                                  });
                                  Toast.show("${data["message"]}", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: loader
                                    ? Color(h.mainColor)
                                    : Colors.black12,
                              ),
                              height: MediaQuery.of(context).size.height * .065,
                              width: MediaQuery.of(context).size.width * .9,
                              alignment: Alignment.center,
                              child: Text(
                                DemoLocalizations.of(context).title["login"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          link == null
                              ? SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    launchURL(link);
                                    setState(() {
                                      vendorloader = false;
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .065,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: vendorloader
                                          ? Color(h.mainColor)
                                          : Colors.black12,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    child: Text(
                                        DemoLocalizations.of(context)
                                            .title['vendorLogin'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/ForgetPassword");
                                    },
                                    child: Text(
                                        DemoLocalizations.of(context)
                                            .title["ForgetPassword"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _login();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        color: Colors.blue,
                                      ),
                                      height: 55,
                                      width: 55,
                                      child: Image.asset(
                                        "images/icon/face.png",
                                        color: Colors.white,
                                      ),
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      _appleLogin();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        color: Colors.white,
                                      ),
                                      height: 55,
                                      width: 55,
                                      child: Image.asset(
                                        "images/icon/apple.png",
                                        color: Colors.black,
                                      ),
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      _handleSignIn();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        color: Colors.white,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 15.0,
                                              offset: Offset(0.0, 0.75))
                                        ],
                                      ),
                                      height: 55,
                                      width: 55,
                                      padding: EdgeInsets.all(7),
                                      child: Image.asset(
                                        "images/icon/google.png",
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DemoLocalizations.of(context).title["DontHaveACount"]),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/Register");
                        },
                        child: Text(
                          DemoLocalizations.of(context).title["SignUp"],
                          style: TextStyle(
                              color: Color(h.mainColor),
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      )),
    );
  }

  setData(var key, var value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    Timer(Duration(seconds: 3), () {
      setState(() {
        vendorloader = true;
      });
    });
  }
}
