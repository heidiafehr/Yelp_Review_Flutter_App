import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_app/list_of_restaurants.dart';
import 'package:yelp_app/yelp_appbar.dart';
import '../yelp_repository.dart';
import '../yelp_review_app.dart';

class RestauranTourScreen extends StatefulWidget {
  const RestauranTourScreen({Key? key}) : super(key: key);

  @override
  State<RestauranTourScreen> createState() => _RestauranTourScreen();
}

class _RestauranTourScreen extends State<RestauranTourScreen> {
  Future<ListOfRestaurants>? futureListOfRestaurants;
  APICall api = APICall();

  @override
  void initState() {
    super.initState();
    _getListOfRestaurants();
  }

  void _getListOfRestaurants() async {
    futureListOfRestaurants = api.fetchListOfRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomYelpAppBar(
            title: 'RestauranTour',
            elevations: 3.0,
            addLeadingIcon: false,
          ),
          Expanded(
            child: ListView(
              children: [
                FutureBuilder<ListOfRestaurants>(
                  future: futureListOfRestaurants,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: snapshot.data!.listOfRestaurants.length,
                        itemBuilder: (_, index) {
                          return Card(
                            margin: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                                topLeft: Radius.circular(15.0),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/detailed_restaurant_view_screen',
                                    arguments: snapshot.data!
                                        .listOfRestaurants[index].apiAlias);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .3,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                            fit: BoxFit.cover,
                                            snapshot
                                                .data!
                                                .listOfRestaurants[index]
                                                .image),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .51,
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .listOfRestaurants[index]
                                                    .name,
                                                style: const TextStyle(
                                                    fontSize: 17.5,
                                                    fontFamily: 'LoraRegular'),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Text(snapshot
                                                    .data!
                                                    .listOfRestaurants[index]
                                                    .price),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(snapshot
                                                      .data!
                                                      .listOfRestaurants[index]
                                                      .categories
                                                      .first
                                                      .restaurantType),
                                                ),
                                              ],
                                            ),
                                            RatingBarIndicator(
                                              rating: snapshot
                                                  .data!
                                                  .listOfRestaurants[index]
                                                  .rating
                                                  .toDouble(),
                                              itemBuilder: (context, index) =>
                                                  const YelpStarIcon(),
                                              itemCount: snapshot
                                                  .data!
                                                  .listOfRestaurants[index]
                                                  .rating
                                                  .toInt(),
                                              itemSize: 20.0,
                                              direction: Axis.horizontal,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
