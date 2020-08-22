import '../screens/cityTours_screen.dart';
import '../screens/tourDetails_screen.dart';
import '../screens/seeAllCities_screen.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../models/Provider_File.dart';
import 'login.dart';
import 'signup.dart';
import 'home_screen.dart';
import 'hotelDetails_screen.dart';
import 'seeAllHotels_screen.dart';

void main() => {
      runApp(
        ChangeNotifierProvider(
          create: (context) => GlobalProvider(),
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
    globalProvider.getTopCities();
    globalProvider.getTopHotels();

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
        HomeScreen.routeName: (ctx) => HomeScreen(),
        Login.routeName: (ctx) => Login(),
        SignUp.routeName: (ctx) => SignUp(),
        CityToursScreen.routeName: (ctx) => CityToursScreen(),
        SeeAllCitiesScreen.routeName: (ctx) => SeeAllCitiesScreen(),
        SeeAllHotelsScreen.routeName: (ctx) => SeeAllHotelsScreen(),
        TourDetailsScreen.routeName: (ctx) => TourDetailsScreen(),
        HotelDetailsScreen.routeName: (ctx) => HotelDetailsScreen(),
      },
    );
  }
}
