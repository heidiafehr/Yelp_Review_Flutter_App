import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yelp_app/api_call_class.dart';
import 'package:yelp_app/restaurant_class.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:yelp_app/review_class.dart';

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
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white.withOpacity(0.5),
                        //sets status bar background to white
                        statusBarIconBrightness: Brightness.dark,
                        //sets text colors to dark color
                        statusBarBrightness: Brightness.dark,
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                      centerTitle: true,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: (snapshot.data?.name != null &&
                                snapshot.data!.name.isNotEmpty)
                            ? Text(widget.appBarTitle ?? snapshot.data!.name,
                                style: Theme.of(context).textTheme.headline1,
                                overflow: TextOverflow.ellipsis)
                            : const Text('Restaurant Name Not Available'),
                      ),
                    ),
                    snapshot.data?.image != null &&
                            snapshot.data!.image.isNotEmpty
                        ? Image.network(snapshot.data!.image)
                        : const SizedBox.shrink(),
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
                    const Divider(
                      height: 0.0,
                      indent: _indent,
                      color: Colors.grey,
                      endIndent: _indent,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(_indent),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Address'),
                          Padding(
                            padding: const EdgeInsets.only(top: _indent),
                            child: (snapshot.data != null &&
                                    snapshot.data!.isAddressValid)
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
                    const Divider(
                      height: 0.0,
                      indent: _indent,
                      color: Colors.grey,
                      endIndent: _indent,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(_indent),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Overall Rating'),
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
                                  transform:
                                      Matrix4.translationValues(0.0, 2.5, 0.0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow[700],
                                    size: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0.0,
                      indent: _indent,
                      color: Colors.grey,
                      endIndent: _indent,
                    ),
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
                    Padding(
                      padding: const EdgeInsets.all(_indent),
                      child: Text(
                          '${snapshot.data!.totalNumberOfReviews} Reviews'),
                    ),
                    ListView.builder(
                      itemCount: snapshot.data!.singleUserReview.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return Card(
                          color: Colors.grey[50],
                          elevation: 0.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: _indent),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot
                                    .data!.singleUserReview[index].text),
                                //Text(snapshot.data!.singleUserReview.first.user.name),
                              ],
                            ),
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
