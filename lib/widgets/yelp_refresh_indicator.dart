import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yelp_app/restaurantour_screen/restaurantour_cubit.dart';

import '../main.dart';

class YelpRefreshIndicator extends StatelessWidget {
  final Widget child;
  final AsyncCallback onRefresh;
  final RestauranTourState state;

  const YelpRefreshIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: child,
    );
  }
}