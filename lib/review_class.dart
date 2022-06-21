import 'package:yelp_app/single_review.dart';

class Reviews {
  final int totalNumberOfReviews;
  final List<SingleUserReview> singleUserReview;

  Reviews({
    required this.totalNumberOfReviews,
    required this.singleUserReview,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      totalNumberOfReviews: json['total'],
      singleUserReview: (json['reviews'] as List)
          .map((reviewJson) => SingleUserReview.fromJson(reviewJson))
          .toList(),
    );
  }
}
