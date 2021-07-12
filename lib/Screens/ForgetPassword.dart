import 'package:ashmall/Services/UserServices.dart';
import 'package:ashmall/main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:ashmall/Screens/Vervification.dart';
import 'package:ashmall/GlobalFunction.dart';

class ForgetPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<ForgetPassword>{
  home h=new home();
  bool loader=false;
  final formKey=GlobalKey<FormState>();
  TextEditingController username=new TextEditingController();
  UserServices userServices=new UserServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(DemoLocalizations.of(context).title["forgetPassword"],style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        elevation: 0,
        leading: GestureDetector(child: Icon(Icons.arrow_back),onTap: (){Navigator.pop(context);},),
        //  actions: [Icon(Icons.arrow_back)],
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
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
                        SizedBox(height: 20,),
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
                                  validator: (val){
                                    if(val.isEmpty){
                                      return DemoLocalizations.of(context).title["EnterYourEmail"];
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                    hintText:DemoLocalizations.of(context).title["email"],
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
                        SizedBox(height: 100,),
                        GestureDetector(
                          onTap: ()async{
                            if(formKey.currentState.validate()){
                              setState(() {
                                loader=true;
                              });
                              Map<String,dynamic>data=await userServices.forgetPassword(username.text,ParentPage.language);
                              Toast.show(
                                  "${data["message"]}", context,
                                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                               if(data["status"]==200){
                                 Navigator.push(context, GlobalFunction.route(verification(username.text,"")));
                               }
                               else{
                                 setState(() {
                                   loader=false;
                                 });
                               }
                            }
                          },
                          child: Container(
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:loader? Colors.black12:Color(h.mainColor),
                            ),
                            height: MediaQuery.of(context).size.height*.065,
                            width: MediaQuery.of(context).size.width*.85,
                            alignment: Alignment.center,
                            child:   Text(DemoLocalizations.of(context).title["confirm"],style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
                          ),)
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
                  Text(DemoLocalizations.of(context).title["DontHaveACount"]),
                  GestureDetector(onTap: (){Navigator.pushNamed(context, "/Register");},child: Text(DemoLocalizations.of(context).title["SignUp"],style: TextStyle(color: Color(h.mainColor),fontWeight: FontWeight.bold),))
                ],
              ),
            ),
            SizedBox(height: 20,)

          ],
        ),
      ),

    ));
  }
}