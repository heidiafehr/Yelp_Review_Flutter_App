import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_app/restaurantour_screen/widgets/card_restaurant_info.dart';
import '../../restaurant_class.dart';
import '../../yelp_review_app.dart';

class DisplayListOfRestaurants extends StatelessWidget {
  final List<Restaurant> restaurants;

  const DisplayListOfRestaurants({required this.restaurants, Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: restaurants.length,
      itemBuilder: (_, index) {
        return CardRestaurantInfo(singleRestaurant: restaurants[index]);
      },
    );
  }
}