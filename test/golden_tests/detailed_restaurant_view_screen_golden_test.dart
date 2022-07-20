import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelp_app/yelp_repo/coordinates.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_cubit.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_screen.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_app/yelp_repo/hours.dart';
import 'package:yelp_app/yelp_repo/individual_user_reviews.dart';
import 'package:yelp_app/yelp_repo/location.dart';
import 'package:yelp_app/yelp_repo/restaurant_class.dart';
import 'package:yelp_app/yelp_repo/category.dart' as cat;
import 'package:yelp_app/yelp_repo/review_class.dart';

class MockDetailedRestaurantViewCubit extends Mock
    implements DetailedRestaurantViewCubit {}

void main() {
  late Restaurant mockRestaurant;
  late Reviews mockReviews;

  setUp(() {
    mockRestaurant = Restaurant(
        name: 'Restaurant Name Goes Here',
        price: '\$\$\$',
        categories: [
          cat.Category(
              alias: 'Test alias', restaurantType: 'Test restaurantType')
        ],
        hours: [
          Hours(isOpenNow: true, openHours: [
            OpenHours(isOvernight: true, start: '1000', end: '1600', day: 0)
          ]),
        ],
        location: Location(
          addressLineOne: '123 Test St',
          city: 'Atlantis',
          state: 'Water',
          zipcode: '123456',
        ),
        rating: 2,
        apiAlias: 'test-restaurant',
        photos: ['test image'],
        coordinates: const Coordinates(latitude: 42.0, longitude: 42.0));

    mockReviews = Reviews(
      individualUserReviews: [
        IndividualUserReviews(
          text: 'Test text',
          ratingNumber: 4.0,
          user: UserInfo(imageURL: 'test-image', name: 'test name'),
        ),
      ],
    );
  });

  tearDown(() {
    imageError = false;
  });

  testGoldens(
    'ehh test pt2',
    (tester) async {
      MockDetailedRestaurantViewCubit mockDetailedRestaurantViewCubit =
          MockDetailedRestaurantViewCubit();

      imageError = true;
      when(() => mockDetailedRestaurantViewCubit.load())
          .thenAnswer((_) => Future.value());

      when(() => mockDetailedRestaurantViewCubit.close())
          .thenAnswer((_) => Future.value());

      final builder = DeviceBuilder();

      whenListen(
        mockDetailedRestaurantViewCubit,
        Stream.fromIterable(
          [
            DetailedRestaurantViewLoadingState(),
            DetailedRestaurantViewLoadedState(
                restaurant: mockRestaurant, reviews: mockReviews)
          ],
        ),
        initialState: DetailedRestaurantViewLoadingState(),
      );

      builder.addScenario(
        name: 'loaded',
        widget: DetailedRestaurantViewScreen(
            alias: 'test-alias', cubit: mockDetailedRestaurantViewCubit),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'detailed_restaurant_loaded_screen');
    },
  );
}
/*
void main() {
  setUp(() {
    Restaurant(
        name: 'Restaurant Name Goes Here',
        price: '\$\$\$',
        categories: [
          cat.Category(
              alias: 'Test alias', restaurantType: 'Test restaurantType')
        ],
        hours: [
          Hours(isOpenNow: true, openHours: [
            OpenHours(isOvernight: true, start: '1000', end: '1600', day: 0)
          ]),
        ],
        location: Location(
          addressLineOne: '123 Test St',
          city: 'Atlantis',
          state: 'Water',
          zipcode: '123456',
        ),
        rating: 2,
        apiAlias: 'test-restaurant',
        photos: ['Test photos'],
        coordinates: const Coordinates(latitude: 42.0, longitude: 42.0));
  });
  */
/*testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ])
      ..addScenario(
        widget: const DetailedRestaurantViewScreen(
          appBarTitle: 'Short and Simple',
          alias: 'yuh',
        ),
        name: 'app bar with short name',
      );
    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'app_bar_with_short_name');
  });*/ /*


  testGoldens('ehhh its-a test', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ])
      ..addScenario(
        widget: const DetailedRestaurantViewScreen(
          appBarTitle: 'Restaurant Name Goes Here',
          alias: 'yuh',
        ),
        name: 'app bar with short name',
      );
    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'first test');
  });

  */
/*testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ])
      ..addScenario(
        widget: const DetailedRestaurantViewScreen(
          appBarTitle: 'Realyyy realy realy Reallyyyyyyy Long Title ',
          alias: 'yuh-pt-2',
        ),
        name: 'app bar with long name',
      );
    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'app_bar_with_long_name');
  });*/ /*

}
*/
