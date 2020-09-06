import 'dart:convert';
import 'dart:io';
import 'package:SunCity_FlutterApp/models/url_File.dart';
import 'package:SunCity_FlutterApp/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _serverUrl = URL.serverUrl;

  final String tourId;
  final String tourImage;
  final String tourName;
  int _statusCode;
  bool _isLoading = false;

void _exceptionHandler(int statusCode , String tourName) {
    // flutter defined function
if(statusCode == 200){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("تم الحجز"),
          content: Text(" بنجاح  $tourName : تم حجز الرحله"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("إغلاق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );}
    else
    {
       showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("لقد حدث خطأ"),
          content: (_statusCode == 400)
              ? new Text("تم حجز هذه الرحله اليوم بالفعل")
              : new Text("لقد حدث خطأ برجاء الإتصال بالدعم الفني"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("إغلاق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    }
    
  }


  _TourDetailsScreenState({this.tourId, this.tourImage, this.tourName});

  Future bookNow(String tourId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");

    final response = await http.post(
      '${_serverUrl}api/TourBooking/BookNow/' + tourId,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    print(response.statusCode);
      
      setState(() {
        _statusCode = response.statusCode;
      });

    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      throw Exception('An Error occurred');
    }
  }

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

  @override
  void initState2() {
    // TODO: implement initState
    super.initState();
    bookNow(this.tourId);
  }

  Widget build(BuildContext context) {
    if (_tour != null || _isLoading == true) {
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
        persistentFooterButtons: [
          RaisedButton(
            onPressed: () async {
               setState(() {
                 _isLoading = true;
                });
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              String token = sharedPreferences.getString("token");
              if (token != null) {
                bookNow(_tour["tourId"].toString());
                // print(" **************************************** ${_statusCode} ****************************************");
                //  if (_statusCode == 200 || _statusCode == 400 ) {
                // _exceptionHandler(_statusCode, _tour["tourName"].toString());
                // setState(() {
                //   _statusCode = null;
                // });
               //  }
              } else {
                Navigator.of(context).pushNamed(Login.routeName);
              }
            },
            padding: const EdgeInsets.all(0.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.blueAccent, Colors.greenAccent],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: const Text('إحجز الآن',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
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
