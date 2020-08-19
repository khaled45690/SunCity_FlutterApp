
import 'package:flutter/material.dart';
import 'package:SunCity_FlutterApp/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:SunCity_FlutterApp/models/Provider_File.dart';
import 'login.dart';
import 'signup.dart';
import 'home_screen.dart';
import 'hotelDetails_screen.dart';
import 'hotelsList_screen.dart';
void main() =>{

  runApp(
    ChangeNotifierProvider( create: (context) => GlobalProvider(),
    child: SunCity_FlutterApp(),
    ),

)

};

//update


class SunCity_FlutterApp extends StatelessWidget {

String cityId;
SunCity_FlutterApp({this.cityId});
  @override
  Widget build(BuildContext context) {
    var globalProvider = Provider.of<GlobalProvider>(context);
    globalProvider.getMainData();
    globalProvider.getTopHotels();
    globalProvider.getToursByCityId(cityId.toString());  //'e86e901b-42f8-4af5-b97a-0867e31c4e92'
  
    return MaterialApp(

      title: 'SunCity_FlutterApp UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
     //   primaryColor: Color(0xff3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName :(ctx) =>HomeScreen(),
        Login.routeName : (ctx) => Login(),
        SignUp.routeName :(ctx) => SignUp(),
        HotelsDetailsScreen.routeName:(ctx) =>HotelsDetailsScreen(),
        HotelsListScreen.routeName :(ctx) =>HotelsListScreen(),

      },
    );
  }
}