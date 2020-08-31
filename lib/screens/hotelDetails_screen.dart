import 'dart:convert';
import 'dart:io';
import 'package:SunCity_FlutterApp/models/url_File.dart';
import 'package:SunCity_FlutterApp/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotelDetailsScreen extends StatefulWidget {
  static const routeName = '/HotelsDetailsScreen';

  final String hotelId;
  final String hotelImage;
  final String hotelName;

  HotelDetailsScreen({this.hotelId, this.hotelImage, this.hotelName});

  @override
  _HotelDetailsScreenState createState() => _HotelDetailsScreenState(
      hotelId: this.hotelId, hotelImage: this.hotelImage);
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {

   String  _serverUrl = URL.serverUrl; 
 
  final String hotelId;
  final String hotelImage;
  final String hotelName;
  _HotelDetailsScreenState({this.hotelId, this.hotelImage, this.hotelName});

  var _hotel;

  String get hotelData => _hotel;

  List _hotelImages;

  set toursDataSetter(var hotel) {
    setState(() {
      _hotel = hotel;
    });
  }
  

 Future bookNow(String hotelId) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     String token = sharedPreferences.getString("token");

     final response = await http.post('${_serverUrl}api/HotelBooking/BookNow/'+ hotelId,
    
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      
      );
  print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      throw Exception('An Error occurred');
    }
  }

  Future<void> getHotelDetails(String hotelId) async {
    final response =
        await http.get('${_serverUrl}api/Hotel/GetHotelDetails/'+ hotelId);

    if (response.statusCode == 200) {
      setState(() {
        _hotel = json.decode(response.body);
        _hotelImages = _hotel["hotelImages"];
      });

      // return null;
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
    getHotelDetails(this.hotelId);
  }

 @override
  void initState2() {
    // TODO: implement initState
    super.initState();
    bookNow(this.hotelId);
  }

  Widget build(BuildContext context) {
    if (_hotel != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("أفضل الفنادق"),
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
                        "${_hotel["hotelName"].toString()}",
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
                        _buildRatingStars(_hotel["rating"]),
                        Text(
                          'ج ${_hotel["pricePerNight"].toString()}',
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
                        "${_hotel["location"].toString()}",
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
                    "${_hotel["description"].toString()}",
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
          onPressed: () async{
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            String token = sharedPreferences.getString("token");
            if(token != null) 
            {
              
              bookNow(_hotel["hotelId"].toString());
           }
            else{
             Navigator.of(context).pushNamed(Login.routeName);
           }
          },
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
        itemCount: _hotelImages == null ? 0 : _hotelImages.length,
        itemBuilder: (BuildContext context, int index) {
          Map images = _hotelImages[index];

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
