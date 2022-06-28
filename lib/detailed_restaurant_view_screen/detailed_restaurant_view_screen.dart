import 'package:flutter/material.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_price_alias_and_open_status.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/restaurant_image_carousel.dart';
import 'package:yelp_app/yelp_repository.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_overall_rating.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_expanded_hours_with_header.dart';
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
                final Restaurant data = snapshot.data!;
                final bool displayWithExpanded = (data.hoursAreValid &&
                    data.hours!.first.openHoursListIsValid &&
                    data.hours!.first.isOpenNow != null);
                final bool canDisplayPriceOrOpen = (data.hoursAreValid ||
                    data.priceAndTypeAreValid ||
                    data.hours!.first.isOpenNow != null);
                final bool displayedExpandedOrPrice =
                    displayWithExpanded || canDisplayPriceOrOpen;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (data.nameIsValid)
                        ? CustomYelpAppBar(
                            title: data.name!,
                            addNavigateBack: true,
                          )
                        : const CustomYelpAppBar(
                            title: 'N/A Restaurant Name',
                            addNavigateBack: true,
                          ),
                    if (data.photosAreValid)
                      RestaurantImageCarousel(photos: snapshot.data!.photos),

                    //if openHoursList is valid display with expanded tile
                    //else if open status or priceAndType are valid display
                    //those instead w/out expanded tile
                    if (displayWithExpanded)
                      DisplayExpandedHoursWithHeader(
                        price: data.price!,
                        restaurantType: data.categories!.first.restaurantType,
                        isOpenNow: data.hours!.first.isOpenNow,
                        openHours: data.hours!.first.openHours!,
                        priceAndTypeAreValid: data.priceAndTypeAreValid,
                        openHoursListIsValid:
                            data.hours!.first.openHoursListIsValid,
                      )
                    else if (canDisplayPriceOrOpen)
                      DisplayPriceAliasAndOpenStatus(
                        priceAndTypeAreValid: data.priceAndTypeAreValid,
                        price: data.price!,
                        restaurantType: data.categories!.first.restaurantType,
                        isOpenNow: data.hours!.first.isOpenNow,
                        hoursAreValid: data.hoursAreValid,
                      ),
                    if (displayedExpandedOrPrice) const YelpDivider(),

                    DisplayRestaurantAddress(
                      addressLineOne: data.location!.addressLineOne,
                      city: data.location!.city,
                      state: data.location!.state,
                      zipcode: data.location!.zipcode,
                    ),
                    const YelpDivider(),
                    DisplayOverallRating(
                      rating: data.rating!.toString(),
                    ),
                    if (data.rating != null) const YelpDivider(),

                    FutureBuilder<Reviews>(
                      future: _getReview(arg),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final Reviews data = snapshot.data!;
                          return DisplayUserReviews(
                            totalNumberOfReviews: data.totalNumberOfReviews,
                            individualUserReviews: data.individualUserReviews,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
