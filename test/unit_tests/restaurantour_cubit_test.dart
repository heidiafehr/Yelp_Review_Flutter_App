import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelp_app/category.dart';
import 'package:yelp_app/hours.dart';
import 'package:yelp_app/restaurant_catalog.dart';
import 'package:yelp_app/restaurant_class.dart';
import 'package:yelp_app/location.dart';
import 'package:yelp_app/restaurantour_screen/restaurantour_cubit.dart';

import '../mock_yelp_repo.dart';

void main() {
  group('RestauranTourCubit test', () {
    final mockRepo = MockYelpRepo();
    late RestaurantCatalog mockRestaurantCatalog;

    setUp(() {
      Restaurant mockRestaurant = Restaurant(
          name: 'Mock Restaurant',
          image: 'Test image',
          price: 'cheap',
          categories: [
            Category(alias: 'Test alias', restaurantType: 'Test restaurantType')
          ],
          hours: [
            Hours(isOpenNow: true, openHours: [
              OpenHours(isOvernight: true, start: 'now', end: 'never', day: 1)
            ]),
          ],
          location: Location(
              addressLineOne: '123 Test st',
              city: 'Atlantis',
              state: 'Water',
              zipcode: '123456'),
          rating: 5,
          apiAlias: 'best-mock-restaurant');
      mockRestaurantCatalog =
          RestaurantCatalog(restaurantCatalog: [mockRestaurant]);
    });

    blocTest(
      'emits RestauranTourLoadedState for successful load',
      build: () {
        when(() => mockRepo.fetchRestaurantCatalog())
            .thenAnswer((_) => Future.value(mockRestaurantCatalog));
        return RestauranTourCubit(api: mockRepo);
      },
      act: (RestauranTourCubit cubit) => cubit.load(),
      expect: () => [
        isA<RestauranTourLoadingState>(),
        isA<RestauranTourLoadedState>()],
    );

    blocTest(
      'emits RestaurantTourErrorState',
      build: () {
        when(() => mockRepo.fetchRestaurantCatalog())
            .thenThrow(() => Exception());
        return RestauranTourCubit(api: mockRepo);
      },
      act: (RestauranTourCubit cubit) => cubit.load(),
      expect: () => [
        isA<RestauranTourLoadingState>(),
        isA<RestauranTourErrorState>()],
    );
  });
}
