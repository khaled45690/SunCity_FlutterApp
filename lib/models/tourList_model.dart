import 'package:flutter/foundation.dart';

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
}
