import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_app/individual_user_reviews.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import '../../yelp_review_app.dart';

///displays each User Review
///assumes individualUserReviews list is not empty and is valid

class DisplayUserReviews extends StatelessWidget {
  final _indent = 30.0;
  final int? totalNumberOfReviews;
  final List<IndividualUserReviews>? individualUserReviews;

  const DisplayUserReviews({
    Key? key,
    this.totalNumberOfReviews,
    this.individualUserReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (totalNumberOfReviews != null)
          Padding(
            padding: EdgeInsets.all(_indent),
            child: Text('$totalNumberOfReviews Reviews'),
          ),
        ListView.builder(
          itemCount: individualUserReviews!.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (_, index) {
            final review = individualUserReviews![index];
            if (!review.textIsValid) return const SizedBox.shrink();
            return Card(
              color: Colors.grey[50],
              elevation: 0.0,
              margin: EdgeInsets.symmetric(horizontal: _indent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (review.ratingNumber != null)
                    RatingBarIndicator(
                      rating: review.ratingNumber!.toDouble(),
                      itemBuilder: (context, index) => const YelpStarIcon(),
                      itemCount: review.ratingNumber!.toInt(),
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      review.text!,
                      style: const TextStyle(fontSize: 18.0, height: 1.32),
                    ),
                  ),
                  Row(
                    children: [
                      (review.user.imageURL != null)
                          ? CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                review.user.imageURL!,
                              ),
                            )
                          : Initicon(
                              text: (review.reviewNameIsValid)
                                  ? review.user.name
                                  : 'N A',
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text((review.reviewNameIsValid)
                            ? review.user.name!
                            : 'Yelp User'),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: YelpDivider(
                      indents: 0.0,
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
