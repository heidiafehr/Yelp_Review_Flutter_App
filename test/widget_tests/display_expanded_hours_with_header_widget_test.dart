import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_expanded_hours_with_header.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/price_and_alias.dart';
import 'package:yelp_app/yelp_repo/hours.dart';

///if all hours data is present
  ///should display the correct Text<Widget>
///if price and type are/are not valid
  ///are - PriceAndAlias is found
  ///are not - PirceAndAlias is not found

void main() {
  Widget allDataPresent = MaterialApp(
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

  Widget priceAndTypeAreNotValid = MaterialApp(
    home: Scaffold(
      body: DisplayHeaderWithExpandedHours(
        openHours: [
          OpenHours(isOvernight: false, start: '1000', end: '2200', day: 0)
        ],
        priceAndTypeAreValid: false,
        restaurantType: 'food',
        isOpenNow: true,
        price: null,
      ),
    ),
  );

  testWidgets('When all data is present', (tester) async {
    final tile = allDataPresent;
    await tester.pumpWidget(tile);
    await tester.tap(find.byType(DisplayHeaderWithExpandedHours));
    await tester.pumpAndSettle();
    expect(find.text('10:00 AM - 10:00 PM'), findsWidgets);
  });

  testWidgets('When priceAndType is not valid', (tester) async {
    final tile = priceAndTypeAreNotValid;
    await tester.pumpWidget(tile);
    await tester.tap(find.byType(DisplayHeaderWithExpandedHours));
    await tester.pumpAndSettle();
    expect(find.byType(PriceAndAlias), findsNothing);
    expect(find.byType(Spacer), findsNothing);
  });

  testWidgets('When priceAndType IS valid', (tester) async {
    final tile = allDataPresent;
    await tester.pumpWidget(tile);
    await tester.tap(find.byType(DisplayHeaderWithExpandedHours));
    await tester.pumpAndSettle();
    expect(find.byType(PriceAndAlias), findsOneWidget);
    expect(find.byType(Spacer), findsOneWidget);
  });
}
