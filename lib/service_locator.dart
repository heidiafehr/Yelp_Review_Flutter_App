import 'package:get_it/get_it.dart';
import 'package:yelp_app/restaurantour_screen/restaurantour_cubit.dart';
import 'package:yelp_app/yelp_repo/yelp_repo.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<YelpRepo>(YelpRepo());
  getIt.registerSingleton<RestauranTourCubit>(RestauranTourCubit());
}

void setupTestDependencies() {
  getIt.allowReassignment = true;
}

