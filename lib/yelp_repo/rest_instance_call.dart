import 'package:yelp_app/restaurant_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yelp_app/review_class.dart';
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

  /*Future<ListOfRestaurants> fetchListOfRestaurants() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Failed to enable service');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Failed to get permission');
      }
    }
    locationData = await location.getLocation();

    final response = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/search?latitude=${locationData.latitude}&longitude=${locationData.longitude}'),
        headers: {
          'Authorization':
              'Bearer wigdsJl9SwNA3dZ3S0hjTtXyUZy6iLmQPFcPEkN2J_nVGcQOoPT5g1JCmF4IEjvAmArwWSCFR6Y-0nk_drkVefLFrrKpDA3LsLsP39U13rf3eCqMSffpH-fIu22mYnYx',
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ListOfRestaurants.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }*/
}
