import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HotelDetailsScreen extends StatefulWidget {
  static const routeName = '/HotelsDetailsScreen';
  final String hotelId;
  final String hotelImage;

  HotelDetailsScreen({this.hotelId, this.hotelImage});

  @override
  _HotelDetailsScreenState createState() => _HotelDetailsScreenState(
      hotelId: this.hotelId, hotelImage: this.hotelImage);
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  final String hotelId;
  final String hotelImage;
  _HotelDetailsScreenState({this.hotelId, this.hotelImage});

  var _hotel;

  String get hotelData => _hotel;

  set toursDataSetter(var hotel) {
    setState(() {
      _hotel = hotel;
    });
  }

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  Future<void> getHotelDetails(String hotelId) async {
    
    final response = await http.get('${_serverUrl}api/Hotel/GetHotelDetails/' + hotelId);

    if (response.statusCode == 200) {
      setState(() {
        _hotel = json.decode(response.body);
      });

     // return null;
    } else {
      throw Exception('Failed to Get hotel Details');
    }
  }

  @override
  Widget build(BuildContext context) {
     getHotelDetails(this.hotelId);
      if (_hotel != null) {
        return Scaffold(
          //    appBar: AppBar(title: Text('${loadeddCityData.getToursByCityId()}')),
          body: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext ctx, int index) {
                //     Activity activity = widget.destination.activities[index];

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          // child: Image.network(

                          //   _serverUrl + loadeddCityData["mainTourImage"].toString(),

                          //   width: 1100.0,
                          //   fit: BoxFit.cover,

                          //   //_serverUrl + loadeddestinationDat["mainTourImage"].toString(),

                          //   //loadeddestinationDat.tours[index].),

                          // ),

                          // child: Image.network(
                          //          _serverUrl + loadeddCityData["mainHotelImage"].toString(),
                          //         height: 180.0,
                          //         width: 220.0,
                          //         //image: AssetImage(hotel.imageUrl),
                          //         fit: BoxFit.cover,
                          //       ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(100, 30, 1, 50),
                      //   child: Text(loadeddestinationDat.activities[index].name,style: TextStyle(fontSize:55,fontWeight: FontWeight.w600,),
                      //   ),

                      //   ),
                      //   Padding(
                      //     padding:EdgeInsets.fromLTRB(130, 10, 1, 5) ,
                      //     child: _buildRatingStars(loadeddestinationDat.activities[index].rating )),
                      //     Padding(
                      //     padding:EdgeInsets.fromLTRB(150, 10, 1, 5) ,
                      //     child: Text('Stars',style: TextStyle(fontSize:40,fontWeight:FontWeight.bold) ))
                      Card(
                        child: ListTile(
                          title: (Text(
                            '',
                            // loadeddCityData.toursData[index].name,
                            style: TextStyle(fontSize: 50),
                          )),
                          subtitle: Text('',
                              //   loadeddCityData.toursData[index].startTimes.toString(),
                              style: TextStyle(fontSize: 25)),
                          trailing: Text('',
                              //'\$${loadeddCityData.toursData[index].price.toString()}',
                              style: TextStyle(fontSize: 50)),
                        ),
                      )
                    ]);
              }),
        );
      }
    else {
      return Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
    );
  }
}
}

