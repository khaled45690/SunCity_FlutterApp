import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
  final String hotelId;
  final String hotelImage;
  final String hotelName;
  _HotelDetailsScreenState({this.hotelId, this.hotelImage, this.hotelName});

  var _hotel;

  String get hotelData => _hotel;

  List hotel1images;

  set toursDataSetter(var hotel) {
    setState(() {
      _hotel = hotel;
    });
  }

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  Future<void> getHotelDetails(String hotelId) async {
    final response =
        await http.get('${_serverUrl}api/Hotel/GetHotelDetails/' + hotelId);

    if (response.statusCode == 200) {
      setState(() {
        _hotel = json.decode(response.body);
        // print(json.decode(response.body));
        hotel1images =_hotel["hotelImages"];
        print(hotel1images.length);
      });

      // return null;
    } else {
      throw Exception('Failed to Get hotel Details');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotelDetails(this.hotelId);
  }

  Widget build(BuildContext context) {
    if (_hotel != null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.hotelName)),
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
                          _serverUrl + widget.hotelImage,
                          height: 350.0,
                          width: 350.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 350,
                        padding: EdgeInsets.all(16.0),
                        child: GridView.builder(
                          itemCount: hotel1images.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0),
                          itemBuilder: (BuildContext context, int index) {
                        Map images = hotel1images[index];                          
                          return Image.network(_serverUrl + images["image"].toString(),);
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
