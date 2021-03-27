import 'package:ashmool/GlobalFunction.dart';
import 'package:ashmool/Model/SubCategoryModel.dart';
import 'package:ashmool/Screens/CustomText.dart';
import 'package:ashmool/Services/CategoryServices.dart';
import 'package:ashmool/Services/GlobalVarible.dart';
import 'package:ashmool/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GetAllProduct.dart';

class SearchSubCategory extends StatefulWidget{
  var id;
  SearchSubCategory(var id){
    this.id=id;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.id);
  }
}
class _state extends State<SearchSubCategory>{
  var id;
  _state(var id){
    this.id=id;
  }
  home  h=new home();
  List<SubCategoryDetail>subCategories=[];
  TextEditingController searchKey=new TextEditingController();
  CategoryServices categoryServices=new CategoryServices();
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    subCategories=await categoryServices.getSubCategory("en",id);
    setState(() {

    });
    print(subCategories.length);
    print("sssssssssssssssssssssssss");
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
        body: Column(
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
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width*.7,
                      height: MediaQuery.of(context).size.height*.05,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        enabled: false,
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
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*.03,),
                  Icon(Icons.shopping_cart,size: 25,),
                  Icon(Icons.menu)
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.015,),
            subCategories.length==null?
            Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width*.7,
                  child: Center(child: CircularProgressIndicator(),)),
            ):subCategories.length==0?
            Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height*.7,
                  width: MediaQuery.of(context).size.width*.7,
                  child: Center(child: Text("No Sub Category For This Category",style: TextStyle(height: 1.7,fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),textAlign: TextAlign.center,),)),
            )
                :Expanded(child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*.05,
                    right: MediaQuery.of(context).size.width*.05,
                    top: MediaQuery.of(context).size.height*.02
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child:GridView.builder(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*.03,
                      right: MediaQuery.of(context).size.width*.03,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1/1.25
                    ),
                    itemCount: subCategories.length,
                    itemBuilder: (context,index){
                      return  GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(AllProduct(subCategories[index].id,subCategories[index].name,"category")));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.black12,width: 1)
                          ),
                          // padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  child:  Image.network(GlobalVariable.URl+subCategories[index].photo,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(height: 3,),
                              Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Text(subCategories[index].name,style: TextStyle(fontSize: 10,color: Colors.black87),maxLines: 2,textAlign: TextAlign.center,)),
                              SizedBox(height: 3,),
                            ],
                          ),
                        ),
                      );
                    }

                ),
              ),
            )),
          ],
        )
    ));
  }
}