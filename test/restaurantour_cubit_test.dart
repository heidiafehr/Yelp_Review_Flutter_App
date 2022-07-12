import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelp_app/category.dart';
import 'package:yelp_app/hours.dart';
import 'package:yelp_app/restaurant_catalog.dart';
import 'package:yelp_app/restaurant_class.dart';
import 'package:yelp_app/location.dart';

import 'mock_yelp_repo.dart';

void main() {
  final mockRepo = MockYelpRepo();
  setUp(() {
    Restaurant mockRestaurant = Restaurant(
        name: 'Mock Restaurant',
        price: 'cheap',
        image: 'Test image',
        hours: [
          Hours(isOpenNow: true, openHours: [
            OpenHours(isOvernight: true, start: 'now', end: 'never', day: 0)
          ]),
        ],
        categories: [
          Category(alias: 'Test alias', restaurantType: 'Test restaurantType')
        ],
        location: Location(
            addressLineOne: '123 Test st',
            city: 'Atlantis',
            state: 'Water',
            zipcode: '123456'),
        rating: 10000,
        apiAlias: 'best-mock-restaurant'
    );

    late RestaurantCatalog mockRestaurantCatalog =
    RestaurantCatalog(restaurantCatalog: [mockRestaurant]);

    //mock loaded state
    when(() => mockRepo.fetchRestaurantCatalog())
        .thenAnswer((_) => Future.value(mockRestaurantCatalog));
  });


}