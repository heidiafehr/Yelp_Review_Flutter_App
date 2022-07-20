import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_screen.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUpAll(() {
    imageError = true;
  });
  await loadAppFonts();
  return testMain();
}
