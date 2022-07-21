import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelp_app/main.dart';
import 'package:yelp_app/service_locator.dart';
import 'package:yelp_app/yelp_repo/coordinates.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_cubit.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_screen.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_app/yelp_repo/hours.dart';
import 'package:yelp_app/yelp_repo/individual_user_reviews.dart';
import 'package:yelp_app/yelp_repo/location.dart';
import 'package:yelp_app/yelp_repo/restaurant_class.dart';
import 'package:yelp_app/yelp_repo/category.dart' as cat;
import 'package:yelp_app/yelp_repo/review_class.dart';
import 'package:yelp_app/yelp_repo/yelp_repo.dart';

import '../mock_yelp_repo.dart';

void main() {
  late Restaurant mockRestaurant;
  late Reviews mockReviews;
  late YelpRepo yelpRepo;

  setUp(() {
    yelpRepo = MockYelpRepo();
    mockRestaurant = Restaurant(
        name: 'Restaurant Name Goes Here',
        price: '\$\$\$',
        categories: [
          cat.Category(
              alias: 'Test alias', restaurantType: 'Test restaurantType')
        ],
        hours: [
          Hours(isOpenNow: true, openHours: [
            OpenHours(isOvernight: true, start: '1000', end: '1600', day: 0)
          ]),
        ],
        location: Location(
          addressLineOne: '123 Test St',
          city: 'Atlantis',
          state: 'Water',
          zipcode: '123456',
        ),
        rating: 2,
        apiAlias: 'test-restaurant',
        photos: ['test image'],
        coordinates: const Coordinates(latitude: 42.0, longitude: 42.0));

    mockReviews = Reviews(
      individualUserReviews: [
        IndividualUserReviews(
          text: 'Test text',
          ratingNumber: 4.0,
          user: UserInfo(imageURL: 'test-image', name: 'test name'),
        ),
      ],
    );
    getIt.registerSingleton<YelpRepo>(yelpRepo);
  });

  testGoldens(
    'ehh test pt2',
    (tester) async {
      /* MockDetailedRestaurantViewCubit mockDetailedRestaurantViewCubit =
          MockDetailedRestaurantViewCubit();*/
      /*getIt.registerSingleton<DetailedRestaurantViewCubit>(
          mockDetailedRestaurantViewCubit);*/

      isTestMode = true;
      /*when(() => mockDetailedRestaurantViewCubit.load(alias: 'test-alias'))
          .thenAnswer((_) async {});

      when(() => mockDetailedRestaurantViewCubit.close())
          .thenAnswer((_) async {});*/

      final builder = DeviceBuilder();

      /*whenListen(
        mockDetailedRestaurantViewCubit,
        Stream.fromIterable(
          [
            DetailedRestaurantViewLoadingState(),
            DetailedRestaurantViewLoadedState(
                restaurant: mockRestaurant, reviews: mockReviews)
          ],
        ),
        initialState: DetailedRestaurantViewLoadingState(),
      );*/

      when(() => yelpRepo.fetchRestaurant(any()))
          .thenAnswer((_) => Future.value(mockRestaurant));

      when(() => yelpRepo.fetchReview(any()))
          .thenAnswer((_) => Future.value(mockReviews));


      builder.addScenario(
        name: 'loaded',
        widget: const DetailedRestaurantViewScreen(alias: 'test-alias'),
      );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'detailed_restaurant_loaded_screen');
    },
  );
}
