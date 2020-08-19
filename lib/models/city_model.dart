
import 'tourList_model.dart';

class City {
  String id;
  String mainTourImage;
  String city;
  String country;
  String description;
  List<TourList> tours;

  City({
    this.id,
    this.mainTourImage,
    this.city,
    this.country,
    this.description,
    this.tours,
  });
}
