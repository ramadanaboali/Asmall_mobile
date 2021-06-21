import 'package:ashmall/Model/QuestionModel.dart';
import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomSearchAppBar.dart';

class ProductQuestion extends StatefulWidget{
  String product_id;
  var name;
  ProductQuestion(String product_id,this.name){
    this.product_id=product_id;
    this.name=name;
  }
  @override
  State<StatefulWidget> createState() {
  return _state(this.product_id,this.name);
  }
}
class _state extends State<ProductQuestion>{
  home h=new home();
  String product_id;
  var name;
  _state(String product_id,var name){
    this.product_id=product_id;
    this.name=name;
  }
  TextEditingController answer=new TextEditingController();
  TextEditingController question=new TextEditingController();
  var SelectedQuestion;
  TextEditingController searchKey=new TextEditingController();
  List<QuestionDetail>data;
  ProductServices productServices=new ProductServices();
  var lang;
  var user_id;
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
   data=await productServices.GetQuestion(prefs.getString("lang"), this.product_id);
   setState(() {
     lang=prefs.getString("lang");
     user_id=prefs.getString("id");
   });
   print(user_id);
   print("ssssssssss");
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
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [

              CustomSearchAppBar(),
              data==null?Expanded(child: Center(
                child: CircularProgressIndicator(),
              )):data.length==0? Expanded(
                child: Center(
                  child: Column(
                    children: [
                      user_id==null?SizedBox():Container(
                        width: MediaQuery.of(context).size.width*.9,
                        margin: EdgeInsets.only(
                            bottom: 10
                        ),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (val)async{
                            if(val.isNotEmpty){
                              Map<String,dynamic>responces=  await  productServices.addQuestion(lang, val, this.product_id, user_id);
                              print(responces);
                              loadData();
                              setState(() {
                                question.text="";
                              });


                            }
                          },
                          validator: (value){
                            if(value.isEmpty){
                              return 'Enter Your Email';
                            }
                            return null;
                          },
                          //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(.2))
                            ),
                            focusedBorder:  new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xffdedede))
                            ),
                            focusedErrorBorder:new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xfff00f00))
                            ),
                            errorBorder:new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xfff00f00))
                            ),
                            errorStyle: TextStyle(fontSize: 11),
                            contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                            hintText:'Enter Your Questions' ,
                            hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                            suffixIconConstraints: BoxConstraints(
                                maxHeight: 50,
                                minHeight: 30,
                                maxWidth: 70,
                                minWidth: 50
                            ) ,
                          ),
                          controller: question,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.2,),
                      Image.asset("images/logo.png",
                      height: MediaQuery.of(context).size.height*.2,
                      ),
                      SizedBox(height: 15,),
                      Text("لا يوجد اي اسئلة او اجابات لهذا المنتج")
                    ],
                  ),
                ),
              ): Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*.01,
                    bottom :MediaQuery.of(context).size.height*.02,
                    ),
                    itemCount: data.length,itemBuilder: (context,index){
                  return Column(
                    children: [
                      GestureDetector(

                        onTap: (){
                          setState(() {
                            SelectedQuestion=index;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.9,
                          //height: MediaQuery.of(context).size.height*.12,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width*.03,
                              right: MediaQuery.of(context).size.width*.03,
                            top: MediaQuery.of(context).size.height*.01 ,
                            bottom: MediaQuery.of(context).size.height*.01 ,

                          ),
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width*.05,
                              bottom:MediaQuery.of(context).size.height*.01 ,
                              right: MediaQuery.of(context).size.width*.05
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: Colors.black12,width: 1),
                              color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                               Row(
                                 children: [
                                   Row(children: [
                                     CircleAvatar(
                                       minRadius: 13,
                                       maxRadius: 14,
                                       child: ClipRRect(
                                           borderRadius: BorderRadius.all(Radius.circular(1000)),
                                           child: Image.network(GlobalVariable.URl+data[index].questionDto.userPhoto.toString())),
                                     ),
                                     SizedBox(width: 3,),
                                     Container(
                                         width: MediaQuery.of(context).size.width*.46-15,
                                         child: Text(data[index].questionDto.userName.toString(),maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(h.mainColor)),)),
                                   ],),
                                   Container(
                                     width: MediaQuery.of(context).size.width*.28,
                                     child: Row(
                                       children: [
                                         Text(data[index].questionDto.creationDate.toString(),style: TextStyle(fontSize:8,color: Colors.black),),
                                       SizedBox(width: 3,),
                                         Text(data[index].questionDto.creationTime.toString(),style: TextStyle(fontSize: 8,color: Colors.black),),
                                       ],
                                     ),
                                   )
                                 ],
                               ),
                                   SizedBox(height: 5,),
                                   Row(children: [
                                     SizedBox(width: 30,height: 15,),
                                     Container(
                                         width: MediaQuery.of(context).size.width*.68,
                                         child: Text(data[index].questionDto.questionText,style: TextStyle(fontSize: 12,color: Colors.black),)),
                                   ],),
                                 ],
                               ),
                              Expanded(
                                  child: Icon(SelectedQuestion==index?Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      SelectedQuestion==index?
                      Column(
                        children: [
                          Container(
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount:data[index].answerDtos.length,itemBuilder: (context,i){
                              return Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*.9,
                                    padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width*.05,
                                        top: MediaQuery.of(context).size.height*.0065,
                                        bottom: MediaQuery.of(context).size.height*.0065,
                                        right: MediaQuery.of(context).size.width*.05
                                    ),
                                    margin: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width*.05,
                                        bottom:MediaQuery.of(context).size.height*.01 ,
                                        right: MediaQuery.of(context).size.width*.05
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      //border: Border.all(color: Colors.black54,width: 1),
                                      // color: Colors.white
                                    ),

                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Row(children: [
                                              CircleAvatar(
                                                minRadius: 11,
                                                maxRadius: 13,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                                                    child: Image.network(GlobalVariable.URl+data[index].answerDtos[i].userPhoto.toString())),
                                              ),
                                              SizedBox(width: 3,),
                                              Container(
                                                  width: MediaQuery.of(context).size.width*.46-15,
                                                  child: Text(data[index].answerDtos[i].userName.toString(),maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(h.mainColor)),)),
                                            ],),
                                            Container(
                                              width: MediaQuery.of(context).size.width*.28,
                                              child: Row(
                                                children: [
                                                  Text(data[index].answerDtos[i].creationDate.toString(),style: TextStyle(fontSize:8,color: Colors.black),),
                                                  SizedBox(width: 3,),
                                                  Text(data[index].answerDtos[i].creationTime.toString(),style: TextStyle(fontSize: 8,color: Colors.black),),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                            width: MediaQuery.of(context).size.width*.65,
                                            child: Text(data[index].answerDtos[i].answerText,style: TextStyle(fontSize: 12)))
                                      ],
                                    )
                                    ,),
                                ],
                              );
                            }),
                          ),
                          user_id==null?SizedBox():
                          Container(
                            width: MediaQuery.of(context).size.width*.8,
                            margin: EdgeInsets.only(
                                bottom: 10
                            ),
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onFieldSubmitted: (val)async{
                                if(val.isNotEmpty){
                                  Map<String,dynamic>responces=await productServices.addAnswer(lang, val, data[index].questionDto.id, user_id);
                                  print(responces);
                                  loadData();
                                  setState(() {
                                    answer.text="";
                                  });
                                }
                              },
                              validator: (value){
                                if(value.isEmpty){
                                  return 'Enter Your Email';
                                }
                                return null;
                              },
                              //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                              decoration: InputDecoration(
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(.2))
                                ),
                                focusedBorder:  new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xffdedede))
                                ),
                                focusedErrorBorder:new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xfff00f00))
                                ),
                                errorBorder:new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xfff00f00))
                                ),
                                errorStyle: TextStyle(fontSize: 11),
                                contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                hintText:'Enter Your Answer' ,
                                hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                                suffixIconConstraints: BoxConstraints(
                                    maxHeight: 50,
                                    minHeight: 30,
                                    maxWidth: 70,
                                    minWidth: 50
                                ) ,
                              ),
                              controller: answer,
                            ),
                          )
                          ],
                      )
                        : SizedBox(),
                      Divider(color: Colors.black12,thickness: 1,),
                      index==data.length-1?
                      user_id==null?SizedBox():Container(
                        width: MediaQuery.of(context).size.width*.9,
                        margin: EdgeInsets.only(
                            bottom: 10
                        ),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (val)async{
                            if(val.isNotEmpty){
                           Map<String,dynamic>responces=  await  productServices.addQuestion(lang, val, this.product_id, user_id);
                           print(responces);
                           loadData();
                           setState(() {
                             question.text="";
                           });


                            }
                          },
                          validator: (value){
                            if(value.isEmpty){
                              return 'Enter Your Email';
                            }
                            return null;
                          },
                          //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(.2))
                            ),
                            focusedBorder:  new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xffdedede))
                            ),
                            focusedErrorBorder:new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xfff00f00))
                            ),
                            errorBorder:new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color(0xfff00f00))
                            ),
                            errorStyle: TextStyle(fontSize: 11),
                            contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                            hintText:'Enter Your Questions' ,
                            hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                            suffixIconConstraints: BoxConstraints(
                                maxHeight: 50,
                                minHeight: 30,
                                maxWidth: 70,
                                minWidth: 50
                            ) ,
                          ),
                          controller: question,
                        ),
                      ):SizedBox()
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}