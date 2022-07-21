import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelp_app/service_locator.dart';
import 'package:yelp_app/yelp_repo/category.dart';
import 'package:yelp_app/yelp_repo/coordinates.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/detailed_restaurant_view_cubit.dart';
import 'package:yelp_app/yelp_repo/hours.dart';
import 'package:yelp_app/yelp_repo/individual_user_reviews.dart';
import 'package:yelp_app/yelp_repo/restaurant_class.dart';
import 'package:yelp_app/yelp_repo/location.dart';
import 'package:yelp_app/yelp_repo/review_class.dart';
import 'package:yelp_app/yelp_repo/yelp_repo.dart';
import '../mock_yelp_repo.dart';

void main() {
  group('DetailedRestaurantView test', () {
    final mockRepo = MockYelpRepo();
    late Restaurant mockRestaurant;
    late Reviews mockReviews;

    setUp(() {
      getIt.registerSingleton<YelpRepo>(mockRepo);
      mockRestaurant = Restaurant(
          name: 'Mock Restaurant',
          price: 'cheap',
          categories: [
            Category(alias: 'Test alias', restaurantType: 'Test restaurantType')
          ],
          hours: [
            Hours(isOpenNow: true, openHours: [
              OpenHours(isOvernight: true, start: 'now', end: 'never', day: 1)
            ]),
          ],
          location: Location(
              addressLineOne: '123 Test st',
              city: 'Atlantis',
              state: 'Water',
              zipcode: '123456'),
          rating: 5,
          apiAlias: 'best-mock-restaurant',
          photos: ['Test photos'],
          coordinates: const Coordinates(latitude: 42.0, longitude: 42.0));

      mockReviews = Reviews(
        totalNumberOfReviews: 3,
        individualUserReviews: [
          IndividualUserReviews(
            text: 'Test review text',
            ratingNumber: 3,
            user: UserInfo(imageURL: 'test image', name: 'test name'),
          ),
        ],
      );
    });

    blocTest(
      'emits DetailedRestaurantViewLoadedState for successful load',
      build: () {
        when(() => mockRepo.fetchRestaurant(any()))
            .thenAnswer((_) => Future.value(mockRestaurant));
        when(() => mockRepo.fetchReview(any()))
            .thenAnswer((_) => Future.value(mockReviews));
        return DetailedRestaurantViewCubit(
            alias: 'test-alias');
      },
      act: (DetailedRestaurantViewCubit cubit) =>
          cubit.load(),
      expect: () => [
        isA<DetailedRestaurantViewLoadingState>(),
        isA<DetailedRestaurantViewLoadedState>()
      ],
    );

    blocTest(
      'emits DetailedRestaurantViewErrorState for bad load',
      build: () {
        when(() => mockRepo.fetchRestaurant(any()))
            .thenThrow((_) => Future.value(mockRestaurant));
        when(() => mockRepo.fetchReview(any()))
            .thenThrow((_) => Future.value(mockReviews));
        return DetailedRestaurantViewCubit(
            alias: 'test-alias');
      },
      act: (DetailedRestaurantViewCubit cubit) =>
          cubit.load(),
      expect: () => [
        isA<DetailedRestaurantViewLoadingState>(),
        isA<DetailedRestaurantViewErrorState>()
      ],
    );
  });
}
