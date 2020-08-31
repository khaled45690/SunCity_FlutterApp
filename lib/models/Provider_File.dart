import 'dart:convert';
import 'package:SunCity_FlutterApp/models/url_File.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GlobalProvider with ChangeNotifier {

  String  _serverUrl = URL.serverUrl; 

  List _cities;
  List _hotels;

  List get topCitiesData => _cities;
  List get topHotelsData => _hotels;

  set globalDataSetter(List cities) {
    _cities = cities;
    notifyListeners();
  }

  set topHotelsDataSetter(List hotels) {
    _hotels = hotels;
    notifyListeners();
  }

  //Http request that get data from server
  Future<List> getTopCities() async {
    final response = await http.get('${_serverUrl}api/City/GetTopCitiesList');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      globalDataSetter = json.decode(response.body);
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      //then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  //more functions maybe added below this
  Future<List> getTopHotels() async {
    final response = await http.get('${_serverUrl}api/Hotel/GetTopHotels');

    if (response.statusCode == 200) {
      topHotelsDataSetter = json.decode(response.body);

      return json.decode(response.body);
    } else {
      throw Exception('Failed to Get Hotels');
    }
  }
}
