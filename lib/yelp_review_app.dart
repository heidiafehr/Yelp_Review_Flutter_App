import 'package:flutter/material.dart';
import 'package:yelp_app/home_screen.dart';

class YelpReviewApp extends StatefulWidget {
  const YelpReviewApp({Key? key}) : super(key: key);

  @override
  _YelpReviewAppState createState() => _YelpReviewAppState();
}

class _YelpReviewAppState extends State<YelpReviewApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home_screen',
      routes: {
        '/home_screen': (context) => const HomeScreen(),
      },
    );
  }
}
