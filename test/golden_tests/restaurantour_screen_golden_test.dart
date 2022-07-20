import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_app/service_locator.dart';
import 'package:yelp_app/yelp_repo/restaurant_catalog.dart';
import 'package:yelp_app/yelp_repo/restaurant_class.dart';
import 'package:yelp_app/yelp_repo/category.dart' as cat;
import 'package:yelp_app/restaurantour_screen/restaurantour_cubit.dart';
import 'package:yelp_app/restaurantour_screen/restaurantour_screen.dart';
import 'package:yelp_app/restaurantour_screen/widgets/card_restaurant_info.dart';

//**ASK how to make padding consistent across the devices**
  //ex: restaurantour_loaded_screen.png

//The best instructions ever by travis **matt(definitely matt if this doesn't work)
//make yelp image file
//return cache network image
//takes 1 (one) (single) parameters
//1 - imageUrl (required)
//inside this class , use getit to inject test helper class
//test helper class will have three functions
//  1 - isTestMode
//  2 - place holder image
//  3 - error image
//in yelp image -> check if it isTestMode
//   is - (and error is null) then we show place holder image
//  is not - show error image
//if !isTestMode
//  show imageUrl
//in our test we are going to mock testHelper class
//  for error test -> use when to tell when to return error widget of choice
//  for !errorTest -> return non-error widget of choice
//in setup of flutter test config
//  this class will always return true for isTestMode

class MockRestauranTourCubit extends MockCubit<RestauranTourState>
    implements RestauranTourCubit {}

void main() {
  late RestaurantCatalog mockCatalog;

  setUp(
    () {
      Restaurant mockRestaurant = Restaurant(
        name: 'Test Restaurant',
        image: 'image link',
        price: '\$\$\$',
        categories: [cat.Category(alias: 'some-alias', restaurantType: 'test')],
        apiAlias: 'test-restaurant',
        rating: 4.5,
      );

      mockCatalog = RestaurantCatalog(restaurantCatalog: [mockRestaurant]);
    },
  );

  tearDown(() {
    imageError = false;
  });

  testGoldens(
    'RestauranTour Loading Screen',
        (tester) async {
      MockRestauranTourCubit mockRestauranTour = MockRestauranTourCubit();
      getIt.registerSingleton<RestauranTourCubit>(mockRestauranTour);

      imageError = true;
      when(() => mockRestauranTour.load())
          .thenAnswer((_) async {});
      final builder = DeviceBuilder()..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ]);

      whenListen(
        mockRestauranTour,
        Stream.fromIterable(
          [
            RestauranTourLoadingState(),
          ],
        ),
        initialState: RestauranTourLoadingState(),
      );

      builder.addScenario(
        name: 'Loading',
        widget: RestauranTourScreen(),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'restaurantour_loading_screen');
    },
  );

  testGoldens(
    'RestauranTour Loaded Screen',
    (tester) async {
      MockRestauranTourCubit mockRestauranTour = MockRestauranTourCubit();
      getIt.registerSingleton<RestauranTourCubit>(mockRestauranTour);

      imageError = true;
      when(() => mockRestauranTour.load())
          .thenAnswer((_) async {});
      final builder = DeviceBuilder()..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ]);

      whenListen(
        mockRestauranTour,
        Stream.fromIterable(
          [
            RestauranTourLoadingState(),
            RestauranTourLoadedState(restaurants: mockCatalog),
          ],
        ),
        initialState: RestauranTourLoadingState(),
      );

      builder.addScenario(
        name: 'Loaded',
        widget: RestauranTourScreen(),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'restaurantour_loaded_screen');
    },
  );
}

