import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TourList {
  String tourId;
  String countryName;
  String cityName;
  String tourName;
  String location;
  String description;
  double pricePerNight;
  int rating;
  double mainTourImage;
  String _serverUrl = "http://algosys-001-site16.ctempurl.com/";

  TourList({
    this.tourId,
    this.countryName,
    this.cityName,
    this.tourName,
    this.location,
    this.description,
    this.pricePerNight,
    this.rating,
    this.mainTourImage,
  });

  factory TourList.fromJson(final json) {
    return TourList(
        tourId: json['tourId'],
        countryName: json['countryName'],
        cityName: json['cityName'],
        tourName: json['tourName'],
        location: json['location'],
        description: json['description'],
        pricePerNight: json['pricePerNight'],
        rating: json['rating'],
        mainTourImage: json['mainTourImage']);
  }

  Future<void> getToursByCityId(String cityId) async {
    try {
      final response = await http.get('${_serverUrl}api/Tour/GetToursByCityId/' + cityId);
          print(response);
    } catch (error) {
      
      throw (error);
    }
  }
}
