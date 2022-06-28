import 'package:flutter/material.dart';

///Displays the price and type of the restaurant
///assumes that price and type are valid
class PriceAndAlias extends StatelessWidget {
  final String price;
  final String restaurantType;

  const PriceAndAlias(
      {Key? key, required this.price, required this.restaurantType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(price),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            restaurantType,
            style: const TextStyle(fontSize: 13.5),
          ),
        ),
      ],
    );
  }
}
