import 'dart:convert';
import '../models/Provider_File.dart';
import 'package:provider/provider.dart';

import '../screens/hotelDetails_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SeeAllHotelsScreen extends StatefulWidget {
  static const routeName = '/SeeAllHotelScreen';

  @override
  _SeeAllHotelsScreenState createState() => _SeeAllHotelsScreenState();
}

class _SeeAllHotelsScreenState extends State<SeeAllHotelsScreen> {
  // List _hotels;
  // List get hotelsData => _hotels;

  // set hotelsDataSetter(List hotels) {
  //   setState(() {
  //     _hotels = hotels;
  //   });
  // }

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  // Future<String> seeAllHotels() async {
  //   final response = await http.get('${_serverUrl}api/Hotel/SeeAllHotels');

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _hotels = json.decode(response.body);
  //     });

  //     return null;
  //   } else {
  //     throw Exception('Failed to Get hotels');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var globalProvider = Provider.of<GlobalProvider>(context);
    if (globalProvider.topHotelsData != null) {
      return Scaffold(
          appBar: AppBar(title: Text("أفضل الفنادق")),
          body: Container(
          height: 800.0,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: globalProvider.topHotelsData.length,
            itemBuilder: (BuildContext context, int index) {
              Map topHotel = globalProvider.topHotelsData[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => HotelDetailsScreen(
                            hotelId: topHotel["hotelId"],
                            hotelImage: topHotel["mainHotelImage"])),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: 240.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 120.0,
                          width: 240.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    topHotel["hotelName"].toString(),
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2),
                                  ),
                                  SizedBox(height: 2.0),
                                  Text(
                                    topHotel["cityName"].toString(),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: .1),
                                  Text(
                                    'ج ${topHotel["pricePerNight"].toString()}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                              )
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            _serverUrl + topHotel["mainHotelImage"].toString(),
                            height: 180.0,
                            width: 220.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
      );
    }
  }
}