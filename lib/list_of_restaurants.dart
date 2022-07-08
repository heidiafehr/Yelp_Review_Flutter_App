import 'package:yelp_app/restaurant_class.dart';

class ListOfRestaurants {
  final List<Restaurant> listOfRestaurants;

  ListOfRestaurants({required this.listOfRestaurants});

  factory ListOfRestaurants.fromJson(Map<String, dynamic> json) {
    return ListOfRestaurants(
      listOfRestaurants: (json['business'] as List)
          .map((restaurantJson) => Restaurant.fromGQLJson(restaurantJson))
          .toList(),
    );
  }
}
