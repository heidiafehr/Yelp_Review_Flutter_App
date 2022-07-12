import 'package:yelp_app/yelp_repo/graphql_instance_call.dart';
import 'package:yelp_app/yelp_repo/rest_instance_call.dart';
import '../restaurant_catalog.dart';
import '../restaurant_class.dart';
import '../review_class.dart';

class YelpRepo {
  final restaurantCatalog = GraphQLInstCall();
  final restaurantDataAndReviews = RestInstCall();

  YelpRepo._internal();

  static final YelpRepo _singleton = YelpRepo._internal();

  factory YelpRepo() {
    return _singleton;
  }

  Future<RestaurantCatalog> fetchRestaurantCatalog() async {
    return restaurantCatalog.fetchRestaurantCatalog();
  }

  Future<Restaurant> fetchRestaurant(String alias) async {
    return restaurantDataAndReviews.fetchRestaurant(alias);
  }

  Future<Reviews> fetchReview(String alias) async {
    return restaurantDataAndReviews.fetchReview(alias);
  }
}