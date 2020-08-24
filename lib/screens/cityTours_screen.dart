import 'dart:convert';
import '../models/tourList_model.dart';
import '../screens/tourDetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CityToursScreen extends StatefulWidget {
  static const routeName = '/CityToursScreen';
  final String cityId;
  final String cityImage;

  CityToursScreen({this.cityId, this.cityImage});
  @override
  _CityToursScreenState createState() =>
      _CityToursScreenState(cityImage: this.cityImage, cityId: this.cityId);
}

class _CityToursScreenState extends State<CityToursScreen> {
  String cityId;
  String cityImage;

  _CityToursScreenState({this.cityId, this.cityImage}) {
    print(this.cityId);
  }

  List _tours;

  List get toursData => _tours;

  set toursDataSetter(List tours) {
    setState(() {
      _tours = tours;
    });
  }

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  Future<TourList> getToursByCityId(String cityId) async {
    final response = await http.get('${_serverUrl}api/Tour/GetToursByCityId/' + cityId);

    if (response.statusCode == 200) {
      setState(() {
        _tours = json.decode(response.body);
      });

      return null;
    } else {
      throw Exception('Failed to Get Tours');
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getToursByCityId(this.cityId);
  }
  Widget build(BuildContext context) {
      if (_tours != null) {

        return Scaffold(
          // appBar: AppBar(),
          body: Column(children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: widget.cityImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(_serverUrl + widget.cityImage,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        children: <Widget>[],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20.0,
                  bottom: 20.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text(
                      //   widget.city.country,
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 35.0,
                      //       fontWeight: FontWeight.w600,
                      //       letterSpacing: 1.2),
                      // ),
                      Row(
                        children: <Widget>[
                          // Icon(
                          //   FontAwesomeIcons.locationArrow,
                          //   size: 15.0,
                          //   color: Colors.white70,
                          // ),
                          SizedBox(width: 5.0),
                          // Text(
                          //   widget.destination.country,
                          //   style: TextStyle(
                          //       color: Colors.white70,
                          //       fontSize: 20.0,
                          //       fontWeight: FontWeight.w600,
                          //       letterSpacing: 1.2),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20.0,
                  bottom: 20.0,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white70,
                    size: 25.0,
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                itemCount: _tours.length,
                itemBuilder: (BuildContext context, int index) {
                  Map tour = _tours[index];

                  return Stack(
                    children: <Widget>[
                      Card(
                        
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TourDetailsScreen(
                                    tourId: tour["tourId"],
                                    tourImage: tour["mainTourImage"],
                                    tourName: tour["tourName"]),
                              ),
                            );
                          },
                          title: Container(
                            margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                            height: 170.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 120.0,
                                        child: Text(
                                          '${tour["tourName"].toString()}',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            'لكل فرد',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'ج ${tour["pricePerNight"].toString()}',
                                            style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${tour["location"].toString()}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  //  _buildRatingStars(tour.rating),
                                  SizedBox(height: 10.0),
                                  // Row(
                                  //   children: <Widget>[
                                  //     Container(
                                  //       padding: EdgeInsets.all(5.0),
                                  //       width: 70.0,
                                  //       decoration: BoxDecoration(
                                  //         color: Theme.of(context).accentColor,
                                  //         borderRadius: BorderRadius.circular(10.0),
                                  //       ),
                                  //       alignment: Alignment.center,
                                  //       child: Text(tour.startTimes[0]),
                                  //     ),
                                  //     SizedBox(width: 10.0),
                                  //     Container(
                                  //       width: 70.0,
                                  //       decoration: BoxDecoration(
                                  //         color: Theme.of(context).accentColor,
                                  //         borderRadius: BorderRadius.circular(10.0),
                                  //       ),
                                  //       alignment: Alignment.center,
                                  //       child: Text(tour.startTimes[1]),
                                  //     )
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20.0,
                        top: 15.0,
                        bottom: 15.0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              _serverUrl + tour["mainTourImage"].toString(),
                              width: 110.0,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ],
                  );
                },
              ),
            )
          ]),
        );
      } else {
      return Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
    );
  }
 }
}
