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
  static const double _indent = 30.0;

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
                        style: Theme.of(context).textTheme.headline1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                snapshot.data?.image != null && snapshot.data!.image.isNotEmpty
                    ? Image.network(snapshot.data!.image)
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.all(_indent),
                  child: Row(
                    children: [
                      Text(snapshot.data!.price),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(snapshot.data!.categories.first.title),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                              (snapshot.data!.hours.first.isOpenNow)
                                  ? 'Open Now'
                                  : 'Closed Now',
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic)),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Icon(
                              Icons.circle,
                              color: (snapshot.data!.hours.first.isOpenNow)
                                  ? Colors.green
                                  : Colors.red,
                              size: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.0,
                  indent: _indent,
                  color: Colors.grey,
                  endIndent: _indent,
                ),
                Padding(
                  padding: const EdgeInsets.all(_indent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Address'),
                      Padding(
                        padding: const EdgeInsets.only(top: _indent),
                        child: Text(
                          '${snapshot.data!.location.displayAddress.addressLineOne}'
                          '\n${snapshot.data!.location.displayAddress.addressLineTwo}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      snapshot.data?.location.displayAddress.addressLineThree !=
                                  null &&
                              snapshot.data!.location.displayAddress
                                  .addressLineThree!.isNotEmpty
                          ? Text(
                              snapshot.data!.location.displayAddress
                                  .addressLineThree!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.0,
                  indent: _indent,
                  color: Colors.grey,
                  endIndent: _indent,
                ),
                Padding(
                  padding: const EdgeInsets.all(_indent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Overall Rating'),
                      Padding(
                        padding: const EdgeInsets.only(top: _indent),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              snapshot.data!.rating,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0,
                                  fontFamily: 'LoraBold'),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.0,
                  indent: _indent,
                  color: Colors.grey,
                  endIndent: _indent,
                ),
              ],
            ),
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
