import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_app/individual_user_reviews.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import '../../yelp_review_app.dart';

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
        if (individualUserReviews != null && individualUserReviews!.isNotEmpty)
          ListView.builder(
            itemCount: individualUserReviews!.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, index) {
              return Card(
                color: Colors.grey[50],
                elevation: 0.0,
                margin: EdgeInsets.symmetric(horizontal: _indent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (individualUserReviews?[index].ratingNumber != null)
                      RatingBarIndicator(
                        rating: individualUserReviews![index]
                            .ratingNumber
                            .toDouble(),
                        itemBuilder: (context, index) => const YelpStarIcon(),
                        itemCount:
                            individualUserReviews![index].ratingNumber.toInt(),
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        individualUserReviews![index].text,
                        style: const TextStyle(fontSize: 18.0, height: 1.32),
                      ),
                    ),
                    Row(
                      children: [
                        (individualUserReviews![index].user.imageURL != null)
                            ? CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                  individualUserReviews![index].user.imageURL!,
                                ),
                              )
                            : Initicon(
                                text: (individualUserReviews?[index]
                                            .user
                                            .name !=
                                        null)
                                    ? individualUserReviews![index].user.name
                                    : 'N A',
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                              (individualUserReviews?[index].user.name != null)
                                  ? individualUserReviews![index].user.name
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
