import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';
import 'package:SunCity_FlutterApp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  //String _serverUrl = "http://algosys-001-site16.ctempurl.com/";
  String _serverUrl = "http://192.168.1.107:5001/";

  String _token;

  String get token => _token;

  var _profile;

  String get hotelData => _profile;

  set token(String token) {
    setState(() {
      _token = token;
    });
  }

  set profileDataSetter(var profile) {
    setState(() {
      _profile = profile;
    });
  }

  Future<String> appDrawerData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getString("token");
    String token = "Bearer ${sharedPreferences.getString("token")}";

    print(
        "Token = ***************************************************** $token ******************************************************");
    final response = await http.get(
      '${_serverUrl}api/Client/ClientAppDrawerData',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      },
    );

    print("****************************************${response.statusCode}***********************************************");

    if (response.statusCode == 200) {
      setState(() {
        _profile = json.decode(response.body);
        _token = token;
        print(_profile);
      });

      //return response.toString();
    } else {
      throw Exception('Failed to Get profile datta');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appDrawerData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      // Image.asset( "assets/Images/beach_23-wallpaper-1366x768.jpg"
      new UserAccountsDrawerHeader(
        accountName: Text("مرحباا"),
        accountEmail: Text(_profile == null
            ? "SunCity User"
            : _profile["clientName"].toString()),
        currentAccountPicture: GestureDetector(
          child: _profile != null ?  CircleAvatar(
             
            backgroundImage: NetworkImage(_serverUrl + _profile["profileImage"].toString())
                 
          ): CircleAvatar(
             
            backgroundImage: AssetImage("assets/Images/beach_23-wallpaper-1366x768.jpg"),

                 
          ),
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
      // InkWell(
      //   child: ListTile(
      //     title: Text("الدعم الفني"),
      //     leading: Icon(
      //       Icons.timeline,
      //       color: Colors.blue,
      //     ),
      //   ),
      // ),
      InkWell(
        onTap: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          _token != null
              ? sharedPreferences.remove("token")
              : Navigator.of(context).pushNamed(Login.routeName);
        },
        child: ListTile(
          title: Text(_token != null ? "تسجيل الخروج" : "تسجيل الدخول"),
          leading: Icon(
            Icons.close,
            color: Colors.blue,
          ),
        ),
      ),
    ]));
  }
}
