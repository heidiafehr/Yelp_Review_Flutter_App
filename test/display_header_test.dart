import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_header.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/open_status.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/price_and_alias.dart';

void main() {
  Widget allDataIsValid = const MaterialApp(
    home: Scaffold(
      body: DisplayHeader(
        priceAndTypeAreValid: true,
        price: '\$',
        restaurantType: 'food',
        isOpenNow: true,
      ),
    ),
  );

  Widget priceAndTypeAreNotValid = const MaterialApp(
    home: Scaffold(
      body: DisplayHeader(
        priceAndTypeAreValid: false,
        price: null,
        restaurantType: 'food',
        isOpenNow: true,
      ),
    ),
  );

  Widget openStatusIsNotValid = const MaterialApp(
    home: Scaffold(
      body: DisplayHeader(
        priceAndTypeAreValid: true,
        price: '\$',
        restaurantType: 'food',
        isOpenNow: null,
      ),
    ),
  );


  ///////ASK ABOUT: warning b/c there's no tap in this widget? but how do I
  ///////////////// do it?

  testWidgets('When all data is present', (tester) async {
    final tile = allDataIsValid;
    await tester.pumpWidget(tile);
    /*await tester.tap(find.byType(DisplayHeader));
    await tester.pumpAndSettle();*/
    expect(find.byType(PriceAndAlias), findsOneWidget);
    expect(find.byType(Spacer), findsOneWidget);
    expect(find.byType(OpenStatus), findsOneWidget);
  });

  testWidgets('When only priceAndType are NOT valid', (tester) async {
    final tile = priceAndTypeAreNotValid;
    await tester.pumpWidget(tile);
    /*await tester.tap(find.byType(DisplayHeader));
    await tester.pumpAndSettle();*/
    expect(find.byType(PriceAndAlias), findsNothing);
    expect(find.byType(Spacer), findsNothing);
    expect(find.byType(OpenStatus), findsOneWidget);
  });

  testWidgets('When only OpenStatus is NOT valid', (tester) async {
    final tile = openStatusIsNotValid;
    await tester.pumpWidget(tile);
    /*await tester.tap(find.byType(DisplayHeader));
    await tester.pumpAndSettle();*/
    expect(find.byType(PriceAndAlias), findsOneWidget);
    expect(find.byType(Spacer), findsOneWidget);
    expect(find.byType(OpenStatus), findsNothing);
  });

}
