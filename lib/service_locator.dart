import 'package:get_it/get_it.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_cubit.dart';
import 'package:yelp_app/restaurantour_screen/restaurantour_cubit.dart';
import 'package:yelp_app/yelp_repo/yelp_repo.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<YelpRepo>(YelpRepo());
  getIt.registerSingleton<RestauranTourCubit>(RestauranTourCubit());
  getIt.registerSingleton<DetailedRestaurantViewCubit>(
      DetailedRestaurantViewCubit(alias: 'test-alias'));
}

void setupTestDependencies() {
  getIt.allowReassignment = true;
}
