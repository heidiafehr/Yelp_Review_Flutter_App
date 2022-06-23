import 'package:yelp_app/restaurant_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

import 'package:yelp_app/review_class.dart';

class APICall {
  Future<Restaurant> fetchRestaurant() async {
    final response = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco'),
        headers: {
          'Authorization':
              'Bearer wigdsJl9SwNA3dZ3S0hjTtXyUZy6iLmQPFcPEkN2J_nVGcQOoPT5g1JCmF4IEjvAmArwWSCFR6Y-0nk_drkVefLFrrKpDA3LsLsP39U13rf3eCqMSffpH-fIu22mYnYx',
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Reviews> fetchReview() async {

    final responseReview = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco/reviews'),
        headers: {
          'Authorization':
              'Bearer wigdsJl9SwNA3dZ3S0hjTtXyUZy6iLmQPFcPEkN2J_nVGcQOoPT5g1JCmF4IEjvAmArwWSCFR6Y-0nk_drkVefLFrrKpDA3LsLsP39U13rf3eCqMSffpH-fIu22mYnYx',
        });

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

  Future<Restaurant> fetchListOfRestaurants() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        throw Exception('Failed to enable service');
      }
    }

    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted) {
        throw Exception('Failed to get permission');
      }
    }

    _locationData = await location.getLocation();

    final responseReview = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/search?latitude=${_locationData.latitude}&longitude=${_locationData.longitude}'),
        headers: {
          'Authorization':
          'Bearer wigdsJl9SwNA3dZ3S0hjTtXyUZy6iLmQPFcPEkN2J_nVGcQOoPT5g1JCmF4IEjvAmArwWSCFR6Y-0nk_drkVefLFrrKpDA3LsLsP39U13rf3eCqMSffpH-fIu22mYnYx',
        });

    if (responseReview.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Restaurant.fromJson(jsonDecode(responseReview.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

}
