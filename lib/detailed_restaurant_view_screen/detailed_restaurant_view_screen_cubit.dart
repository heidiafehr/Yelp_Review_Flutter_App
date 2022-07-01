import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_app/yelp_repository.dart';

import '../restaurant_class.dart';
import '../review_class.dart';

abstract class DetailedRestaurantViewState {}

class DetailedRestaurantViewErrorState extends DetailedRestaurantViewState {}

class DetailedRestaurantViewLoadingState extends DetailedRestaurantViewState {}

class DetailedRestaurantViewLoadedState extends DetailedRestaurantViewState {
  Restaurant restaurant;
  Reviews reviews;

  DetailedRestaurantViewLoadedState({
    required this.restaurant,
    required this.reviews,
  });

  //display expanded tile
  //hours is valid
  //has a list of restaurant hours
  //optional - price and type (will check later?)

  //displaying without expanded tile
  //price and type are valid
  //OR
  //is open now is valid :)
  bool get nameIsValid =>
      (restaurant.name != null && restaurant.name!.isNotEmpty);

  bool get photosAreValid =>
      (restaurant.photos != null && restaurant.photos!.isNotEmpty);

  bool get hoursAreValid =>
      (restaurant.hours != null && restaurant.hours!.isNotEmpty);

  bool get categoriesIsValid =>
      (restaurant.categories != null && restaurant.categories!.isNotEmpty);

  bool get priceAndTypeAreValid => (restaurant.price != null &&
      restaurant.price!.isNotEmpty &&
      categoriesIsValid &&
      restaurant.categories!.first.typeIsValid);

  bool get hasHours =>
      hoursAreValid &&
      restaurant.hours!.first.openHoursListIsValid &&
      restaurant.hours!.first.isOpenNow != null;

  bool get hasHeaderData => hasHours || priceAndTypeAreValid;
}

class DetailedRestaurantViewCubit extends Cubit<DetailedRestaurantViewState> {
  YelpRepo restaurantRepository = YelpRepo();
  final String alias;

  DetailedRestaurantViewCubit({required this.alias})
      : super(DetailedRestaurantViewLoadingState()) {
    load(alias: alias);
  }

  void load({required String alias}) async {
    if (alias.isEmpty) {
      emit(DetailedRestaurantViewErrorState());
      return;
    }
    try {
      final restaurant = await restaurantRepository.fetchRestaurant(alias);
      final reviews = await restaurantRepository.fetchReview(alias);
      if (restaurant.name == null || reviews.individualUserReviews.isEmpty) {
        emit(DetailedRestaurantViewErrorState());
      } else {
        emit(DetailedRestaurantViewLoadedState(
            restaurant: restaurant, reviews: reviews));
      }
    } catch (e) {
      emit(DetailedRestaurantViewErrorState());
    }
  }
}
