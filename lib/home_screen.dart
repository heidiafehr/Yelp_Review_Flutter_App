import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yelp_app/restaurant_class.dart';

class HomeScreen extends StatefulWidget {
  final String? appBarTitle;

  const HomeScreen({@visibleForTesting this.appBarTitle, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //centered, w/ white background and black text
          //ellipsis when the text is too long
        systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        //sets status bar background to white
        statusBarIconBrightness: Brightness.dark,
        //sets text colors to dark color
        statusBarBrightness: Brightness.light,
        ),

        //call set state to grab string name
          //create a Restaurant type object
          //update name
          //pass that object to Text rather than hard code


        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text(widget.appBarTitle ?? 'Restaurant Name Goes Here I',
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis),
        ),
    ));
  }
}
