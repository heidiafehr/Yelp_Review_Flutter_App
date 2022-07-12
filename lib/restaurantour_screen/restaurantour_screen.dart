import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yelp_app/restaurantour_screen/restaurantour_cubit.dart';
import 'package:yelp_app/restaurantour_screen/widgets/display_restaurant_catalog.dart';
import 'package:yelp_app/yelp_appbar.dart';

class RestauranTourScreen extends StatefulWidget {
  const RestauranTourScreen({Key? key}) : super(key: key);

  @override
  State<RestauranTourScreen> createState() => _RestauranTourScreen();
}

class _RestauranTourScreen extends State<RestauranTourScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RestauranTourCubit(),
        child: Column(
          children: [
            const CustomYelpAppBar(
              title: 'RestauranTour',
              elevations: 3.0,
              addNavigateBack: false,
            ),
            Expanded(
              child: BlocBuilder<RestauranTourCubit, RestauranTourState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<RestauranTourCubit>().load();
                      return;
                    },
                    child: ListView(
                      children: [
                        if (state is RestauranTourLoadedState)
                          DisplayRestaurantCatalog(
                            restaurants: state.restaurants.restaurantCatalog,
                          ),
                        if (state is RestauranTourLoadingState)
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 1.3,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                        if (state is RestauranTourErrorState)
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 1.3,
                            child: const Center(
                              child: Text('Ooops something went wrong!'
                                  '\nAre you connected to the internet?'),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
