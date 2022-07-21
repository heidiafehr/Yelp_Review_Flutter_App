import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_app/main.dart';
import 'package:yelp_app/service_locator.dart';
import 'package:yelp_app/yelp_repo/restaurant_catalog.dart';
import 'package:yelp_app/yelp_repo/restaurant_class.dart';
import 'package:yelp_app/yelp_repo/category.dart' as cat;
import 'package:yelp_app/restaurantour_screen/restaurantour_cubit.dart';
import 'package:yelp_app/restaurantour_screen/restaurantour_screen.dart';

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

  testGoldens(
    'RestauranTour Loading Screen',
        (tester) async {
      MockRestauranTourCubit mockRestauranTour = MockRestauranTourCubit();
      getIt.registerSingleton<RestauranTourCubit>(mockRestauranTour);

      isTestMode = true;
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
        widget: const RestauranTourScreen(),
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

      isTestMode = true;
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
        widget: const RestauranTourScreen(),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'restaurantour_loaded_screen');
    },
  );

  testGoldens(
    'RestauranTour Error Screen',
        (tester) async {
      MockRestauranTourCubit mockRestauranTour = MockRestauranTourCubit();
      getIt.registerSingleton<RestauranTourCubit>(mockRestauranTour);

      isTestMode = true;
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
            RestauranTourErrorState(),
          ],
        ),
        initialState: RestauranTourLoadingState(),
      );

      builder.addScenario(
        name: 'Error',
        widget: const RestauranTourScreen(),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'restaurantour_error_screen');
    },
  );
}


