import 'Screens/MainProfile.dart';
import 'Screens/Profile.dart';
import 'file:///D:/projects/ashmall/lib/Screens/Cart.dart';
import 'file:///D:/projects/ashmall/lib/Screens/MainPage.dart';
import 'package:flutter/material.dart';
import 'Screens/Login.dart';
import 'Screens/Notifications.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  int index;
  HomePage(int index){
    this.index=index;
  }
  @override
  _State createState() => _State(this.index);
}
class _State extends State<HomePage> {
  int _currentIndex;
  _State(int index){
    this._currentIndex=index;
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  home h=new home();
  List<Widget>itemsUi=[
    MainPage(),
    Notifications(),
    Cart(),
    MainProfile(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(h.mainColor),
      key: _scaffoldKey,
      body:itemsUi[_currentIndex],bottomNavigationBar:
      BottomNavigationBar(
          elevation: 15.5,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(h.redColor),
          unselectedItemColor: Colors.black54
          ,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              // print('${index}index');
            });
          },
          items: [
            BottomNavigationBarItem(
                icon:_currentIndex==0?Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                    color: _currentIndex==0?Color(h.mainColor):Colors.black54
                  ),
                  padding: EdgeInsets.all(3),
                  child: ClipRRect(
                    child: Image.asset("images/logo.png",color: Colors.white,),
                  ),
                ):Icon(Icons.home_outlined,size: 33,),
                title:  Text("",style: TextStyle(fontSize: 0),)),
            BottomNavigationBarItem(
                icon:  Icon(Icons.notifications,size: 30,),
                title: Text("",style: TextStyle(fontSize: 0),)),
            BottomNavigationBarItem(
                icon:  Icon(Icons.shopping_cart_outlined,size: 30,),
                title: Text("",style: TextStyle(fontSize: 0),)),
            BottomNavigationBarItem(
                icon:Icon(Icons.person_outline_outlined,size: 30,),
                title:  Text("",style: TextStyle(fontSize: 0),)),





          ]),



    );
  }
}