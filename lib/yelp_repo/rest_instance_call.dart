import 'package:yelp_app/yelp_repo/restaurant_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yelp_app/yelp_repo/review_class.dart';
import 'package:yelp_app/secrets.dart';

class RestInstCall {

  Future<Restaurant> fetchRestaurant(String apiAlias) async {
    final response = await http.get(
      Uri.parse('https://api.yelp.com/v3/businesses/$apiAlias'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Restaurant.fromRestJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Reviews> fetchReview(String apiAlias) async {
    final responseReview = await http.get(
      Uri.parse('https://api.yelp.com/v3/businesses/$apiAlias/reviews'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (responseReview.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Reviews.fromJson(jsonDecode(responseReview.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
