import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../GlobalFunction.dart';
import '../HomePage.dart';
import '../main.dart';
import 'CustomAppBar.dart';

class Orders extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Orders>{
  List<String>Category=["Pending","InWay","Delivered","Canceled"];
  String SelectedCategory;
  home h=new home();
  int index=0;
  List<String>data=["","",""];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SelectedCategory=Category[0];
  }
  @override
  Widget build(BuildContext context) {
    List<Widget>content=[
      Expanded(child: ListView.builder(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height*.025,
              bottom: MediaQuery.of(context).size.height*.03
          ),
          itemCount: 10,itemBuilder: (context,index){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height*.12,
          margin: EdgeInsets.only(
              bottom:MediaQuery.of(context).size.height*.01,
              left: MediaQuery.of(context).size.width*.03,
              right:  MediaQuery.of(context).size.width*.03
          ),
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*.02,
          ),
          child: Row(
            children: [
              Image.asset("images/food.png",
                width: MediaQuery.of(context).size.width*.25,
                height: MediaQuery.of(context).size.height*.12,
                fit: BoxFit.cover,
              ),
              SizedBox(width:MediaQuery.of(context).size.width*.02,),
              Container(
                width: MediaQuery.of(context).size.width*.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.height*.005,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("وجبة عائلية",style: TextStyle(height: .7,color: Color(h.mainColor),fontSize: 17,fontWeight: FontWeight.bold),),
                        Row(children: [
                          Icon(Icons.bookmark,color: Colors.blue,),
                        ],)
                      ],
                    ),
                    Text("هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق،",
                      style: TextStyle(height: 1.0,fontSize: 11,color: Colors.black38),maxLines: 2,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height*.01,),
                  ],),
              )
            ],
          ),
        );
      })),

    ];
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return SafeArea(child: Scaffold(

      body: Container(
          child: Column(
            children: [
              CustomAppBar("Orders"),
              SizedBox(height: MediaQuery.of(context).size.height*.03,),
              Container(
                height: 37,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: Category.length,
                    itemBuilder: (context,index)
                    {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            SelectedCategory=Category[index];
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.only(
                                left:MediaQuery.of(context).size.width*.05
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 80,
                                    alignment: Alignment.center,
                                    child: Text(Category[index],style: TextStyle(color: SelectedCategory==Category[index]?Color(h.mainColor):Colors.black54,fontSize: 14),)),
                                SizedBox(height: 4,),
                                SelectedCategory==Category[index]?  Container(height:2,color: Color(h.mainColor),
                                  width: 80,
                                ):SizedBox()

                              ],
                            )        ),
                      );
                    }
                ),
              ),
              SelectedCategory==Category[0]?
              Expanded(child: ListView.builder(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*.0,
                      bottom: MediaQuery.of(context).size.height*.04
                  ),
                  itemCount: 4,itemBuilder: (context,index){
                return   Container(
                  margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.03,right:  MediaQuery.of(context).size.width*.04,left:  MediaQuery.of(context).size.width*.04,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black12.withOpacity(.08),width: 1),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.03),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                          width:MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width*.05,
                            top: MediaQuery.of(context).size.height*.015,
                            bottom: MediaQuery.of(context).size.height*.015,
                            left: MediaQuery.of(context).size.width*.05,
                          ),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                              Text(" Order Number ${index+1}",style: TextStyle(height: .8,fontSize: 16,fontWeight: FontWeight.bold),),
                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                              Container(
                                width:MediaQuery.of(context).size.width*.9,
                                padding: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width*.05,
                                  top: MediaQuery.of(context).size.height*.01,
                                  // bottom: MediaQuery.of(context).size.height*.01,
                                  left: MediaQuery.of(context).size.width*.05,
                                ),
                                child: ListView.builder(
                                    itemCount: data.length,
                                    primary: false,
                                    shrinkWrap: true,
                                    itemBuilder: (context,index){
                                      return Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*.75,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("1 ",style: TextStyle(fontSize: 12,color: Colors.black54)),
                                                    Icon(Icons.clear,size: 17,color: Colors.black54),
                                                    SizedBox(width: 5,),
                                                    Text(" Product Name ",style: TextStyle(fontSize: 12,color: Colors.black54)),

                                                  ],
                                                ),
                                                /*   Row(
                                                    children: [
                                                      Icon(Icons.delete,size: 17,color: Colors.black54),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                    ],
                                                  ),*/
                                                Text("80 LE",style: TextStyle(fontSize: 12,color: Colors.black54),),
                                              ],
                                            ),
                                          ),
                                          index==data.length-1?Column(
                                            children: [
                                              Divider(color: Colors.black38,thickness: 1,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*.75,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Total",style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),),
                                                    /*   Row(
                                                    children: [
                                                      Icon(Icons.delete,size: 17,color: Colors.black54),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                    ],
                                                  ),*/
                                                    Text("80 LE",style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ):SizedBox()
                                        ],
                                      );
                                    }),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                            ],)
                      ),
                    ],
                  ),

                ),
                );
              })):Expanded(
                child: Container(
                    padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.1),child: Center(
                  child: Column(
                    children: [
                      Image.asset("images/orders.png",color: Colors.black26,
                        height: MediaQuery.of(context).size.height*.3,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.035,),
                      Text("No Orders ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26),),
                      SizedBox(height: MediaQuery.of(context).size.height*.035,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(HomePage(4)));
                        },
                        child: DottedBorder(
                            color: Colors.black26,
                            strokeWidth: 1.5,
                            child: Container(
                              width: MediaQuery.of(context).size.width*.6,
                              height: MediaQuery.of(context).size.height*.06,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                //  border: Border.all(width: 1.0,color: Colors.black26)
                              ),
                              child: Text("shopping Now ",style: TextStyle(fontSize: 12),),
                            )

                        ),
                      )
                    ],
                  ),
                )),
              )
            ],
          ),
        ),

    ));
  }
}