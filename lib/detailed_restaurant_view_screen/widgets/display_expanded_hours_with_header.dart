import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/open_status.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/price_and_alias.dart';

import '../../hours.dart';
import '../../yelp_review_app.dart';
import 'display_restaurant_hours.dart';

class DisplayExpandedHoursWithHeader extends StatelessWidget {
  final String? price;
  final String? restaurantType;
  final bool? isOpenNow;
  final List<OpenHours> openHours;
  final bool priceAndTypeAreValid;
  final bool openHoursListIsValid;

  const DisplayExpandedHoursWithHeader(
      {Key? key,
      this.price,
      this.restaurantType,
      this.isOpenNow,
      required this.openHours,
      required this.priceAndTypeAreValid,
      required this.openHoursListIsValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ExpansionTileCard(
        title: Row(
          children: [
            if (priceAndTypeAreValid)
              PriceAndAlias(
                price: price!,
                restaurantType: restaurantType!,
              ),
            if (priceAndTypeAreValid) const Spacer(),
            Row(
              children: [
                if (isOpenNow != null) OpenStatus(isOpenNow: isOpenNow!),
              ],
            ),
          ],
        ),
        children: [
          const YelpDivider(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: DisplayRestaurantHours(openHours),
            ),
          ),
        ],
      ),
    );
  }
}
