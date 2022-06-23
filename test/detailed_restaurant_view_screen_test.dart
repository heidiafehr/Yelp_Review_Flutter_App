import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_screen.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ])
      ..addScenario(
        widget: const DetailedRestaurantViewScreen(
          appBarTitle: 'Short and Simple',
        ),
        name: 'app bar with short name',
      );
    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'app_bar_with_short_name');
  });

  testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ])
      ..addScenario(
        widget: const DetailedRestaurantViewScreen(
          appBarTitle: 'Realyyy realy realy Reallyyyyyyy Long Title ',
        ),
        name: 'app bar with long name',
      );
    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'app_bar_with_long_name');
  });
}
