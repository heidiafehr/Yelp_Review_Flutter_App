import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    //examples of text strings to see the ellipsis truncation
    //const String textExample1 = 'This is a reallyyyyy long restaurant nameeee';
    //const String textExample2 = 'Medium Restaurant Name This Is';
    //const String textExample3 = 'Short and Simple';

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          //sets status bar background to white
          statusBarIconBrightness: Brightness.dark,
          //sets text colors to dark color
          statusBarBrightness: Brightness.light,
        ),
        
        backgroundColor: Colors.white,
        elevation: 0.0,   //removes drop shadow
        title: const Center(
          child: Text('Restaurant name goes here',
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
