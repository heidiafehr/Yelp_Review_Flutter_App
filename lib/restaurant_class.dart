import 'package:yelp_app/hours.dart';
import 'category.dart';
import 'package:yelp_app/location.dart';

class Restaurant {
  final String name;
  final String image;
  final List<Hours> hours;
  final String price;
  final List<Category> categories;
  final Location location;
  final String rating;

  bool get isRestaurantNameValid => (name.isNotEmpty);

  Restaurant({
    required this.name,
    required this.image,
    required this.hours,
    required this.price,
    required this.categories,
    required this.location,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      image: json['image_url'],
      price: json['price'],
      categories: (json['categories'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
      hours: (json['hours'] as List)
          .map((hoursJson) => Hours.fromJson(hoursJson))
          .toList(),
      location: Location.fromJson(json['location']),
      rating: json['rating'].toString(),
    );
  }
}
