import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_app/coordinates.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_screen.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_app/hours.dart';
import 'package:yelp_app/location.dart';
import 'package:yelp_app/restaurant_class.dart';
import 'package:yelp_app/category.dart' as cat;

void main(){}
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
  });*//*


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
  });*//*

}
*/
