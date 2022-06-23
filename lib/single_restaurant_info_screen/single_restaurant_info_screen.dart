import 'package:flutter/material.dart';
import 'package:yelp_app/api_call_class.dart';
import 'package:yelp_app/single_restaurant_info_screen/widgets/display_overall_rating.dart';
import 'package:yelp_app/single_restaurant_info_screen/widgets/display_price_and_hours_status.dart';
import 'package:yelp_app/single_restaurant_info_screen/widgets/display_user_reviews.dart';
import 'package:yelp_app/single_restaurant_info_screen/widgets/display_restaurant_address.dart';
import 'package:yelp_app/restaurant_class.dart';
import 'package:yelp_app/review_class.dart';
import 'package:yelp_app/yelp_appbar.dart';
import 'package:yelp_app/yelp_review_app.dart';

class SingleRestaurantInfoScreen extends StatefulWidget {
  final String? appBarTitle;

  const SingleRestaurantInfoScreen(
      {@visibleForTesting this.appBarTitle, Key? key})
      : super(key: key);

  @override
  State<SingleRestaurantInfoScreen> createState() =>
      _SingleRestaurantInfoScreen();
}

class _SingleRestaurantInfoScreen extends State<SingleRestaurantInfoScreen> {
  Future<Restaurant>? futureRestaurant;
  Future<Reviews>? futureReviews;
  Future<Restaurant>? futureListOfRestaurants;
  APICall api = APICall();

  @override
  void initState() {
    super.initState();
    _getRestaurant();
    _getReview();
    _getListOfRestaurants();
  }

  void _getRestaurant() async {
    futureRestaurant = null;
    futureRestaurant = api.fetchRestaurant();
  }

  void _getReview() async {
    futureReviews = null;
    futureReviews = api.fetchReview();
  }

  void _getListOfRestaurants() async {
    futureListOfRestaurants = api.fetchListOfRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FutureBuilder<Restaurant>(
            future: futureRestaurant,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (snapshot.data?.name != null &&
                            snapshot.data!.name.isNotEmpty)
                        ? CustomYelpAppBar(snapshot.data!.name)
                        : const CustomYelpAppBar('N/A Restaurant Name'),
                    if (snapshot.data?.image != null &&
                        snapshot.data!.image.isNotEmpty)
                      Image.network(
                        snapshot.data!.image,
                      ),
                    DisplayPriceAndHoursStatus(
                        price: snapshot.data!.price,
                        restaurantType:
                            snapshot.data!.categories.first.restaurantType,
                        isOpenNow: snapshot.data!.hours.first.isOpenNow,
                        openHours: snapshot.data!.hours.first.openHours),
                    const YelpDivider(),
                    DisplayRestaurantAddress(
                      addressLineOne: snapshot.data!.location.addressLineOne,
                      city: snapshot.data!.location.city,
                      state: snapshot.data!.location.state,
                      zipcode: snapshot.data!.location.zipcode,
                    ),
                    const YelpDivider(),
                    DisplayOverallRating(
                      rating: snapshot.data!.rating,
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
            future: futureReviews,
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
