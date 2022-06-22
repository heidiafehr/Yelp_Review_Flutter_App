import 'package:flutter/material.dart';
import 'package:yelp_app/home_screen/home_screen.dart';
import 'package:yelp_app/restaurantour_screen.dart';

class YelpReviewApp extends StatefulWidget {
  const YelpReviewApp({Key? key}) : super(key: key);

  @override
  _YelpReviewAppState createState() => _YelpReviewAppState();
}

class _YelpReviewAppState extends State<YelpReviewApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'LoraBold'),
        ),
        dividerTheme: const DividerThemeData(
          space: 0.0,
          thickness: 0.0,
          color: Colors.grey,
          indent: 30.0,
          endIndent: 30.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.amber,
          size: 20.0,
        ),
      ),
      initialRoute: '/home_screen',
      routes: {
        '/restaurantour_screen': (context) => const RestauranTourScreen(),
        '/home_screen': (context) => const HomeScreen(),
      },
    );
  }
}

class YelpDivider extends StatelessWidget {
  final double? indents;
  const YelpDivider({Key? key, this.indents}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final dividerTheme = Theme.of(context).dividerTheme;
    return Divider(
      height: dividerTheme.space,
      thickness: dividerTheme.thickness,
      color: dividerTheme.color,
      indent: indents ?? dividerTheme.indent,
      endIndent: indents ?? dividerTheme.endIndent,
    );
  }
}

class YelpStarIcon extends StatelessWidget {
  const YelpStarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final iconThemes = Theme.of(context).iconTheme;
    return IconTheme(
      data: IconThemeData(color: iconThemes.color, size: iconThemes.size),
      child: const Icon(Icons.star),
    );
  }
}