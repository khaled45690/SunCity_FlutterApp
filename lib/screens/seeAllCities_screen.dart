import 'dart:convert';
import '../models/Provider_File.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../screens/cityTours_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SeeAllCitiesScreen extends StatefulWidget {
  static const routeName = '/SeeAllCitiesScreen';

  @override
  _SeeAllCitiesScreenState createState() => _SeeAllCitiesScreenState();
}

class _SeeAllCitiesScreenState extends State<SeeAllCitiesScreen> {
  List _cities;
  List get hotelsData => _cities;

  set hotelsDataSetter(List cities) {
    setState(() {
      _cities = cities;
    });
  }

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  // Future<List> seeAllCities() async {
  //   final response = await http.get('${_serverUrl}api/City/SeeAllCities');

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _cities = json.decode(response.body);
  //     });

  //    // return null;
  //   } else {
  //     throw Exception('Failed to Get hotels');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //var cities = seeAllCities();
//print(cities);
   // if (cities = null) {
     // if (_cities != null) {

        var globalProvider = Provider.of<GlobalProvider>(context);

    if(globalProvider.topCitiesData != null) {
        return Scaffold(
          appBar: AppBar(title: Text("أفضل المدن")),
          body:  Container(
              height: 800.0,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: globalProvider.topCitiesData.length,
                itemBuilder: (BuildContext context, int index) {

                  Map cities = globalProvider.topCitiesData[index];
  
                  return GestureDetector(
                   onTap: ( ) {
                       Navigator.push(

                    context,
                    MaterialPageRoute(

                      builder: (_) =>  CityToursScreen(cityId: cities["cityId"] , cityImage: cities["image"]),

                    ),

                  );

                   } ,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      width: 400.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                            bottom: 15.0,
                            child: Container(
                              height: 120.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        '${cities["toursCount"].toString()} عدد الرحلات',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2),
                                      ),
                                      Text(
                                        '${cities["description"].toString()}',
                                        style: TextStyle(color: Colors.grey),
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
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                   _serverUrl + cities["image"].toString(),
                                    height: 180.0,
                                    width: 180.0,
                                    fit: BoxFit.cover,
                                  ) ,
                                ),
                                Positioned(
                                  left: 10.0,
                                  bottom: 10.0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        cities["cityName"].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.locationArrow,
                                            size: 10.0,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            cities["countryName"].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ))
        );
      // } else {
      //   return Container();
      // }
      }
    }
  }

//     } 
//else {
//       return Container();
//     }
//   }
// }
