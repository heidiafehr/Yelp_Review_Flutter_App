import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:yelp_app/detailed_restaurant_view_screen/widgets/display_user_reviews.dart';
import 'package:yelp_app/individual_user_reviews.dart';

///individualUserReviews is/is not empty
/// is - expected to find sizedBox widget
/// is not - find ListView (continue checks for widgets inside of listView)
///individualUserReviews TEXT is/is not null
/// is - expected a not to find a Card widget
/// is not - expected a Card widget
///ratingNumber is/is not null
/// is - expected to find nothing
/// is not - expected to find RatingBarIndicator widget
///user.imageURL is/is not null
/// is - expected Initicon widget
/// is not - expected CircleAvatar
///*will check name in golden*

void main() {
  Widget individualReviewsIsNull = const MaterialApp(
    home: Scaffold(
      body: DisplayUserReviews(
        totalNumberOfReviews: 1,
      ),
    ),
  );

  Widget individualReviewsIsValid = MaterialApp(
    home: Scaffold(
      body: DisplayUserReviews(
        totalNumberOfReviews: 1,
        individualUserReviews: [
          IndividualUserReviews(
            user: UserInfo(imageURL: 'test image', name: 'test name'),
            text: 'test review',
            ratingNumber: 3.0,
          )
        ],
      ),
    ),
  );

  Widget textIsNotValid = MaterialApp(
    home: Scaffold(
      body: DisplayUserReviews(
        totalNumberOfReviews: 1,
        individualUserReviews: [
          IndividualUserReviews(
            user: UserInfo(imageURL: 'test image', name: 'test name'),
            text: null,
            ratingNumber: 3.0,
          )
        ],
      ),
    ),
  );

  Widget ratingNumberIsNotValid = MaterialApp(
    home: Scaffold(
      body: DisplayUserReviews(
        totalNumberOfReviews: 1,
        individualUserReviews: [
          IndividualUserReviews(
            user: UserInfo(imageURL: 'test image', name: 'test name'),
            text: 'test text',
            ratingNumber: null,
          )
        ],
      ),
    ),
  );

  Widget imageUrlIsNotValid = MaterialApp(
    home: Scaffold(
      body: DisplayUserReviews(
        totalNumberOfReviews: 1,
        individualUserReviews: [
          IndividualUserReviews(
            user: UserInfo(imageURL: null, name: 'test name'),
            text: 'test text',
            ratingNumber: 3.0,
          )
        ],
      ),
    ),
  );

  testWidgets('individualUserReviews list is empty/null', (tester) async {
    final tile = individualReviewsIsNull;
    await tester.pumpWidget(tile);
    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets('individualUserReviews is not empty', (tester) async {
    final tile = individualReviewsIsValid;
    await mockNetworkImagesFor(() => tester.pumpWidget(tile));
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('text is valid', (tester) async {
    final tile = individualReviewsIsValid;
    await mockNetworkImagesFor(() => tester.pumpWidget(tile));
    expect(find.byType(Card), findsOneWidget);
  });

  //Doesn't work tbh Idk, but I am not spending any more time on this
  //look at display_user_reviews line 39
  //it should work >:(
  testWidgets('text is NOT valid', (tester) async{
    final tile = textIsNotValid;
    await mockNetworkImagesFor(() => tester.pumpWidget(tile));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('rating number is NOT valid', (tester) async {
    final tile = ratingNumberIsNotValid;
    await mockNetworkImagesFor(() => tester.pumpWidget(tile));
    expect(find.byType(RatingBarIndicator), findsNothing);
  });

  testWidgets('rating number is valid', (tester) async {
    final tile = individualReviewsIsValid;
    await mockNetworkImagesFor(() => tester.pumpWidget(tile));
    expect(find.byType(RatingBarIndicator), findsOneWidget);
  });

  testWidgets('imageURL is NOT valid', (tester) async {
    final tile = imageUrlIsNotValid;
    await mockNetworkImagesFor(() => tester.pumpWidget(tile));
    expect(find.byType(Initicon), findsOneWidget);
  });

  testWidgets('imageURL is valid', (tester) async {
    final tile = individualReviewsIsValid;
    await mockNetworkImagesFor(() => tester.pumpWidget(tile));
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}