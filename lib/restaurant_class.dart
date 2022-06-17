import 'package:yelp_app/hours.dart';

import 'category.dart';
import 'hours.dart';

class Restaurant {
  final String name;
  final String image;
  final List<Hours> hours;
  final String price;
  final List<Category> categories;
  //final String address;

  Restaurant({
    required this.name,
    required this.image,
    required this.hours,
    required this.price,
    required this.categories,
    //required this.address,
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
    );
  }
}
