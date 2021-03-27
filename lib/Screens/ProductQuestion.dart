import 'package:ashmall/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductQuestion extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return _state();
  }
}
class _state extends State<ProductQuestion>{
  home h=new home();
  TextEditingController answer=new TextEditingController();
  TextEditingController question=new TextEditingController();
  var SelectedQuestion;
  TextEditingController searchKey=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*.03,
                    right: MediaQuery.of(context).size.width*.03
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(child: Icon(Icons.arrow_back),onTap: (){Navigator.pop(context);},),
                    Container(
                      width: MediaQuery.of(context).size.width*.7,
                      height: MediaQuery.of(context).size.height*.05,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        enabled: false,
                        onTap: (){
                          Navigator.pushNamed(context, "/Search");
                        },
                        keyboardType: TextInputType.text,
                        //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                          disabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Color(h.mainColor))
                          ),
                          enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Color(h.mainColor))
                          ),
                          focusedBorder:  new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Color(h.mainColor))
                          ),
                          focusedErrorBorder:new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          errorBorder:new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          hintText:'Search',
                          hintStyle: TextStyle(fontSize: 12,color: Colors.black38),
                          suffixIcon:Container(
                              margin: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Color(h.redColor)
                              ),
                              child: Icon(Icons.search,color: Colors.white,size: 20,)),
                          suffixIconConstraints: BoxConstraints(
                              maxHeight: 50,
                              minHeight: 30,
                              maxWidth: 70,
                              minWidth: 50
                          ) ,
                        ),
                        controller: searchKey,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*.03,),
                    Icon(Icons.shopping_cart,size: 25,),
                    Icon(Icons.menu)
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.015,),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*.01 ),
                    itemCount: 15,itemBuilder: (context,index){
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
                          height: MediaQuery.of(context).size.height*.08,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width*.03,
                              right: MediaQuery.of(context).size.width*.03
                          ),
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width*.05,
                              bottom:MediaQuery.of(context).size.height*.01 ,
                              right: MediaQuery.of(context).size.width*.05
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Color(h.mainColor)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                CircleAvatar(
                                  minRadius: 13,
                                  maxRadius: 14,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(1000)),
                                      child: Icon(Icons.person,)),
                                ),
                                SizedBox(width: 3,),
                                Text("How Match This Product ?",style: TextStyle(color: Colors.white),),
                              ],),
                              Icon(SelectedQuestion==index?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,color: Colors.white)
                            ],
                          ),
                        ),
                      ),
                      SelectedQuestion==index?
                      Container(
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: 5,itemBuilder: (context,index){
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

                                      child:Row(
                                        children: [
                                        CircleAvatar(
                                        minRadius: 11,
                                        maxRadius: 13,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(1000)),
                                            child: Icon(Icons.person,)),
                                      ),
                                      SizedBox(width: 4,),
                                      Text("Nice Product and userful",style: TextStyle(fontSize: 12))
                                        ],
                                      )
                                  ,),

                                  index==4?
                                    Container(
                                    width: MediaQuery.of(context).size.width*.8,
                             margin: EdgeInsets.only(
                               bottom: 10
                             ),
                             decoration: BoxDecoration(
                             borderRadius:BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.black54,width: 1),
                                color: Colors.white,
                               ),
                          child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value){
                          if(value.isEmpty){
                          return 'Enter Your Email';
                          }
                          return null;
                          },
                          //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                          decoration: InputDecoration(
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
                          ):SizedBox()
                                  ],
                                );
                        }),
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