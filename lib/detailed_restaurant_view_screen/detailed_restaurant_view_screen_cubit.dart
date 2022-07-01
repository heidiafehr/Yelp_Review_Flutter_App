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
}

class DetailedRestaurantViewCubit extends Cubit<DetailedRestaurantViewState> {
  YelpRepo restaurantRepository = YelpRepo();
  final String? alias;

  DetailedRestaurantViewCubit({required this.alias})
      : super(DetailedRestaurantViewLoadingState()) {
    load(alias);
  }

  void load(String? alias) async {
    try {
      final restaurant = await restaurantRepository.fetchRestaurant(alias!);
      final reviews = await restaurantRepository.fetchReview(alias);
      if (restaurant == null || reviews == null || alias == null) {
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
