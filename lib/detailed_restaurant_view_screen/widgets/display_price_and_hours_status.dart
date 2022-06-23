import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import '../../hours.dart';
import '../../yelp_review_app.dart';
import 'display_restaurant_hours.dart';

class DisplayPriceAndHoursStatus extends StatelessWidget {
  final String? price;
  final String? restaurantType;
  final bool? isOpenNow;
  final List<OpenHours> openHours;

  const DisplayPriceAndHoursStatus(
      {Key? key, this.price, this.restaurantType, this.isOpenNow, required this.openHours})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ExpansionTileCard(
        title: Row(
          children: [
            if (price != null &&
                price!.isNotEmpty)
              Text(price!),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: restaurantType !=
                  null &&
                  restaurantType!.isNotEmpty
                  ? Text(
                restaurantType!,
                style: const TextStyle(fontSize: 13.5),
              )
                  : const SizedBox.shrink(),
            ),
            const Spacer(),
            Row(
              children: [
                if (isOpenNow !=
                    null)
                  Text(
                    (isOpenNow!)
                        ? 'Open Now'
                        : 'Closed Now',
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 13.5),
                  ),
                if (isOpenNow !=
                    null)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(
                      Icons.circle,
                      color:
                      (isOpenNow!)
                          ? Colors.green
                          : Colors.red,
                      size: 11.5,
                    ),
                  ),
              ],
            ),
          ],
        ),
        children: [
          const YelpDivider(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 10.0),
              child: DisplayRestaurantHours(
                  openHours),
            ),
          ),
        ],
      ),
    );
  }
}