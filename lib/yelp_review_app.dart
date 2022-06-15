import 'package:flutter/material.dart';
import 'package:yelp_app/home_screen.dart';
import 'package:yelp_app/restaurant_class.dart';

class YelpReviewApp extends StatefulWidget {
  const YelpReviewApp({Key? key}) : super(key: key);

  @override
  _YelpReviewAppState createState() => _YelpReviewAppState();
}

class _YelpReviewAppState extends State<YelpReviewApp> {
  Restaurant? futureRestaurant;

  @override
  void initState() {
    super.initState();
    getRestaurant();
  }

  void getRestaurant() async{
    final result = await fetchRestaurant();
    setState(() {
      futureRestaurant = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home_screen',
      routes: {
        '/home_screen': (context) => HomeScreen(
              appBarTitle: futureRestaurant?.name,
            ),
      },
    );
  }
}
