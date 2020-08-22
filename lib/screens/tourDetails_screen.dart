import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TourDetailsScreen extends StatefulWidget {
  static const routeName = '/TourDetailsScreen';
  final String tourId;
  final String tourImage;

  TourDetailsScreen({this.tourId, this.tourImage});

  @override
  _TourDetailsScreenState createState() =>
      _TourDetailsScreenState(tourId: this.tourId, tourImage: this.tourImage);
}

class _TourDetailsScreenState extends State<TourDetailsScreen> {
  final String tourId;
  final String tourImage;

  _TourDetailsScreenState({this.tourId, this.tourImage});

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  String _tour;

  String get hotelData => _tour;

  set toursDataSetter(String tour) {
    setState(() {
      _tour = tour;
    });
  }

  Future<String> getTourDetails(String tourId) async {
    final response =
        await http.get('${_serverUrl}api/Tour/GetTourDetails' + tourId);

    if (response.statusCode == 200) {
      setState(() {
        _tour = json.decode(response.body);
      });

      return null;
    } else {
      throw Exception('Failed to Get hotel Details');
    }
  }

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
      stars.trim();
    }
    return Text(stars);
  }

  @override
  Widget build(BuildContext context) {
    var tour = getTourDetails(this.tourId);
    if (tour != null) {
      if (_tour != null) {
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
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }
