import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_app/main.dart';
import 'package:yelp_app/service_locator.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUpAll(() {
    isTestMode = true;
  });
  setupTestDependencies();
  await loadAppFonts();
  return testMain();
}
