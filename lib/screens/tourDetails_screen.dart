import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TourDetailsScreen extends StatefulWidget {
  static const routeName = '/TourDetailsScreen';
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
        appBar: AppBar(title: Text(widget.tourName)),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext ctx, int index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          _serverUrl + widget.tourImage,
                          height: 350.0,
                          width: 350.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                        height: 300,
                        width: 400,
                        padding: EdgeInsets.all(16.0),
                        child: GridView.builder(
                          itemCount: _tourImages.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0),
                          itemBuilder: (BuildContext context, int index) {
                            Map images = _tourImages[index];
                            return Image.network(
                              _serverUrl + images["image"],
                              fit: BoxFit.cover,
                            );
                          },
                        )),
                  ]);
            }),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
