
import 'package:flutter/material.dart';
import 'package:Tourism_App/screens/home_screen.dart';

import 'login.dart';
import 'signup.dart';
import 'home_screen.dart';
import 'hotelDetails_screen.dart';
import 'hotelsList_screen.dart';
void main() => runApp(TourismApp());




class TourismApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'TourismApp UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
     //   primaryColor: Color(0xff3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: Login(),
      routes: {
        Login.routeName : (ctx) => Login(),
        SignUp.routeName :(ctx) => SignUp(),
        HomeScreen.routeName :(ctx) =>HomeScreen(),
        HotelsDetailsScreen.routeName:(ctx) =>HotelsDetailsScreen(),
        HotelsListScreen.routeName :(ctx) =>HotelsListScreen(),

        
        
        
        
        
      },
    );
  }
}