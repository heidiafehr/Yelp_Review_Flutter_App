import 'package:flutter/material.dart';
import 'package:yelp_app/restaurantour_screen/widgets/card_restaurant_info.dart';
import '../../restaurant_class.dart';

///displays list of restaurants by calling card info widget and passes each
///element one by one into that widget
///assumes restaurants list is not empty

class DisplayRestaurantCatalog extends StatelessWidget {
  final List<Restaurant> restaurants;

  const DisplayRestaurantCatalog({
    required this.restaurants,
    Key? key,
  }) : super(key: key);

  //assuming restaurants is not empty (checked in cubit)
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: restaurants.length,
      itemBuilder: (_, index) {
        //if name of the restaurant is not provided, do not display that card
        return restaurants[index].nameIsValid
            ? CardRestaurantInfo(
                singleRestaurant: restaurants[index],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
