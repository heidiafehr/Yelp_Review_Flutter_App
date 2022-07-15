import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_expanded_hours_with_header.dart';
import 'package:yelp_app/hours.dart';

void main() {
  Widget displayExpandedHoursWithHeader = MaterialApp(
    home: Scaffold(
      body: DisplayHeaderWithExpandedHours(
        openHours: [
          OpenHours(isOvernight: false, start: '1000', end: '2200', day: 0)
        ],
        priceAndTypeAreValid: true,
        price: '\$',
        restaurantType: 'food',
        isOpenNow: true,
      ),
    ),
  );

  testWidgets('When Everything is right', (tester) async {
    final tile = displayExpandedHoursWithHeader;
    await tester.pumpWidget(tile);
    await tester.tap(find.byType(DisplayHeaderWithExpandedHours));
    await tester.pumpAndSettle();
    expect(find.text('10:00 AM - 10:00 PM'), findsWidgets);
  });
}
