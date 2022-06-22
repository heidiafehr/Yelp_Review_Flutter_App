import 'package:flutter/material.dart';
import 'package:yelp_app/api_call_class.dart';
import 'package:yelp_app/restaurant_class.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:yelp_app/review_class.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_app/yelp_appbar.dart';
import 'package:yelp_app/yelp_review_app.dart';

class HomeScreen extends StatefulWidget {
  final String? appBarTitle;

  const HomeScreen({@visibleForTesting this.appBarTitle, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Restaurant>? futureRestaurant;
  Future<Reviews>? futureReviews;
  APICall api = APICall();
  static const double _indent = 30.0;

  @override
  void initState() {
    super.initState();
    _getRestaurant();
    _getReview();
  }

  void _getRestaurant() async {
    futureRestaurant = null;
    futureRestaurant = api.fetchRestaurant();
  }

  void _getReview() async {
    futureReviews = null;
    futureReviews = api.fetchReview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FutureBuilder<Restaurant>(
            future: futureRestaurant,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (snapshot.data?.name != null &&
                            snapshot.data!.name.isNotEmpty)
                        ? CustomYelpAppBar(snapshot.data!.name)
                        : const CustomYelpAppBar(
                            'N/A Restaurant Name'),
                    if (snapshot.data?.image != null &&
                        snapshot.data!.image.isNotEmpty)
                      Image.network(snapshot.data!.image),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ExpansionTileCard(
                        title: Row(
                          children: [
                            if (snapshot.data?.price != null &&
                                snapshot.data!.price.isNotEmpty)
                              Text(snapshot.data!.price),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: snapshot.data?.categories.first
                                              .restaurantType !=
                                          null &&
                                      snapshot.data!.categories.first
                                          .restaurantType.isNotEmpty
                                  ? Text(
                                      snapshot.data!.categories.first
                                          .restaurantType,
                                      style: const TextStyle(fontSize: 13.5),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                if (snapshot.data?.hours.first.isOpenNow !=
                                    null)
                                  Text(
                                    (snapshot.data!.hours.first.isOpenNow)
                                        ? 'Open Now'
                                        : 'Closed Now',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13.5),
                                  ),
                                if (snapshot.data?.hours.first.isOpenNow !=
                                    null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Icon(
                                      Icons.circle,
                                      color:
                                          (snapshot.data!.hours.first.isOpenNow)
                                              ? Colors.green
                                              : Colors.red,
                                      size: 11.5,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        children: const [
                          Divider(
                            height: 0.0,
                            indent: _indent,
                            color: Colors.grey,
                            endIndent: _indent,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              child: Text('Does it work?'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const YelpDivider(),
                    Padding(
                      padding: const EdgeInsets.all(_indent),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Address'),
                          Padding(
                            padding: const EdgeInsets.only(top: _indent),
                            child: (snapshot.data!.isAddressValid)
                                ? Text(
                                    '${snapshot.data!.location.displayAddress.addressLineOne}'
                                    '\n${snapshot.data!.location.displayAddress.addressLineTwo}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          if (snapshot.data?.location.displayAddress
                                      .addressLineThree !=
                                  null &&
                              snapshot.data!.location.displayAddress
                                  .addressLineThree!.isNotEmpty)
                            Text(
                              snapshot.data!.location.displayAddress
                                  .addressLineThree!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                        ],
                      ),
                    ),
                    const YelpDivider(),
                    Padding(
                      padding: const EdgeInsets.all(_indent),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (snapshot.data?.rating != null)
                            const Text('Overall Rating'),
                          if (snapshot.data?.rating != null)
                            Padding(
                              padding: const EdgeInsets.only(top: _indent),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    snapshot.data!.rating,
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
                    ),
                    if (snapshot.data?.rating != null) const YelpDivider(),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          FutureBuilder<Reviews>(
            future: futureReviews,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (snapshot.data?.totalNumberOfReviews != null)
                      Padding(
                        padding: const EdgeInsets.all(_indent),
                        child: Text(
                            '${snapshot.data!.totalNumberOfReviews} Reviews'),
                      ),
                    if (snapshot.data?.individualUserReviews != null &&
                        snapshot.data!.individualUserReviews.isNotEmpty)
                      ListView.builder(
                        itemCount: snapshot.data!.individualUserReviews.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (_, index) {
                          return Card(
                            color: Colors.grey[50],
                            elevation: 0.0,
                            margin:
                                const EdgeInsets.symmetric(horizontal: _indent),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (snapshot.data?.individualUserReviews[index]
                                        .ratingNumber !=
                                    null)
                                  RatingBarIndicator(
                                    rating: snapshot
                                        .data!
                                        .individualUserReviews[index]
                                        .ratingNumber
                                        .toDouble(),
                                    itemBuilder: (context, index) =>
                                        const YelpStarIcon(),
                                    itemCount: snapshot
                                        .data!
                                        .individualUserReviews[index]
                                        .ratingNumber
                                        .toInt(),
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    snapshot.data!.individualUserReviews[index]
                                        .text,
                                    style: const TextStyle(
                                        fontSize: 18.0, height: 1.32),
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (snapshot
                                            .data!
                                            .individualUserReviews[index]
                                            .user
                                            .imageURL !=
                                        null)
                                      CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                          snapshot
                                              .data!
                                              .individualUserReviews[index]
                                              .user
                                              .imageURL!,
                                        ),
                                      ),
                                    if (snapshot
                                            .data
                                            ?.individualUserReviews[index]
                                            .user
                                            .name !=
                                        null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(snapshot
                                            .data!
                                            .individualUserReviews[index]
                                            .user
                                            .name),
                                      ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  child: Divider(
                                    color: Colors.grey,
                                    indent: 0.0,
                                    endIndent: 0.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
