import 'dart:convert';
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

  Future<String> seeAllCities() async {
    final response = await http.get('${_serverUrl}api/City/SeeAllCities');

    if (response.statusCode == 200) {
      setState(() {
        _cities = json.decode(response.body);
      });

      return null;
    } else {
      throw Exception('Failed to Get hotels');
    }
  }

  @override
  Widget build(BuildContext context) {
    var cities = seeAllCities();

    if (cities = null) {
      if (_cities != null) {
        return Scaffold(
          appBar: AppBar(title: Text("المدن")),
          body: Container(
              child: ListView.builder(
            itemCount: _cities.length,
            itemBuilder: (BuildContext context, int index) {
              var city = _cities[index];

              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CityToursScreen(
                              cityId: city["cityId"], cityImage: city["image"]),
                        ));
                  },
                  subtitle: Text(
                    city["countryName"].toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(
                      _serverUrl + city["image"].toString(),
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
