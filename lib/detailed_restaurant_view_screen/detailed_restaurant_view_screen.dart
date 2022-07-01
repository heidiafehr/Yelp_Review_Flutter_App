import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_screen_cubit.dart';
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
  final String? alias;

  const DetailedRestaurantViewScreen(
      {@visibleForTesting this.appBarTitle, this.alias, Key? key})
      : super(key: key);

  @override
  State<DetailedRestaurantViewScreen> createState() =>
      _SingleRestaurantInfoScreen();
}

class _SingleRestaurantInfoScreen extends State<DetailedRestaurantViewScreen> {
  Future<Restaurant>? futureRestaurant;
  Future<Reviews>? futureReviews;
  YelpRepo api = YelpRepo();

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
    //final arg = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: BlocProvider(
        create: (_) => DetailedRestaurantViewCubit(alias: widget.alias),
        child: BlocBuilder<DetailedRestaurantViewCubit,
            DetailedRestaurantViewState>(
          builder: (context, state) {
            if (state is DetailedRestaurantViewLoadedState) {
              return ListView(
                children: [
                  /*if (snapshot.hasData && snapshot.data != null) {
                        final Restaurant data = snapshot.data!;
                        final bool displayWithExpanded = (data.hoursAreValid &&
                            data.hours!.first.openHoursListIsValid &&
                            data.hours!.first.isOpenNow != null);
                        final bool canDisplayPriceOrOpen =
                            (data.hoursAreValid ||
                                data.priceAndTypeAreValid ||
                                data.hours!.first.isOpenNow != null);
                        final bool displayedExpandedOrPrice =
                            displayWithExpanded || canDisplayPriceOrOpen;*/
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (state.restaurant.nameIsValid)
                          ? CustomYelpAppBar(
                        title: state.restaurant.name!,
                        addNavigateBack: true,
                      )
                          : const CustomYelpAppBar(
                        title: 'N/A Restaurant Name',
                        addNavigateBack: true,
                      ),
                      if (state.restaurant.photosAreValid)
                        RestaurantImageCarousel(
                            photos: state.restaurant.photos),

                      //if openHoursList is valid display with expanded tile
                      //else if open status or priceAndType are valid display
                      //those instead w/out expanded tile
                      DisplayExpandedHoursWithHeader(
                        price: state.restaurant.price!,
                        restaurantType:
                        state.restaurant.categories!.first.restaurantType,
                        isOpenNow: state.restaurant.hours!.first.isOpenNow,
                        openHours: state.restaurant.hours!.first.openHours!,
                        priceAndTypeAreValid:
                        state.restaurant.priceAndTypeAreValid,
                        openHoursListIsValid:
                        state.restaurant.hours!.first.openHoursListIsValid,
                      ),
                      /*DisplayPriceAliasAndOpenStatus(
                        priceAndTypeAreValid:
                        state.restaurant.priceAndTypeAreValid,
                        price: state.restaurant.price!,
                        restaurantType:
                        state.restaurant.categories!.first.restaurantType,
                        isOpenNow: state.restaurant.hours!.first.isOpenNow,
                        hoursAreValid: state.restaurant.hoursAreValid,
                      ),*/
                      const YelpDivider(),

                      DisplayRestaurantAddress(
                        addressLineOne:
                        state.restaurant.location!.addressLineOne,
                        city: state.restaurant.location!.city,
                        state: state.restaurant.location!.state,
                        zipcode: state.restaurant.location!.zipcode,
                      ),
                      const YelpDivider(),
                      DisplayOverallRating(
                        rating: state.restaurant.rating!.toString(),
                      ),
                      if (state.restaurant.rating != null) const YelpDivider(),
                      DisplayUserReviews(
                        totalNumberOfReviews:
                        state.reviews.totalNumberOfReviews,
                        individualUserReviews:
                        state.reviews.individualUserReviews,
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
