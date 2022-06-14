import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //examples of text strings to see the ellipsis truncation
    //const String text_example1 = 'This is a reallyyyyy long restaurant nameeee';
    //const String text_example2 = 'Medium Restaurant Name This Is';
    //const String text_example3 = 'Short and Simple';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text('Restaurant name goes here',
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
