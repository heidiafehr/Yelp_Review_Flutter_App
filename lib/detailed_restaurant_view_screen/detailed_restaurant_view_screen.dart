import 'package:flutter/material.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/restaurant_image_carousel.dart';
import 'package:yelp_app/yelp_repository.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_overall_rating.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_price_and_hours_status.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_user_reviews.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_restaurant_address.dart';
import 'package:yelp_app/restaurant_class.dart';
import 'package:yelp_app/review_class.dart';
import 'package:yelp_app/yelp_appbar.dart';
import 'package:yelp_app/yelp_review_app.dart';

class DetailedRestaurantViewScreen extends StatefulWidget {
  final String? appBarTitle;

  const DetailedRestaurantViewScreen(
      {@visibleForTesting this.appBarTitle, Key? key})
      : super(key: key);

  @override
  State<DetailedRestaurantViewScreen> createState() =>
      _SingleRestaurantInfoScreen();
}

class _SingleRestaurantInfoScreen extends State<DetailedRestaurantViewScreen> {
  Future<Restaurant>? futureRestaurant;
  Future<Reviews>? futureReviews;
  APICall api = APICall();


  @override
  void initState() {
    super.initState();
    _getRestaurant(null);
    _getReview(null);
  }

  Future<Restaurant> _getRestaurant(String? apiAlias) async {
    return api.fetchRestaurant(apiAlias!);
  }

  Future<Reviews> _getReview(String? apiAlias) async {
    return api.fetchReview(apiAlias!);
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: ListView(
        children: [
          FutureBuilder<Restaurant>(
            future: _getRestaurant(arg),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (snapshot.data?.name != null &&
                            snapshot.data!.name.isNotEmpty)
                        ? CustomYelpAppBar(
                            title: snapshot.data!.name,
                            addNavigateBack: true,
                          )
                        : const CustomYelpAppBar(
                            title: 'N/A Restaurant Name',
                            addNavigateBack: true,
                          ),
                    if (snapshot.data?.image != null &&
                        snapshot.data!.image.isNotEmpty)
                      RestaurantImageCarousel(photos: snapshot.data!.photos),
                    if (snapshot.data!.hours != null &&
                        snapshot.data!.hours!.isNotEmpty)
                      DisplayPriceAndHoursStatus(
                          price: snapshot.data!.price,
                          restaurantType:
                              snapshot.data!.categories.first.restaurantType,
                          isOpenNow: snapshot.data!.hours!.first.isOpenNow,
                          openHours: snapshot.data!.hours!.first.openHours),
                    const YelpDivider(),
                    DisplayRestaurantAddress(
                      addressLineOne: snapshot.data!.location.addressLineOne,
                      city: snapshot.data!.location.city,
                      state: snapshot.data!.location.state,
                      zipcode: snapshot.data!.location.zipcode,
                    ),
                    const YelpDivider(),
                    DisplayOverallRating(
                      rating: snapshot.data!.rating.toString(),
                    ),
                    if (snapshot.data?.rating != null) const YelpDivider(),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          FutureBuilder<Reviews>(
            future: _getReview(arg),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return DisplayUserReviews(
                  totalNumberOfReviews: snapshot.data?.totalNumberOfReviews,
                  individualUserReviews: snapshot.data?.individualUserReviews,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
