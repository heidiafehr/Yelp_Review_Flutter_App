import 'package:flutter_bloc/flutter_bloc.dart';

import '../list_of_restaurants.dart';
import '../yelp_repository.dart';

abstract class DetailedRestaurantViewState {}

class DetailedRestaurantViewLoadingState extends DetailedRestaurantViewState {}

class DetailedRestaurantViewErrorState extends DetailedRestaurantViewState {}

class DetailedRestaurantViewLoadedState extends DetailedRestaurantViewState {
  ListOfRestaurants restaurants;

  DetailedRestaurantViewLoadedState({
    required this.restaurants,
  });
}

class DetailedRestaurantViewCubit extends Cubit<DetailedRestaurantViewState> {
  YelpRepo api = YelpRepo();

  DetailedRestaurantViewCubit() : super(DetailedRestaurantViewLoadingState()) {
    load();
  }

  void load() async {
    try {
      final restaurants = await api.fetchListOfRestaurants();
      if (restaurants.listOfRestaurants.isEmpty) {
        emit(DetailedRestaurantViewErrorState());
      } else {
        emit(DetailedRestaurantViewLoadedState(restaurants: restaurants));
      }
    } catch (e) {
      emit(DetailedRestaurantViewErrorState());
    }
  }
}