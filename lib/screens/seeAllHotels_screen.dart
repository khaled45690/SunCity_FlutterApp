import 'dart:convert';
import '../screens/hotelDetails_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SeeAllHotelsScreen extends StatefulWidget {
  static const routeName = '/SeeAllHotelScreen';

  @override
  _SeeAllHotelsScreenState createState() => _SeeAllHotelsScreenState();
}

class _SeeAllHotelsScreenState extends State<SeeAllHotelsScreen> {
  List _hotels;
  List get hotelsData => _hotels;

  set hotelsDataSetter(List hotels) {
    setState(() {
      _hotels = hotels;
    });
  }

  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  Future<String> seeAllHotels() async {
    final response = await http.get('${_serverUrl}api/Hotel/SeeAllHotels');

    if (response.statusCode == 200) {
      setState(() {
        _hotels = json.decode(response.body);
      });

      return null;
    } else {
      throw Exception('Failed to Get hotels');
    }
  }

  @override
  Widget build(BuildContext context) {
    var hotels = seeAllHotels();

    if (hotels = null) {
      if (_hotels != null) {
        return Scaffold(
          appBar: AppBar(title: Text("المدن")),
          body: Container(
              child: ListView.builder(
            itemCount: _hotels.length,
            itemBuilder: (BuildContext context, int index) {
              var hotel = _hotels[index];

              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HotelDetailsScreen(
                              hotelId: hotel["hotelId"],
                              hotelImage: hotel["mainHotelImage"]),
                        ));
                  },
                  subtitle: Text(
                    hotel["hotelName"].toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(
                      _serverUrl + hotel["mainHotelImage"].toString(),
                      fit: BoxFit.cover,
                      width: 70,
                    ),
                  ),
                ),
              );
            },
          )),
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
