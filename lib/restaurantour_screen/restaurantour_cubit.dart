import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_app/service_locator.dart';
import '../yelp_repo/restaurant_catalog.dart';
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
  YelpRepo api = getIt<YelpRepo>();

  RestauranTourCubit() : super(RestauranTourLoadingState());

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











