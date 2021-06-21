import 'package:ashmall/Model/ProductModel.dart';
import 'package:ashmall/Model/VendorModel.dart';
import 'package:ashmall/Screens/CustomSearchAppBar.dart';
import 'package:ashmall/Screens/ProductsHome.dart';
import 'package:ashmall/Services/ProductServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalFunction.dart';

class VendorCategory extends StatefulWidget{
  List<SubCategoryVm>vendorCategory;
  var vendor_id;
  VendorCategory(var vendor_id,List<SubCategoryVm>vendorCategory){
    this.vendorCategory=vendorCategory;
    this.vendor_id=vendor_id;
  }
  @override
  State<StatefulWidget> createState() {
   return _state(this.vendor_id,this.vendorCategory);
  }
}
class _state extends State<VendorCategory>{
  List<SubCategoryVm>vendorCategory;
  List<ProductDetail>products=[];
  var vendor_id;
  ProductServices productServices=new ProductServices();
  _state(var vendor_id,List<SubCategoryVm>vendorCategory){
    this.vendorCategory=vendorCategory;
    this.vendor_id=vendor_id;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              CustomSearchAppBar(),
              Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*.05,
                      right: MediaQuery.of(context).size.width*.05,
                      top: MediaQuery.of(context).size.height*.01,
                      bottom: MediaQuery.of(context).size.height*.01
                  ),
                  child:Row(
                    children: [
                      Text("Vendor Category"),
                    ],
                  )
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*.05,
                      right: MediaQuery.of(context).size.width*.05,
                    ),
                    itemCount: vendorCategory.length,itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: ()async{
                      SharedPreferences pref=await SharedPreferences.getInstance();
                      products=await productServices.getProductVendorCategory(pref.getString("lang"), vendor_id, vendorCategory[index].id);
                      print(products.length);
                      Navigator.push(context, GlobalFunction.route(ProductsHome(products,vendorCategory[index].name)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black12
                      ),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height*.01
                      ),
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.05,
                        right: MediaQuery.of(context).size.width*.05,
                        top: MediaQuery.of(context).size.height*.01,
                        bottom: MediaQuery.of(context).size.height*.01
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(vendorCategory[index].name),
                        //  Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
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