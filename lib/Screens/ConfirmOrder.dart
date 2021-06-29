import 'package:ashmall/Model/CityModel.dart';
import 'package:ashmall/Model/ZoneModel.dart';
import 'package:ashmall/Services/GlobalVarible.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:ashmall/utils/app_Localization.dart';
import 'CartOrder.dart';
import 'CustomAppBar.dart';
import 'package:dotted_line/dotted_line.dart';
import '../Model/AddressModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';
import '../Services/AddressServices.dart';
import 'package:toast/toast.dart';
import '../main.dart';
import 'CustomAppBar.dart';
import '../GlobalFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ConfirmOrder3 extends StatefulWidget{
  int index;
  ConfirmOrder3(int index){
    this.index=index;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.index);
  }
}
class _state extends State<ConfirmOrder3>{
  int index;
  _state(int index){
    this.index=index;
  }
  home h=new home();
  String delevery = "delivery1";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<AddressModel>addressList;
  AddressServices addressServices=new AddressServices();
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
  String     payment = "payment1";
  List <AddressDetail>addresses;

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
  int selected=1;
  List <String>data=["5","5","5","5"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    List <Widget>content=[
      Container(
        padding: EdgeInsets.only(
          left:  MediaQuery.of(context).size.width*.05,
          right: MediaQuery.of(context).size.width*.05,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.08,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1000)),
                border: Border.all(color: Colors.green,width: 3),),
              padding: EdgeInsets.all(2),
              child: ClipRRect
                (
                borderRadius: BorderRadius.all(Radius.circular(5000)),
                child: FadeInImage.assetNetwork(
                  placeholder: "images/Photo.png",
                  image:ParentPage.userimage==null?"":GlobalVariable.URL2+ParentPage.userimage,
                  width: MediaQuery.of(context).size.width*.22,
                  height: MediaQuery.of(context).size.width*.22,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Divider(color: Colors.black26,thickness: 1,),
            SizedBox(height: 10,),
            Container(
              height:MediaQuery.of(context).size.height*.065,
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12.withOpacity(.05),width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.05),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*.3,
                    child: Text(DemoLocalizations.of(context).title['name'],style: TextStyle(fontSize: 12),),
                  ),
                  Text(ParentPage.username,style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height:MediaQuery.of(context).size.height*.065,
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12.withOpacity(.05),width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.05),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*.3,
                    child: Text(DemoLocalizations.of(context).title['phone'],style: TextStyle(fontSize: 12)),
                  ),
                  Text(ParentPage.phone,style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height:MediaQuery.of(context).size.height*.065,
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12.withOpacity(.05),width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.05),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*.3,
                    child: Text(DemoLocalizations.of(context).title['email'],style: TextStyle(fontSize: 12)),
                  ),
                  Text(ParentPage.email,style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            SizedBox(height: 25,),
          ],
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                       Container(
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
                            child: Text(DemoLocalizations.of(context).title['NoAddresses'],style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                          ),
                        ):
                        Container(
                          child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: addresses.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: ()async{
                                    SharedPreferences prefs=await SharedPreferences.getInstance();
                                    prefs.setString("address_id", addresses[index].id);
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
                                            Radio(value: addresses[index].id,groupValue: SelectedAddress,onChanged: (val)async{
                                              SharedPreferences prefs=await SharedPreferences.getInstance();
                                              prefs.setString("address_id", addresses[index].id);
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
                                    loadData();
                                    setState(() {
                                      formAddress=false;
                                      SelectedAddress=asd["data"]["id"];
                                    });
                                    Toast.show(
                                        "${asd["message"]}", context,
                                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                    SetData("address_id", asd["data"]["id"]);
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                  /*      GestureDetector(
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

                            Navigator.pop(context);
                            setState(() {
                            });

                          },
                        ),*/
                        GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:Color(h.mainColor)
                            ),
                            height: MediaQuery.of(context).size.height*.05,
                            width: MediaQuery.of(context).size.width*.6,
                            margin: EdgeInsets.only(top: 25),
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
            ],

          ),
        ),
      ),
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.18,),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*.01,
                bottom: MediaQuery.of(context).size.height*.01,
                left: MediaQuery.of(context).size.width*.05,
                right: MediaQuery.of(context).size.width*.05
            ),
            child: Row(
              children: [
                Text(DemoLocalizations.of(context).title['ShippingMethod'],style: TextStyle(fontSize:16),),
              ],
            )
          ),
          //SizedBox(height: MediaQuery.of(context).size.height*.02,),
          Container(
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12.withOpacity(.1),width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height*.02,
              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context, GlobalFunction.route(PaymentMethod()));
                      setState(() {
                        delevery = "delivery1";
                      });
                    },
                    child: Container(
                        height: 30,
                        // color: Colors.red,
                        child:Row(children: [
                          SizedBox(width: 10,),
                          Radio(
                            activeColor: Color(h.mainColor),
                            value: "delivery1",
                            groupValue: delevery,
                            onChanged: (String value) {
                              setState(() {
                                delevery=value;
                              });
                            },
                          ),Text(DemoLocalizations.of(context).title['Shippingbymerchant'],maxLines: 1,style: TextStyle(height: 1,color: Colors.black,fontSize: 12)),
                        ],)
                    ),
                  ),
                  SizedBox(height: 0,),
                  Divider(color: Colors.black12.withOpacity(.1),thickness: 1,),
                  SizedBox(height: 0,),
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                      setState(() {
                      //  delevery = "delivery2";
                      });
                    },
                    child: Container(
                        height: 30,
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Radio(
                              activeColor: Color(h.mainColor),
                              value: "delivery2",
                              groupValue: delevery,
                              onChanged: (String value) {
                                setState(() {
                                //  delevery = value;
                                });
                              },
                            ),
                            Text(DemoLocalizations.of(context).title['Shippingbyshippingcompany'],maxLines: 1,style: TextStyle(color: Colors.black,fontSize: 12)),
                          ],
                        )


                    ),
                  ),
                  SizedBox(height: 0,),
                ],
              )
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.18,),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*.01,
                bottom: MediaQuery.of(context).size.height*.01,
                left: MediaQuery.of(context).size.width*.05,
                right: MediaQuery.of(context).size.width*.05
            ),

            alignment: Alignment.centerRight,
            child: Row(
              children: [
                Text(DemoLocalizations.of(context).title['paymentmethod'],style: TextStyle(fontSize: 16),),
              ],
            )
          ),
          //SizedBox(height: MediaQuery.of(context).size.height*.02,),
          Container(
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12.withOpacity(.1),width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height*.02,
              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context, GlobalFunction.route(PaymentMethod()));
                      setState(() {
                        payment = "payment1";
                      });
                    },
                    child: Container(
                        height: 30,
                        // color: Colors.red,
                        child:Row(children: [
                          SizedBox(width: 10,),
                          Radio(
                            activeColor: Color(h.mainColor),
                            value: "payment1",
                            groupValue: payment,
                            onChanged: (String value) {
                              setState(() {
                                payment=value;
                              });
                            },
                          ),Text(DemoLocalizations.of(context).title['payment1'],maxLines: 1,style: TextStyle(height: 1,color: Colors.black,fontSize: 12)),
                        ],)
                    ),
                  ),
                  SizedBox(height: 0,),
                  Divider(color: Colors.black12.withOpacity(.1),thickness: 1,),
                  SizedBox(height: 0,),
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                      setState(() {
                        //payment = "payment2";
                      });
                    },
                    child: Container(
                        height: 30,
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Radio(
                              activeColor: Color(h.mainColor),
                              value: "payment2",
                              groupValue: payment,
                              onChanged: (String value) {
                                setState(() {
                                  //payment = value;
                                });
                              },
                            ),
                            Text(DemoLocalizations.of(context).title['payment2'],maxLines: 1,style: TextStyle(color: Colors.black,fontSize: 12)),
                          ],
                        )


                    ),
                  ),
                  SizedBox(height: 0,),
                ],
              )
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.02,),
        ],
      ),
      CartOrder()
    ];
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
              children: [
                CustomAppBar(DemoLocalizations.of(context).title['confirm']),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  width: MediaQuery.of(context).size.width*.82,
                  height: MediaQuery.of(context).size.height*.06,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(index>0){
                            setState(() {
                              index=1;
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.1,
                          height: MediaQuery.of(context).size.width*.1,
                          padding: EdgeInsets.all(index>1?2:3),
                          child: Container(
                              width: 25,height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  color: index>0?Colors.green:Colors.black26
                              ),
                              child:index>1?Icon(Icons.check,color: Colors.white,):Icon(Icons.person,color: Colors.white,size: 18,)
                          ),
                        ),
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: MediaQuery.of(context).size.width*.08,
                        lineThickness: 2,
                        dashLength: 4.0,
                        dashColor: Colors.black54,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      GestureDetector(
                        onTap: (){
                        if(index>1){
                          setState(() {
                            index=2;
                          });
                        }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.1,
                          height: MediaQuery.of(context).size.width*.1,
                          padding: EdgeInsets.all(index>2?2:3),
                          child: Container(
                              width: 25,height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  color: index>1?Colors.green:Colors.black26
                              ),
                              child:index>2?Icon(Icons.check,color: Colors.white,):Icon(Icons.location_on,color: Colors.white,size: 18,)
                          ),
                        ),
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: MediaQuery.of(context).size.width*.08,
                        lineThickness: 2,
                        dashLength: 4.0,
                        dashColor: Colors.black54,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      GestureDetector(
                        onTap: (){
                        if(index>2){
                          setState(() {
                            index=3;
                          });
                        }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.1,
                          height: MediaQuery.of(context).size.width*.1,
                          padding: EdgeInsets.all(index>3?2:3),
                          child: Container(
                              width: 25,height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  color: index>2?Colors.green:Colors.black26
                              ),
                              padding: EdgeInsets.all(4),
                              child:index>3?Icon(Icons.check,color: Colors.white,):ImageIcon(AssetImage("images/inWay.png"),size: 18,color: Colors.white,)
                          ),
                        ),
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: MediaQuery.of(context).size.width*.08,
                        lineThickness: 2,
                        dashLength: 4.0,
                        dashColor: Colors.black54,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      GestureDetector(
                        onTap: (){
                       if(index>3){
                         setState(() {
                           index=4;
                         });
                       }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.1,
                          height: MediaQuery.of(context).size.width*.1,
                          padding: EdgeInsets.all(index>4?2:3),
                          child: Container(
                              width: 25,height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  color: index>3?Colors.green:Colors.black26
                              ),
                              child:index>4?Icon(Icons.check,color: Colors.white,):Icon(Icons.payment,color: Colors.white,size: 18,)
                          ),
                        ),
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: MediaQuery.of(context).size.width*.08,
                        lineThickness: 2,
                        dashLength: 4.0,
                        dashColor: Colors.black54,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      GestureDetector(
                        onTap: (){
                       if(index>4){
                         setState(() {
                           index=5;
                         });
                       }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.1,
                          height: MediaQuery.of(context).size.width*.1,
                          padding: EdgeInsets.all(2),
                          child: Container(
                              width: 25,height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  color: index>4?Colors.green:Colors.black26
                              ),
                              child:Icon(Icons.check,color: Colors.white,)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*.05,),
                      Container(
                          width: MediaQuery.of(context).size.width*.18,
                          padding: EdgeInsets.only(right:  0),
                          child:Text(DemoLocalizations.of(context).title['user'],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width*.19,
                          padding: EdgeInsets.all(0),
                          child:Text(DemoLocalizations.of(context).title['address'],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width*.18,
                          padding: EdgeInsets.all(0),
                          child:Text(DemoLocalizations.of(context).title['shipping'],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width*.18,
                          padding: EdgeInsets.all(0),
                          child:Text(DemoLocalizations.of(context).title['payment'],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width*.18,
                          padding: EdgeInsets.only(left: 0),
                          child:Text(DemoLocalizations.of(context).title['confirm'],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                      ),

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  height: 1,color: Colors.black26,
                ),
                Expanded(child: content[index-1]),
                index==5?   SizedBox():
                GestureDetector(
                  onTap: ()async{
                    if(index==1){
                      setState(() {
                        index=index+1;
                      });
                    }
                    else if(index==2){
                     if(SelectedAddress!=null){
                       SetData("address_id", SelectedAddress);
                       setState(() {
                         index=index+1;
                       });
                     }else{
                       Toast.show(
                           DemoLocalizations.of(context).title['chooseaddress'], context,
                           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                     }
                    }
                    else if(index==3){
                      if(delevery==null){
                        Toast.show(
                            "من فضلك اختر طريقة الشحن", context,
                            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                      }else{
                        setState(() {
                          index=index+1;
                        });
                      }
                    }
                    else if(index==4){
                      if(payment==null){
                        Toast.show(
                            "من فضلك اختر طريقة الدفع", context,
                            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                      }else{
                        setState(() {
                          index=index+1;
                        });
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.9,
                    height: MediaQuery.of(context).size.height*.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(h.mainColor)
                    ),
                    alignment: Alignment.center,
                    child: Text(index==5?DemoLocalizations.of(context).title['confirm']:DemoLocalizations.of(context).title['next'],style: TextStyle(color: Colors.white,fontSize: 16),),
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
      ),
    );
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