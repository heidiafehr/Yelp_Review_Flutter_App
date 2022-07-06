import 'package:graphql/client.dart';
import 'package:location/location.dart';
import 'package:yelp_app/secrets.dart';
import 'list_of_restaurants.dart';

class GraphQLInstCall {
  late GraphQLClient client;

  GraphQLInstCall() {
    final httpLink = HttpLink(
      'https://api.yelp.com/v3/graphql',
    );

// This attaches our header for authorization
    final authLink = AuthLink(
      getToken: () async => 'Bearer $apiKey',
    );

// This combines the two above
    final Link link = authLink.concat(httpLink);

    // This just creates our client (just like we did for our RESTful calls)
    client = GraphQLClient(
      /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
      link: link,
    );
  }

  Future<ListOfRestaurants> fetchListOfRestaurants() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Failed to enable service');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Failed to get permission');
      }
    }
    locationData = await location.getLocation();

    const String yelpQuery = r'''
    query fetchYelpQuery($latitude: Float!, $longitude: Float!) {
       search(latitude: $latitude, longitude: $longitude) {
        business {
          name
          alias
          price
          categories{
            alias
            title
          }
          hours {
            is_open_now
            open {
              is_overnight
              start
              end
              day
            }
          }
          location {
            address1
            city
            state
            postal_code
          }
          rating
          alias
          photos
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(yelpQuery),
      variables: <String, dynamic>{
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
      },
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      throw Exception('Failed to load album');
    } else {
      return ListOfRestaurants.fromJson(result.data!['search']);
    }
  }
}
