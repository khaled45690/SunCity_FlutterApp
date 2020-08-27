import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TourDetailsScreen extends StatefulWidget {
  static const routeName = '/TourDetails2Screen';
  final String tourId;
  final String tourImage;
  final String tourName;

  TourDetailsScreen({this.tourId, this.tourImage, this.tourName});

  @override
  _TourDetailsScreenState createState() =>
      _TourDetailsScreenState(tourId: this.tourId, tourImage: this.tourImage);
}

class _TourDetailsScreenState extends State<TourDetailsScreen> {
  final String tourId;
  final String tourImage;
  final String tourName;

  _TourDetailsScreenState({this.tourId, this.tourImage, this.tourName});

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  var _tour;
  List _tourImages;

  String get hotelData => _tour;

  set toursDataSetter(var tour) {
    setState(() {
      _tour = tour;
    });
  }

  Future<String> getTourDetails(String tourId) async {
    final response =
        await http.get('${_serverUrl}api/Tour/GetTourDetails/' + tourId);

    if (response.statusCode == 200) {
      setState(() {
        _tour = json.decode(response.body);
        _tourImages = _tour["tourImages"];
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getTourDetails(this.tourId);
  }

  Widget build(BuildContext context) {
    if (_tour != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("الرحلات"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            // IconButton(
            //   //
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            buildSlider(),
            SizedBox(height: 20),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${_tour["tourName"].toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        _buildRatingStars(_tour["rating"]),
                        Text(
                          'ج ${_tour["pricePerNight"].toString()}',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'لكل فرد',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.blueGrey[300],
                    ),
                    SizedBox(width: 3),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${_tour["location"].toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.blueGrey[300],
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "${_tour["pricePerNight"].toString()}",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 17,
                //     ),
                //     maxLines: 1,
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                // SizedBox(height: 40),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${_tour["description"].toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.book,
          ),
          onPressed: () {},
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }

  buildSlider() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: _tourImages == null ? 0 : _tourImages.length,
        itemBuilder: (BuildContext context, int index) {
          Map images = _tourImages[index];

          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                "${_serverUrl + images["image"]}",
                height: 250.0,
                width: MediaQuery.of(context).size.width - 40.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
