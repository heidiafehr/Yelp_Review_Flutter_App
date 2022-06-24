import 'package:flutter/material.dart';

import '../../yelp_review_app.dart';

class DisplayOverallRating extends StatelessWidget{

  final String? rating;
  final double _indent = 30.0;

  const DisplayOverallRating({Key? key, this.rating}) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(_indent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rating != null)
            const Text('Overall Rating'),
          if (rating != null)
            Padding(
              padding: EdgeInsets.only(top: _indent),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    rating!.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        fontFamily: 'LoraBold'),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        0.0, 2.5, 0.0),
                    child: const YelpStarIcon(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}