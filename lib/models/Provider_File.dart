import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GlobalProvider with ChangeNotifier {
  // server link
  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";
  //String _serverUrl = "https://localhost:44332/";
  //private global data

  List _data;
  List _hotels;
  List _tours;

  List get globalData => _data;
  List get topHotel => _hotels;
  List get toursData => _tours;

//modify the Globaldata  variable and notify all the dependent widgets
  set globalDataSetter(List newVal) {
    _data = newVal;
    notifyListeners();
  }

  // make global data accessable
  set topHotelSetter(List hotels) {
    _hotels = hotels;
    notifyListeners();    
  }

  set toursDataSetter(List tours){
    _tours = tours;
    notifyListeners();    
  }

//Http request that get data from server
  Future<List> getMainData() async {
    final response = await http.get('${_serverUrl}api/City/GetTopCitiesList');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      globalDataSetter = json.decode(response.body);
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

// more functions maybe added below this
  Future<List> getTopHotels() async {
    final response = await http.get('${_serverUrl}api/Hotel/GetTopHotels');

    if (response.statusCode == 200) {
      topHotelSetter = json.decode(response.body);

      return json.decode(response.body);
    } else {
      throw Exception('Failed to Get Hotels');
    }
  }

  Future<List> getToursByCityId() async {
    final response = await http.get('${_serverUrl}api/Tour/GetToursByCityId/E86E901B-42F8-4AF5-B97A-0867E31C4E92');

    if (response.statusCode == 200) {
      toursDataSetter = json.decode(response.body);

      return json.decode(response.body);
    } else {
      throw Exception('Failed to Get Tours');
    }
  }

}
