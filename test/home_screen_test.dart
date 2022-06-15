import 'package:yelp_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
        widget: const HomeScreen(appBarTitle: 'Short and Simple',),
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
            widget: const HomeScreen(appBarTitle: 'Realyyy realy realy Reallyyyyyyy Long Title ',),
            name: 'app bar with long name',
          );
        await tester.pumpDeviceBuilder(builder);

        await screenMatchesGolden(tester, 'app_bar_with_long_name');
      });
}
