import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_app/list_of_restaurants.dart';
import 'package:yelp_app/graphql_instance_call.dart';
import '../yelp_repository.dart';

abstract class RestauranTourState {}

class RestauranTourLoadingState extends RestauranTourState {}

class RestauranTourErrorState extends RestauranTourState {}

class RestauranTourLoadedState extends RestauranTourState {
  ListOfRestaurants restaurants;

  RestauranTourLoadedState({
    required this.restaurants,
  });
}

class RestauranTourCubit extends Cubit<RestauranTourState> {

  GraphQLInstCall api = GraphQLInstCall();
  //used to call RestQL
  //YelpRepo api = YelpRepo();

  RestauranTourCubit() : super(RestauranTourLoadingState()) {
    load();
  }

  void load() async {
    emit(RestauranTourLoadingState());
    try {
      final restaurants = await api.fetchListOfRestaurants();
      if (restaurants.listOfRestaurants.isEmpty) {
        emit(RestauranTourErrorState());
      } else {
        emit(RestauranTourLoadedState(restaurants: restaurants));
      }
    } catch (e) {
      emit(RestauranTourErrorState());
    }
  }
}











