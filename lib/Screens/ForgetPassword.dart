import 'package:ashmool/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<ForgetPassword>{
  home h=new home();
  final formKey=GlobalKey<FormState>();
  TextEditingController username=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text("Forget Password",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
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
                                  keyboardType: TextInputType.text,
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
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
                        SizedBox(height: 20,),
                        GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(h.mainColor),
                            ),
                            height: MediaQuery.of(context).size.height*.07,
                            width: MediaQuery.of(context).size.width*.85,
                            alignment: Alignment.center,
                            child:   Text("Confirm",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
                          ),)
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
}