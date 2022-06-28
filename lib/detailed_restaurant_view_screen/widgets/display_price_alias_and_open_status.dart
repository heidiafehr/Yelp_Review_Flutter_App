import 'package:flutter/material.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/open_status.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/price_and_alias.dart';

///displays price&type and/or hours status WITHOUT expanded tile
class DisplayPriceAliasAndOpenStatus extends StatelessWidget {
  final bool? isOpenNow;
  final String? price;
  final String? restaurantType;
  final bool priceAndTypeAreValid;
  final bool hoursAreValid;

  const DisplayPriceAliasAndOpenStatus(
      {Key? key,
      this.isOpenNow,
      this.price,
      this.restaurantType,
      required this.priceAndTypeAreValid,
      required this.hoursAreValid,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          if(priceAndTypeAreValid)
            PriceAndAlias(price: price!, restaurantType: restaurantType!),
          if(priceAndTypeAreValid)
            const Spacer(),

          if(isOpenNow != null)
            OpenStatus(isOpenNow: isOpenNow!),
        ],
      ),
    );
  }
}
