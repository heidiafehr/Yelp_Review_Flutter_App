import 'package:flutter_bloc/flutter_bloc.dart';
import '../restaurant_catalog.dart';
import '../yelp_repo/yelp_repo.dart';

abstract class RestauranTourState {}

class RestauranTourLoadingState extends RestauranTourState {}

class RestauranTourErrorState extends RestauranTourState {}

class RestauranTourLoadedState extends RestauranTourState {
  RestaurantCatalog restaurants;

  RestauranTourLoadedState({
    required this.restaurants,
  });
}

class RestauranTourCubit extends Cubit<RestauranTourState> {

  //used to call RestQL
  YelpRepo api = YelpRepo();

  RestauranTourCubit() : super(RestauranTourLoadingState()) {
    load();
  }

  void load() async {
    emit(RestauranTourLoadingState());
    try {
      final restaurants = await api.fetchRestaurantCatalog();
      if (restaurants.restaurantCatalog.isEmpty) {
        emit(RestauranTourErrorState());
      } else {
        emit(RestauranTourLoadedState(restaurants: restaurants));
      }
    } catch (e) {
      emit(RestauranTourErrorState());
    }
  }
}











