import 'package:flutter/material.dart';

class RestaurantAddress extends StatelessWidget{
  final double _indent = 30.0;
  final bool isAddressValid;
  final String addressLineOne;
  final String addressLineTwo;
  final String? addressLineThree;


  const RestaurantAddress({Key? key, required this.isAddressValid, required this.addressLineOne,
      required this.addressLineTwo, this.addressLineThree}) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(_indent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Address'),
          Padding(
            padding: EdgeInsets.only(top: _indent),
            child: (isAddressValid)
                ? Text(
              '$addressLineOne'
                  '\n$addressLineTwo',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            )
                : const SizedBox.shrink(),
          ),
          if (addressLineThree !=
              null &&
              addressLineThree!.isNotEmpty)
            Text(
              addressLineThree!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
        ],
      ),
    );
  }
}