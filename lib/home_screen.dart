import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yelp_app/api_call_class.dart';
import 'package:yelp_app/restaurant_class.dart';

class HomeScreen extends StatefulWidget {
  final String? appBarTitle;

  const HomeScreen({@visibleForTesting this.appBarTitle, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Restaurant>? futureRestaurant;
  APICall api = APICall();

  @override
  void initState() {
    super.initState();
    _getRestaurant();
  }

  void _getRestaurant() async {
    futureRestaurant = api.fetchRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: futureRestaurant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(widget.appBarTitle ?? snapshot.data!.name,
                    style: const TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            body:
            Image.network(snapshot.data!.image),
          );

        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
