import 'package:flutter/material.dart';

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
      this.zipcode})
      : super(key: key);

  bool get addressIsValid => (addressLineOne != null &&
      city != null &&
      state != null &&
      zipcode != null &&
      addressLineOne!.isNotEmpty &&
      city!.isNotEmpty &&
      state!.isNotEmpty &&
      zipcode!.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (addressIsValid)
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
