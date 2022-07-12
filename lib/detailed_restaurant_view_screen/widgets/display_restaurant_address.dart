import 'package:flutter/material.dart';

///displays the address of the restaurant
///takes in the first address line, city, state, and zipcode
///assumes that each of the fields are valid

class DisplayRestaurantAddress extends StatelessWidget {
  final double _indent = 30.0;

  final String? addressLineOne;
  final String? city;
  final String? state;
  final String? zipcode;

  const DisplayRestaurantAddress(
      {Key? key,
      required this.addressLineOne,
      required this.city,
      this.state,
      this.zipcode,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(_indent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Address'),
              Padding(padding: EdgeInsets.only(top: _indent)),
              Text('$addressLineOne\n$city, $state $zipcode',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0)),
            ],
          ),
        ),
      ],
    );
  }
}
