import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_app/restaurantour_screen/restaurantour_screen_cubit.dart';
import 'package:yelp_app/restaurantour_screen/widgets/display_list_of_restaurants.dart';
import 'package:yelp_app/yelp_appbar.dart';

class RestauranTourScreen extends StatefulWidget {
  const RestauranTourScreen({Key? key}) : super(key: key);

  @override
  State<RestauranTourScreen> createState() => _RestauranTourScreen();
}

class _RestauranTourScreen extends State<RestauranTourScreen> {
  /*Future<ListOfRestaurants>? futureListOfRestaurants;
  APICall api = APICall();*/

  /*@override
  void initState() {
    super.initState();
    _getListOfRestaurants();
  }*/

  /*void _getListOfRestaurants() async {
    futureListOfRestaurants = api.fetchListOfRestaurants();
  }*/

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
          BlocProvider(
            create: (_) => RestauranTourCubit(),
            child: BlocBuilder<RestauranTourCubit, RestauranTourState>(
              builder: (context, state) {
                if (state is RestauranTourErrorState) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(
                      child: Text(
                          'Ooops something went wrong!\nAre you connected to the internet?'),
                    ),
                  );
                }
                if (state is RestauranTourLoadedState) {
                  return Expanded(
                    child: ListView(
                      children: [
                        DisplayListOfRestaurants(
                            restaurants: state.restaurants.listOfRestaurants)
                      ],
                    ),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
