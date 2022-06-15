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
      //centered, w/ white background and black text
      //ellipsis when the text is too long
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        //sets status bar background to white
        statusBarIconBrightness: Brightness.dark,
        //sets text colors to dark color
        statusBarBrightness: Brightness.light,
      ),

      elevation: 0.0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(44.0),
        child: Text(widget.appBarTitle ?? 'Restaurant Name Goes Here I',
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis),
      ),
      )
    );
  }
}

