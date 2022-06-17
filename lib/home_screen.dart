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
              body: ListView(
            children: <Widget>[
              AppBar(
                //centered, w/ white background and black text
                //ellipsis when the text is too long
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white.withOpacity(0.5),
                  //sets status bar background to white
                  statusBarIconBrightness: Brightness.dark,
                  //sets text colors to dark color
                  statusBarBrightness: Brightness.dark,
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
              snapshot.data?.image != null && snapshot.data!.image.isNotEmpty
                  ? Image.network(snapshot.data!.image)
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    Text(snapshot.data!.price),
                    Text(' ${snapshot.data!.categories.first.title}'),
                    const Spacer(),
                    if (snapshot.data!.hours.first.isOpenNow)
                      Row(
                        children: const [
                          Text('Open Now ',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 12.0,
                          )
                        ],
                      )
                    else
                      Row(
                        children: const [
                          Text('Closed Now ',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 12.0,
                          )
                        ],
                      ),
                  ],
                ),
              ),
              const Divider(
                height: 0.0,
                indent: 30.0,
                color: Colors.grey,
                endIndent: 30.0,
              ),
              /*Padding(
                padding: const EdgeInsets.all(30.0),
                child: const Text('Address'),
              ),*/
            ],
          ));
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
