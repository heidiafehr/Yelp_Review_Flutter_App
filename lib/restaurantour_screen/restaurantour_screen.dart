import 'package:flutter/material.dart';
import 'package:yelp_app/list_of_restaurants.dart';
import 'package:yelp_app/yelp_appbar.dart';
import '../yelp_repository.dart';

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
      body: ListView(
        children: [
          const CustomYelpAppBar('RestauranTour'),
          FutureBuilder<ListOfRestaurants>(
            future: futureListOfRestaurants,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Text(snapshot.data!.listOfRestaurants.length.toString());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
