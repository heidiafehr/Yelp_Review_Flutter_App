import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_screen_cubit.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/restaurant_image_carousel.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_overall_rating.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_expanded_hours_with_header.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_user_reviews.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_restaurant_address.dart';
import 'package:yelp_app/restaurant_class.dart';
import 'package:yelp_app/review_class.dart';
import 'package:yelp_app/yelp_appbar.dart';
import 'package:yelp_app/yelp_review_app.dart';

import '../yelp_repo/yelp_repo.dart';

class DetailedRestaurantViewScreen extends StatefulWidget {
  final String? appBarTitle;
  final String alias;

  const DetailedRestaurantViewScreen(
      {@visibleForTesting this.appBarTitle, required this.alias, Key? key})
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => DetailedRestaurantViewCubit(alias: widget.alias),
        child: BlocBuilder<DetailedRestaurantViewCubit,
            DetailedRestaurantViewState>(
          builder: (context, state) {
            if (state is DetailedRestaurantViewLoadedState) {
              return ListView(
                children: [
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
                      if (state.photosAreValid &&
                          MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                        RestaurantImageCarousel(
                            photos: state.restaurant.photos!),

                      //if openHoursList is valid display with expanded tile
                      //else if open status or priceAndType are valid display
                      //those instead w/out expanded tile
                      if (state.hasHeaderData)
                        state.hasHours
                            ? DisplayHeaderWithExpandedHours(
                                price: state.restaurant.price!,
                                restaurantType: state.restaurant.categories!
                                    .first.restaurantType,
                                isOpenNow:
                                    state.restaurant.hours!.first.isOpenNow,
                                openHours:
                                    state.restaurant.hours!.first.openHours!,
                                priceAndTypeAreValid:
                                    state.priceAndTypeAreValid,
                              )
                            : DisplayHeader(
                                price: state.restaurant.price!,
                                restaurantType: state.restaurant.categories!
                                    .first.restaurantType,
                                isOpenNow:
                                    state.restaurant.hours!.first.isOpenNow,
                                priceAndTypeAreValid:
                                    state.priceAndTypeAreValid,
                              ),
                      if (state.hasHeaderData) const YelpDivider(),

                      if (state.addressIsValid)
                        DisplayRestaurantAddress(
                          addressLineOne:
                              state.restaurant.location!.addressLineOne,
                          city: state.restaurant.location!.city,
                          state: state.restaurant.location!.state,
                          zipcode: state.restaurant.location!.zipcode,
                        ),
                      if (state.addressIsValid) const YelpDivider(),

                      if (state.overallRatingIsValid)
                        DisplayOverallRating(
                          rating: state.restaurant.rating!.toString(),
                        ),
                      if (state.overallRatingIsValid) const YelpDivider(),

                      //if there is no review text (aka review) to display don't
                      //display anything
                      if (state.individualReviewsAreValid)
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
            } else if (state is DetailedRestaurantViewLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: Text('Oops something went wrong!'
                      '\nAre you connected to the internet?'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
