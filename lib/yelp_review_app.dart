import 'package:flutter/material.dart';

import 'package:yelp_app/home_screen.dart';

class YelpReviewApp extends StatelessWidget {
  const YelpReviewApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home_screen',
      routes: {
        '/home_screen' : (context) => const HomeScreen(),
      },
    );
  }
}