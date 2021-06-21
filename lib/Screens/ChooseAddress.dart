import 'package:ashmall/Model/AddressModel.dart';
import 'package:ashmall/Model/CityModel.dart';
import 'package:ashmall/Model/ZoneModel.dart';
import 'package:ashmall/Screens/CustomAppBar.dart';
import 'package:ashmall/Services/AddressServices.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../main.dart';

class ChooseAddress extends StatefulWidget{
  var type;
  ChooseAddress(var type){
    this.type=type;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.type);
  }
}
class _state extends State<ChooseAddress>{
  var type;
  _state(var type){
    this.type=type;
  }
  home h=new home();
  String SelectedAddress;
  bool formAddress=false;
  final formKey=GlobalKey<FormState>();
  TextEditingController phone=new TextEditingController();
  TextEditingController address=new TextEditingController();
  TextEditingController country=new TextEditingController();
  TextEditingController city=new TextEditingController();
  TextEditingController zone=new TextEditingController();
  FocusNode addressNode=new FocusNode();
  FocusNode countryNode=new FocusNode();
  FocusNode cityNode=new FocusNode();
  String payment="cash";
  List <AddressDetail>addresses;
  AddressServices addressServices=new AddressServices();
  SetData(key,value)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString(key, value);

  }
  var user_id;
  var lang;
  List<CityDetail>Cites=[];
  String SelectedCity;
  String SelectedCityId;
  List<ZoneDetail>zones;
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    addresses=await addressServices.getAllAddresses(prefs.getString("lang"), prefs.getString("id"));
    setState(() {
    });
    Cites=await addressServices.GetCities();
    setState(() {
      user_id=prefs.getString("id");
      lang=prefs.getString("lang");
      country.text="مصر";
    });
    print(Cites.length);
    print("ssssssssssssssssssssssssssssss");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
   return SafeArea(child: Scaffold(
     body: Container(
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
       child: SingleChildScrollView(
         child: Column(
           children: [
               CustomAppBar(DemoLocalizations.of(context).title['ChooseAddress']),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*.05,
                  right: MediaQuery.of(context).size.width*.05
                ),
                child: Column(
                  children: [
                    formAddress?SizedBox(): Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                        type=="Profile"?SizedBox():  Container(
                        height: MediaQuery.of(context).size.height*.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black12,
                      ),
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child:Row(
                        children: [
                          Text(DemoLocalizations.of(context).title['selectAddress'],style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    addresses==null? Container(
                      height: MediaQuery.of(context).size.height*.25,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ):addresses.length==0?Container(
                      height: MediaQuery.of(context).size.height*.25,
                      child: Center(
                        child: Text("No Addresses For You",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                      ),
                    ):
                    Container(
                      child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: addresses.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  SelectedAddress=addresses[index].id;
                                });
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Radio(value: addresses[index].id,groupValue: SelectedAddress,onChanged: (val){
                                          setState(() {
                                            SelectedAddress=addresses[index].id;
                                          });
                                        },),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(addresses[index].country==null?"":addresses[index].country+"-"+addresses[index].city,style: TextStyle(color:  SelectedAddress==addresses[index].id?Color(h.mainColor):Colors.black54,fontSize: 13,fontWeight: FontWeight.bold),),
                                            SizedBox(height: 2.5,),
                                            Text(addresses[index].address,style: TextStyle(color:  SelectedAddress==addresses[index].id?Color(h.mainColor):Colors.black54,fontSize: 12,),)
                                          ],
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        DeleteAddress(context,addresses[index].id);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Icon(Icons.delete,color: Color(h.mainColor),)),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  ],
                ),
                  formAddress?
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.025,
                        right: MediaQuery.of(context).size.width*.025,
                        top: MediaQuery.of(context).size.height*.01,
                        bottom: MediaQuery.of(context).size.height*.01,
                      ),
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.0,
                        right: MediaQuery.of(context).size.width*.0,
                        top: MediaQuery.of(context).size.height*.01,
                        bottom: MediaQuery.of(context).size.height*.01,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text(DemoLocalizations.of(context).title['phone'] ,style: TextStyle(fontSize: 13,color: Colors.black54,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 7,),
                            Container(
                              decoration: BoxDecoration(
                                /* borderRadius:BorderRadius.all(Radius.circular(30)),
                                color: Colors.white,*/
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                onFieldSubmitted: (value){
                                  FocusScope.of(context).requestFocus(countryNode);
                                },
                                validator: (value){
                                  if(value.isEmpty){
                                    return  DemoLocalizations.of(context).title['enterPhone'];
                                  }
                                  return null;
                                },
                                //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                decoration: InputDecoration(
                                  enabledBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.grey)
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
                                  hintText:DemoLocalizations.of(context).title['phone'] ,
                                  hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                                  suffixIconConstraints: BoxConstraints(
                                      maxHeight: 50,
                                      minHeight: 30,
                                      maxWidth: 70,
                                      minWidth: 50
                                  ) ,
                                ),
                                controller: phone,
                              ),
                            ),
                            ///////////////////
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text(DemoLocalizations.of(context).title['country'] ,style: TextStyle(fontSize: 13,color: Colors.black54,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 7,),
                            Container(
                              decoration: BoxDecoration(
                                /* borderRadius:BorderRadius.all(Radius.circular(30)),
                                color: Colors.white,*/
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                focusNode: countryNode,
                                enabled: false,
                                onFieldSubmitted: (value){
                                  FocusScope.of(context).requestFocus(cityNode);
                                },
                                validator: (value){
                                  if(value.isEmpty){
                                    return DemoLocalizations.of(context).title['enterCountry'];
                                  }
                                  return null;
                                },
                                //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                decoration: InputDecoration(
                                  disabledBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.grey)
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
                                  hintText:DemoLocalizations.of(context).title['country'] ,
                                  hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                                  suffixIconConstraints: BoxConstraints(
                                      maxHeight: 50,
                                      minHeight: 30,
                                      maxWidth: 70,
                                      minWidth: 50
                                  ) ,
                                ),
                                controller: country,
                              ),
                            ),
                            ////////////////////
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text(DemoLocalizations.of(context).title['government'] ,style: TextStyle(fontSize: 13,color: Colors.black54,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 7,),
                            GestureDetector(
                              onTap: (){
                                SelectCity(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  /* borderRadius:BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white,*/
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  focusNode: cityNode,
                                  enabled: false,
                                  onFieldSubmitted: (value){
                                    FocusScope.of(context).requestFocus(addressNode);
                                  },
                                  validator: (value){
                                    if(value.isEmpty){
                                      return DemoLocalizations.of(context).title['enterCity'];
                                    }
                                    return null;
                                  },
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    disabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.grey)
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
                                    hintText:DemoLocalizations.of(context).title['government'] ,
                                    hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                                    suffixIconConstraints: BoxConstraints(
                                        maxHeight: 50,
                                        minHeight: 30,
                                        maxWidth: 70,
                                        minWidth: 50
                                    ) ,
                                  ),
                                  controller: city,
                                ),
                              ),
                            ),
                            ////////////////////
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text(DemoLocalizations.of(context).title['City'] ,style: TextStyle(fontSize: 13,color: Colors.black54,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 7,),
                            GestureDetector(
                              onTap: (){
                                SelectZone(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  /* borderRadius:BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white,*/
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  focusNode: cityNode,
                                  enabled: false,
                                  onFieldSubmitted: (value){
                                    FocusScope.of(context).requestFocus(addressNode);
                                  },
                                  validator: (value){
                                    if(value.isEmpty){
                                      return DemoLocalizations.of(context).title['enterCity'];
                                    }
                                    return null;
                                  },
                                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                  decoration: InputDecoration(
                                    disabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.grey)
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
                                    hintText:DemoLocalizations.of(context).title['City'] ,
                                    hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                                    suffixIconConstraints: BoxConstraints(
                                        maxHeight: 50,
                                        minHeight: 30,
                                        maxWidth: 70,
                                        minWidth: 50
                                    ) ,
                                  ),
                                  controller: zone,
                                ),
                              ),
                            ),
                            ////////////////////
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text(DemoLocalizations.of(context).title['zone-street'] ,style: TextStyle(fontSize: 13,color: Colors.black54,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 7,),
                            Container(
                              decoration: BoxDecoration(
                                /* borderRadius:BorderRadius.all(Radius.circular(30)),
                                color: Colors.white,*/
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                focusNode: addressNode,
                                onFieldSubmitted: (value){
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                validator: (value){
                                  if(value.isEmpty){
                                    return DemoLocalizations.of(context).title['enterAddressDetails'];
                                  }
                                  return null;
                                },
                                //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                decoration: InputDecoration(
                                  enabledBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.grey)
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
                                  hintText:DemoLocalizations.of(context).title['zone-street'] ,
                                  hintStyle: TextStyle(fontSize: 12,color: Colors.black38),

                                  suffixIconConstraints: BoxConstraints(
                                      maxHeight: 50,
                                      minHeight: 30,
                                      maxWidth: 70,
                                      minWidth: 50
                                  ) ,
                                ),
                                controller: address,
                              ),
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              child: Container(
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(h.mainColor)
                                ),
                                height: MediaQuery.of(context).size.height*.055,
                                width: MediaQuery.of(context).size.width*.7,
                                alignment: Alignment.center,
                                child:   Text(DemoLocalizations.of(context).title['add'],style: TextStyle(color:Colors.white,fontSize: 13),),
                              ),
                              onTap: () async {
                                if(formKey.currentState.validate()){
                                  Map<String,dynamic>asd=await addressServices.AddAddress(lang, user_id, phone.text, country.text, zone.text, address.text);
                                  if(asd["status"]==200){
                                    Toast.show(
                                        "${asd["message"]}", context,
                                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                    SetData("address_id", asd["data"]["id"]);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 15,),
                          ],
                        ),
                      ),
                    ):SizedBox(),
                    formAddress?SizedBox(): Row(
                      mainAxisAlignment:type=="Profile"? MainAxisAlignment.center: MainAxisAlignment.spaceBetween,
                      children: [
                        type=="Profile"? SizedBox(): GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:Color(h.mainColor)
                            ),
                            height: MediaQuery.of(context).size.height*.055,
                            width: MediaQuery.of(context).size.width*.43,
                            alignment: Alignment.center,
                            child:   Text(DemoLocalizations.of(context).title['confirm'],style: TextStyle(color:Colors.white,fontSize: 13),),
                          ),
                          onTap: () async {
                            SetData("address_id", SelectedAddress);
                            Navigator.pop(context);
                            setState(() {

                            });

                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:Color(h.mainColor)
                            ),
                            height: MediaQuery.of(context).size.height*.055,
                            width: MediaQuery.of(context).size.width*.43,
                            alignment: Alignment.center,
                            child:   Text(DemoLocalizations.of(context).title['addNewAddress'],style: TextStyle(color:Colors.white,fontSize: 13),),
                          ),
                          onTap: () async {
                           setState(() {
                             formAddress=true;
                           });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            type=="Profile"?SizedBox():Column(
              children: [
                SizedBox(height: 15,),
                Container(
                  height: MediaQuery.of(context).size.height*.05,
                  width: MediaQuery.of(context).size.width*.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black12,
                  ),
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child:Row(
                    children: [
                      Text("Select Payment Method",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black12,width: 1)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Radio(value: "cash",groupValue: payment,activeColor: Color(h.mainColor),),
                          Text("Cash on Delivery")
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Radio(value: "credit",groupValue: payment,activeColor: Color(h.mainColor),),
                          Text("By Credit Cart"),
                          SizedBox(width: MediaQuery.of(context).size.width*.05,),
                          Text("(Services not active now)",style: TextStyle(fontSize: 12,color: Color(h.mainColor)),)
                        ],
                      )
                    ],
                  ),
                )
              ],
            )

           ],

         ),
       ),
     ),
   ),);
  }
  DeleteAddress(BuildContext context,id) {
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
                  Container(alignment: Alignment.center,child: Text(DemoLocalizations.of(context).title['confrimDeleteAddress'],textAlign: TextAlign.center,)),
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
                            child:   Text( DemoLocalizations.of(context).title['cancel'],style: TextStyle(color:Colors.white,fontSize: 10),),
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
                            child:   Text(DemoLocalizations.of(context).title['confirm'],style: TextStyle(color:Colors.white,fontSize: 10),),
                          ),
                          onTap: () async {
                               Map<String,dynamic>r=await addressServices.deleteAddress("en", id);
                               if(r!=null)
                                 loadData();
                            setState(() {
                            });
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
  SelectCity(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            width: MediaQuery.of(context).size.width*.4,
            decoration: BoxDecoration(color: Colors.white,
              // borderRadius: BorderRadius.all(Radius.circular(20))
              // border: Border.all(color: Colors.black12,width: 2.0)
            )
            ,padding: EdgeInsets.only(
            top:  MediaQuery.of(context).size.height*0.01,
            bottom: MediaQuery.of(context).size.height*0.01,
            left: MediaQuery.of(context).size.width*0.05,
            right: MediaQuery.of(context).size.width*0.05,
          ),


            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(shrinkWrap: true,primary: false,
                    itemCount: Cites.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: ()async{
                          zones=await addressServices.GetCityZone(Cites[index].id);
                          setState(() {
                            city.text=Cites[index].name;
                          });
                          print(zones.length);
                          print("000000000000000000000000000000");
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.005,top: MediaQuery.of(context).size.height*.005),
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.005,top: MediaQuery.of(context).size.height*.005),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Color(h.mainColor)
                            ),
                            alignment: Alignment.center,
                            child: Text(Cites[index].name,style: TextStyle(fontSize: 16,color: Colors.white),)),
                      );
                    },
                  ),
                ],
              ),
            ),

          ),
        ));
  }
  SelectZone(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            width: MediaQuery.of(context).size.width*.4,
            decoration: BoxDecoration(color: Colors.white,
              // borderRadius: BorderRadius.all(Radius.circular(20))
              // border: Border.all(color: Colors.black12,width: 2.0)
            )
            ,padding: EdgeInsets.only(
            top:  MediaQuery.of(context).size.height*0.01,
            bottom: MediaQuery.of(context).size.height*0.01,
            left: MediaQuery.of(context).size.width*0.05,
            right: MediaQuery.of(context).size.width*0.05,
          ),


            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(shrinkWrap: true,primary: false,
                    itemCount: zones.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: ()async{
                          setState(() {
                            zone.text=zones[index].name;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.005,top: MediaQuery.of(context).size.height*.005),
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.005,top: MediaQuery.of(context).size.height*.005),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Color(h.mainColor)
                            ),
                            alignment: Alignment.center,
                            child: Text(zones[index].name,style: TextStyle(fontSize: 16,color: Colors.white),)),
                      );
                    },
                  ),
                ],
              ),
            ),

          ),
        ));
  }
}