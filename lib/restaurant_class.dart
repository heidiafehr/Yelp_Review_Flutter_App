import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Restaurant> fetchRestaurant() async {
  final response = await http.get(
      Uri.parse(
          'https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco'),
      headers: {
        'Authorization':
        'Bearer wigdsJl9SwNA3dZ3S0hjTtXyUZy6iLmQPFcPEkN2J_nVGcQOoPT5g1JCmF4IEjvAmArwWSCFR6Y-0nk_drkVefLFrrKpDA3LsLsP39U13rf3eCqMSffpH-fIu22mYnYx',
      }
  );

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

class Restaurant {
  final String name;

  Restaurant({
    required this.name,
    });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
    );
  }
}