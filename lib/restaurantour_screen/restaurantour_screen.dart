import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yelp_app/list_of_restaurants.dart';
import 'package:yelp_app/restaurantour_screen/widgets/display_list_of_restaurants.dart';
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
            addNavigateBack: false,
          ),
          Expanded(
            child: ListView(
              children: [
                FutureBuilder<ListOfRestaurants>(
                  future: futureListOfRestaurants,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return DisplayListOfRestaurants(
                          restaurants: snapshot.data!.listOfRestaurants);
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
