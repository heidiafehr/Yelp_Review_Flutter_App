import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_app/service_locator.dart';
import '../yelp_repo/restaurant_class.dart';
import '../yelp_repo/review_class.dart';
import '../yelp_repo/yelp_repo.dart';

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

  bool get _locationIsValid => restaurant.location != null;

  bool get addressIsValid =>
      _locationIsValid &&
      restaurant.location!.addressLineOne != null &&
      restaurant.location!.city != null &&
      restaurant.location!.state != null &&
      restaurant.location!.zipcode != null &&
      restaurant.location!.addressLineOne!.isNotEmpty &&
      restaurant.location!.city!.isNotEmpty &&
      restaurant.location!.state!.isNotEmpty &&
      restaurant.location!.zipcode!.isNotEmpty;

  bool get overallRatingIsValid =>
      reviews.totalNumberOfReviews != null &&
      !reviews.totalNumberOfReviews!.isNegative;

  bool get individualReviewsAreValid =>
      reviews.individualUserReviews.isNotEmpty;

  bool get reviewTextIsValid =>
      individualReviewsAreValid &&
      reviews.individualUserReviews.first.text != null &&
      reviews.individualUserReviews.first.text!.isNotEmpty;

  bool get coordinatesAreValid =>
      restaurant.coordinates != null &&
      restaurant.coordinates!.latitude != null &&
      restaurant.coordinates!.longitude != null;
}

class DetailedRestaurantViewCubit extends Cubit<DetailedRestaurantViewState> {
  //YelpRepo restaurantRepository = YelpRepo();
  late String alias;
  YelpRepo restaurantRepository = getIt<YelpRepo>();

  /*DetailedRestaurantViewCubit({required this.alias, YelpRepo? yelpRepo})
      : super(DetailedRestaurantViewLoadingState()) {
    restaurantRepository = yelpRepo ?? YelpRepo();
  }*/

  DetailedRestaurantViewCubit({required this.alias}) : super(DetailedRestaurantViewLoadingState());

  void load() async {
    emit(DetailedRestaurantViewLoadingState());
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
