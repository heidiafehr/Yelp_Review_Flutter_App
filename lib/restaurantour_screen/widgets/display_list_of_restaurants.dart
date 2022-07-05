import 'package:flutter/material.dart';
import 'package:yelp_app/restaurantour_screen/widgets/card_restaurant_info.dart';
import '../../restaurant_class.dart';

///displays list of restaurants by calling card info widget and passes each
///element one by one into that widget
///assumes restaurants list is not empty

class DisplayListOfRestaurants extends StatelessWidget {
  final List<Restaurant> restaurants;

  const DisplayListOfRestaurants({required this.restaurants, Key? key,})
      : super(key: key);

  //assuming restaurants is not empty (checked in cubit)
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: restaurants.length,
      itemBuilder: (_, index) {
        return CardRestaurantInfo(singleRestaurant: restaurants[index],);
      },
    );
  }
}