import 'package:yelp_app/single_restaurant_info_screen/single_restaurant_info_screen.dart';
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
        widget: const SingleRestaurantInfoScreen(appBarTitle: 'Short and Simple',),
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
            widget: const SingleRestaurantInfoScreen(appBarTitle: 'Realyyy realy realy Reallyyyyyyy Long Title ',),
            name: 'app bar with long name',
          );
        await tester.pumpDeviceBuilder(builder);

        await screenMatchesGolden(tester, 'app_bar_with_long_name');
      });
}
