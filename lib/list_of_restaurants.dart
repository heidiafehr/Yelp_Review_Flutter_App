import 'package:yelp_app/restaurant_class.dart';

class ListOfRestaurants {
  final List<Restaurant> listOfRestaurants;
  //final int total;

  ListOfRestaurants({required this.listOfRestaurants});

  factory ListOfRestaurants.fromJson(Map<String, dynamic> json) {

    return ListOfRestaurants(
        //total: json['total'],
      listOfRestaurants: (json['businesses'] as List)
          .map((listjson) => Restaurant.fromJson(listjson))
          .toList(),
    );
  }
}

class Business {
  final String name;

  Business({required this.name});

  factory Business.fromJson(Map<String, dynamic> json) {

    return Business(
      //total: json['total'],
      name: json['name'],
    );
  }

}
