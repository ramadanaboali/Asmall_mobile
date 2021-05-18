import 'package:ashmall/Screens/ChooseAddress.dart';
import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Screens/Orders.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../DbHelper.dart';
import '../GlobalFunction.dart';
import '../Model/CartModelLocal.dart';
import '../main.dart';
import 'Login.dart';


class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Cart> {
  home h=new home();
  int counter=1;
  ProductServices productServices =new ProductServices();

  int totalquantity=0;
  double allPrice=0.0;
  List dataLocal=[];
  DbHelper db=new DbHelper();
  String address_id;
  String user_id;
  var lang;
  loadData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    dataLocal=await db.allProduct();
    setState(() {
      user_id=prefs.getString("id");
      address_id=prefs.getString("address_id");
      lang=prefs.getString("lang");
    });
    print(dataLocal.length.toString());
    print("ssssssssssssssssssssss");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    getTotal();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
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
                      child: Icon(lang=="en"?Icons.arrow_back_ios_rounded:Icons.arrow_forward_ios_rounded,color: Colors.white,size: 25,)),
                  Text(DemoLocalizations.of(context).title["ShoopingCart"],style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamedAndRemoveUntil(context, "/notification", (route) => false);
                      },
                      child: Icon(Icons.notifications,color: Colors.white,size: 25,))
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: db.allProduct(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return snapshot.data.length==0?Container(
                          padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.15),child: Center(
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(1000)),
                                child: Image.asset("images/logo.png",color: Color(h.mainColor),
                                height: MediaQuery.of(context).size.height*.25,
                                )),
                            SizedBox(height: MediaQuery.of(context).size.height*.035,),
                            Text(DemoLocalizations.of(context).title["NoItemsInYourCart"],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26),),
                            SizedBox(height: MediaQuery.of(context).size.height*.035,),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
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
                                    child: Text(DemoLocalizations.of(context).title["ShppingNow"],style: TextStyle(fontSize: 12),),
                                  )

                              ),
                            )
                          ],
                        ),
                      )):
                      ListView.builder(
                        itemCount: snapshot.data.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                          CartMedelLocal c=new CartMedelLocal.fromMap(snapshot.data[index]);
                          return Container(
                            padding: EdgeInsets.only(
                              // left: MediaQuery.of(context).size.width*.02,
                              // right: MediaQuery.of(context).size.width*.02,
                              //top: MediaQuery.of(context).size.height*.005,
                              //bottom: MediaQuery.of(context).size.height*.005
                            ),
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height*.007,
                                bottom: MediaQuery.of(context).size.height*.007,
                                left: MediaQuery.of(context).size.width*.04,
                                right:  MediaQuery.of(context).size.width*.04
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(width: 1.0,color: Colors.black12.withOpacity(.07)),
                                color: Colors.black12.withOpacity(.05),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.05),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(3, 3), // changes position of shadow
                                  ),
                                ]
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        //  top: MediaQuery.of(context).size.height*.003
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            // margin: EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                color: Colors.white
                                            ),
                                            width: MediaQuery.of(context).size.width*.22,
                                            height: MediaQuery.of(context).size.height*.1,
                                            margin: EdgeInsets.only(
                                              left:  MediaQuery.of(context).size.width*.028,
                                              // right:   MediaQuery.of(context).size.width*.028,
                                              //top: MediaQuery.of(context).size.height*.015,
                                              //  bottom: MediaQuery.of(context).size.height*.015,
                                            ),
                                            child: Image.network(GlobalVariable.URl+c.img,
                                              width: MediaQuery.of(context).size.width*.15,
                                              height: MediaQuery.of(context).size.height*.16,
                                              fit: BoxFit.cover,

                                            ),

                                          ),
                                          SizedBox(width: 8,),
                                          Container(
                                            height: MediaQuery.of(context).size.height*.12,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height:  MediaQuery.of(context).size.height*.005,),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*.62,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(c.name,style: TextStyle(height: 1.0,fontSize: 14,color: Color(h.mainColor)),),
                                                      Container(
                                                        margin: EdgeInsets.zero,
                                                        alignment: Alignment.topLeft,
                                                        child: InkWell(child: Icon(Icons.delete,size: 20,color: Color(h.mainColor),),
                                                          onTap: (){
                                                            DeleteFromCart(context, c.id, c.quantity, c.totalPrice);
                                                          },
                                                        ),
                                                      ),
                                                    ],),
                                                ),
                                                SizedBox(height:  MediaQuery.of(context).size.height*.00,),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*.5,
                                                  child: Text(c.description,style: TextStyle(height: 1.0,fontSize: 11,color: Colors.black38),maxLines: 2,
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*.62,
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(c.price.toString()+"",style: TextStyle(color: Colors.black,fontSize: 11),),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: (){
                                                              CartMedelLocal cartLDBModel = CartMedelLocal({
                                                                'id':c.id,
                                                                'name': c.name,
                                                                'img':  c.img,
                                                                'price': c.price,
                                                                'description':c.description,
                                                                'quantity': c.quantity+1,

                                                              });

                                                              setState(() {
                                                                db.updateCourse(cartLDBModel);
                                                                updateTotal(1, c.price);
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 18,
                                                              height: 18,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                                                  border: Border.all(color: Colors.blue,width: 1.0),
                                                                  color: Colors.white
                                                              ),
                                                              alignment: Alignment.center,
                                                              child: Icon(Icons.add,size: 16,color: Colors.blue,),
                                                            ),
                                                          ),
                                                          SizedBox(width: 5,),
                                                          Container(
                                                            width: 23,
                                                            height: 23,
                                                            alignment: Alignment.topCenter,
                                                            child: Text(c.quantity.toString(),style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.bold),),
                                                          ),
                                                          SizedBox(width: 5,),
                                                          InkWell(
                                                            onTap: (){
                                                              CartMedelLocal cartLDBModel = CartMedelLocal({
                                                                'id':c.id,
                                                                'name': c.name,
                                                                'img':  c.img,
                                                                'price': c.price,
                                                                'description':c.description,
                                                                'quantity': c.quantity-1,
                                                              });

                                                              if(c.quantity>1){
                                                                setState(() {
                                                                  db.updateCourse(cartLDBModel);
                                                                  updateTotal(-1, -c.price);
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 18,
                                                              height: 18,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(500)),
                                                                  border: Border.all(color: Color(h.mainColor),width: 1.0),
                                                                  color: Colors.white
                                                              ),
                                                              alignment: Alignment.center,
                                                              child: Icon(Icons.remove,size: 16,color: Color(h.mainColor),),

                                                            ),
                                                          ),

                                                        ],
                                                      )

                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height:  MediaQuery.of(context).size.height*.01,),

                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
            dataLocal.length>0? Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width*.05,
                right: MediaQuery.of(context).size.width*.05,
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DemoLocalizations.of(context).title["billdetails"],style: TextStyle(fontSize: 12,color:Colors.black),)                      ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.005,),
                  Divider(color: Colors.black26,height: 1,),
                  SizedBox(height: MediaQuery.of(context).size.height*.005,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DemoLocalizations.of(context).title["totalorders"],style: TextStyle(fontSize: 12,color:Colors.black),),
                      Text(allPrice.toString(),style: TextStyle(fontSize: 12,color:Colors.black),)
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.005,),
                  Divider(color: Colors.black26,height: 1,),
                  SizedBox(height: MediaQuery.of(context).size.height*.005,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DemoLocalizations.of(context).title["totalquantity"],style: TextStyle(fontSize: 12,color:Colors.black),),
                      Text(totalquantity.toString(),style: TextStyle(fontSize: 12,color:Colors.black),)
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.005,),
                  Divider(color: Colors.black26,height: 1,),
                  SizedBox(height: MediaQuery.of(context).size.height*.005,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DemoLocalizations.of(context).title["total"],style: TextStyle(fontSize: 12,color: Color(h.mainColor),),),
                      Text((allPrice).toString(),style: TextStyle(fontSize: 12,color: Color(h.mainColor)),)
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(
                       bottom: 10
                      ),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      height: MediaQuery.of(context).size.height*.05,
                      //  width: MediaQuery.of(context).size.width*.8,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.07,
                        right: MediaQuery.of(context).size.width*.07,
                      ),
                      child: Text(DemoLocalizations.of(context).title["continuetopurchase"],style: TextStyle(color:Colors.white,fontSize: 14),),

                    ),
                    onTap: ()async{
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                        loadData();
                        if(user_id!=null){
                          if(address_id!=null){

                            List Items=new List();
                            List<Map<String,dynamic>>list2=[];
                            for(int i=0;i<dataLocal.length;i++){
                              CartMedelLocal c=new CartMedelLocal.fromMap(dataLocal[i]);
                              AddOrderDetail a=new AddOrderDetail(ProductId:c.id, Quantity:int.parse(c.quantity.toString()));
                              Items.add(a.toJson());
                            }
                            print(Items);
                            // Map<String, dynamic> result = Map.fromIterable(Items, key: (v) => v.ProductId.toString(), value: (v) => v.Quantity.toString());
                            Map<String,dynamic>data=await productServices.addOrders(lang, prefs.getString("id"), allPrice, prefs.getString("address_id"), Items);
                           if(data["status"]==200){
                             Toast.show(
                                 "${data["message"]}", context,
                                 duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                Navigator.push(context, GlobalFunction.route(Orders()));
                                int i=await db.deleteCart();
                                setState(() {
                                });
                            }
                          }
                          else{
                            Navigator.push(context, GlobalFunction.route(ChooseAddress()));
                          }
                        }
                        else{
                          Navigator.push(context, GlobalFunction.route(Login()));
                        }

                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.01,),
                ],
              ),
            ):SizedBox()

          ],
        ),

      ),
    );
  }



  getTotal()
  async {
    //totalquantity=0;
    //allPrice=0.0;
    List product=await db.allProduct();
    for(int i=0;i<product.length;i++){
      CartMedelLocal c=new CartMedelLocal.fromMap(product[i]);
      totalquantity=totalquantity+int.parse(c.quantity.toString());
      allPrice=allPrice+double.parse((c.price*c.quantity).toString());
      print(totalquantity);
      print("qqqqqqqqqqqqqqqq");
      setState(() {
      });
    }
    print(totalquantity);
    print("00000000000000000000000");
  }
  updateTotal(int q,double p){
    totalquantity+=q;
    allPrice+=p;
    setState(() {

    });
  }
  DeleteFromCart(BuildContext context,id,int quantity,double totalPrice) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            height: 110.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12,width: 2.0)
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center
                ,crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(alignment: Alignment.center,child: Text("تـأكيد الحذف من سلة المشتريات",textAlign: TextAlign.center,)),
                  SizedBox(height: 25,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(

                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:Colors.blue
                            ),
                            height: MediaQuery.of(context).size.height*.035,
                            width: MediaQuery.of(context).size.width*.27,
                            alignment: Alignment.center,
                            child:   Text( "الغاء",style: TextStyle(color:Colors.white,fontSize: 8),),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:Color(h.mainColor)
                            ),
                            height: MediaQuery.of(context).size.height*.035,
                            width: MediaQuery.of(context).size.width*.27,
                            alignment: Alignment.center,
                            child:   Text("تـأكيد",style: TextStyle(color:Colors.white,fontSize: 8),),
                          ),
                          onTap: () async {

                            setState(() {
                              db.delete(id);
                            });
                            loadData();
                            updateTotal(-quantity, -totalPrice);
                            Navigator.pop(context);
                          },
                        ),

                      ],
                    ),
                  )
                ],
              ),


            ],),
          ),
        ));
  }

}
