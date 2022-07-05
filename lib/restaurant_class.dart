import 'package:yelp_app/hours.dart';
import 'category.dart';
import 'package:yelp_app/location.dart';

class Restaurant {
  final String? name;
  final String? image;
  final List<Hours>? hours;
  final String? price;
  final List<Category>? categories;
  final Location? location;
  final num? rating;
  final String? apiAlias;
  final List<String>? photos;

  bool get nameIsValid =>
      (name != null && name!.isNotEmpty);
  bool get imageIsValid => (image != null && image!.isNotEmpty);
  bool get ratingIsValid => (rating != null && !rating!.isNegative);
  bool get _categoriesIsValid => (categories != null && categories!.isNotEmpty);
  bool get priceAndTypeAreValid => (price != null &&
      price!.isNotEmpty &&
      _categoriesIsValid &&
      categories!.first.typeIsValid);

  Restaurant({
    this.name,
    this.image,
    this.hours,
    this.price,
    this.categories,
    this.location,
    this.rating,
    this.apiAlias,
    this.photos,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      image: json['image_url'],
      price: json['price'],
      categories: (json['categories'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
      hours: json.containsKey('hours')
          ? (json['hours'] as List)
              .map((hoursJson) => Hours.fromJson(hoursJson))
              .toList()
          : null,
      location: Location.fromJson(json['location']),
      rating: json['rating'],
      apiAlias: json['alias'],
      photos: json.containsKey('photos')
          ? (json['photos'] as List).map((photo) => photo.toString()).toList()
          : null,
    );
  }
}
