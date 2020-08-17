
import 'tour_model.dart';

class City {
  String id;
  String imageUrl;
  String city;
  String country;
  String description;
  List<Tour> tours;

  City({
    this.id,
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.tours,
  });
}
