import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../main.dart';
import '../../yelp_repo/restaurant_class.dart';
import '../../yelp_review_app.dart';

///Displays the info for each of each of the restaurants
///assumes restaurant name is valid

class CardRestaurantInfo extends StatelessWidget {
  final Restaurant singleRestaurant;
  final double _cardIndent = 15.0;

  const CardRestaurantInfo({
    required this.singleRestaurant,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(_cardIndent),
          bottomLeft: Radius.circular(_cardIndent),
          topRight: Radius.circular(_cardIndent),
          topLeft: Radius.circular(_cardIndent),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/detailed_restaurant_view_screen',
              arguments: singleRestaurant.apiAlias);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              singleRestaurant.imageIsValid
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.width * .3,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: !isTestMode
                              ? CachedNetworkImage(
                                  imageUrl: singleRestaurant.image!,
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.pinkAccent,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.error),
                          ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.width * .3,
                      child: Initicon(
                        borderRadius: BorderRadius.circular(10.0),
                        text: (singleRestaurant.name),
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.width * .3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .51,
                        child: Text(
                          singleRestaurant.name!,
                          style: const TextStyle(
                              fontSize: 17.5, fontFamily: 'LoraRegular'),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      if (singleRestaurant.priceAndTypeAreValid)
                        Row(
                          children: [
                            Text(singleRestaurant.price!),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(singleRestaurant
                                  .categories!.first.restaurantType!),
                            ),
                          ],
                        ),
                      if (singleRestaurant.ratingIsValid)
                        RatingBarIndicator(
                          rating: singleRestaurant.rating!.toDouble(),
                          itemBuilder: (context, index) => const YelpStarIcon(),
                          itemCount: singleRestaurant.rating!.toInt(),
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
