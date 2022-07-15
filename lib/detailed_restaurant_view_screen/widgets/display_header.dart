import 'package:flutter/material.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/price_and_alias.dart';
import 'open_status.dart';

class DisplayHeader extends StatelessWidget {
  final String? price;
  final String? restaurantType;
  final bool? isOpenNow;
  final bool priceAndTypeAreValid;

  const DisplayHeader({
    Key? key,
    this.price,
    this.restaurantType,
    this.isOpenNow,
    required this.priceAndTypeAreValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          if (priceAndTypeAreValid)
            PriceAndAlias(
              price: price!,
              restaurantType: restaurantType!,
            ),
          if (priceAndTypeAreValid) const Spacer(),
          if (isOpenNow != null) OpenStatus(isOpenNow: isOpenNow!),
        ],
      ),
    );
  }
}