import 'package:yelp_app/yelp_repo/individual_user_reviews.dart';

class Reviews {
  final int? totalNumberOfReviews;
  final List<IndividualUserReviews> individualUserReviews;

  Reviews({
    this.totalNumberOfReviews,
    required this.individualUserReviews,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      totalNumberOfReviews: json['total'],
      individualUserReviews: (json['reviews'] as List)
          .map((reviewJson) => IndividualUserReviews.fromJson(reviewJson))
          .toList(),
    );
  }
}
