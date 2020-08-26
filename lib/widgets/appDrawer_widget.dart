//import 'package:authapp/view/about_view.dart';
//import 'package:authapp/view/login_view.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';
import 'package:SunCity_FlutterApp/screens/login.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //  FirebaseUser user;

  @override
  // void initState() {
  //   super.initState();
  //   initUser();
  // }
  // initUser() async{
  //   user =await _auth.currentUser();
  //   setState(() {

  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      new UserAccountsDrawerHeader(
        //"${user?.displayName}"
        accountName: Text("مرحباا"),
        accountEmail: Text("SunCity@User.com"),
        currentAccountPicture: GestureDetector(
          child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue)),
        ),
        decoration: new BoxDecoration(color: Color(0xff3EBACE)),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          );
        },
        child: ListTile(
          title: Text("الرئيسيه"),
          leading: Icon(
            Icons.home,
            color: Colors.blue,
          ),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProfileScreen(),
            ),
          );
        },
        child: ListTile(
          title: Text("الحساب"),
          leading: Icon(
            Icons.account_circle,
            color: Colors.blue,
          ),
        ),
      ),
      InkWell(
        child: ListTile(
          title: Text("الدعم الفني"),
          leading: Icon(
            Icons.timeline,
            color: Colors.blue,
          ),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Login.routeName);
        },
        child: ListTile(
          title: Text("تسجيل الدخول"),
          leading: Icon(
            Icons.close,
            color: Colors.blue,
          ),
        ),
      ),
    ]));
  }
}
