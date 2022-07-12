import 'package:yelp_app/restaurant_class.dart';

class RestaurantCatalog {
  final List<Restaurant> restaurantCatalog;

  RestaurantCatalog({required this.restaurantCatalog});

  factory RestaurantCatalog.fromJson(Map<String, dynamic> json) {
    return RestaurantCatalog(
      restaurantCatalog: (json['business'] as List)
          .map((restaurantJson) => Restaurant.fromGQLJson(restaurantJson))
          .toList(),
    );
  }
}
