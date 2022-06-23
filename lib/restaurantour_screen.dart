import 'package:flutter/material.dart';
import 'package:yelp_app/yelp_appbar.dart';

class RestauranTourScreen extends StatelessWidget {
  const RestauranTourScreen({Key? key,}) : super(key :key);

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: CustomYelpAppBar('RestauranTour'),
    );
  }
}