import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_app/list_of_restaurants.dart';

import '../yelp_repository.dart';

abstract class RestauranTourState {}

class RestauranTourLoadingState extends RestauranTourState {}

class RestauranTourLoadedState extends RestauranTourState {
  ListOfRestaurants restaurants;

  RestauranTourLoadedState({
    required this.restaurants,
  });
}

class RestauranTourCubit extends Cubit<RestauranTourState> {
  APICall api = APICall();

  RestauranTourCubit() : super(RestauranTourLoadingState()) {
    load();
  }

  void load() async {
    final restaurants = await api.fetchListOfRestaurants();
    emit(RestauranTourLoadedState(restaurants: restaurants));
  }
}
