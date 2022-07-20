import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../yelp_repo/coordinates.dart';

class GoogleMapWindow extends StatefulWidget {
  final String restaurantName;
  final Coordinates coordinates;

  const GoogleMapWindow({
    Key? key,
    required this.restaurantName,
    required this.coordinates,
  }) : super(key: key);

  @override
  State<GoogleMapWindow> createState() => _GoogleMapWindowState();
}

class _GoogleMapWindowState extends State<GoogleMapWindow> {
  late Coordinates coordinates;
  late LatLng _restaurantPosition;

  final Set<Marker> _markers = {};

  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    coordinates = widget.coordinates;
    _restaurantPosition = LatLng(coordinates.latitude!, coordinates.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 350,
      child: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) =>
            _googleMapController = controller,
            initialCameraPosition: CameraPosition(
              target: _restaurantPosition,
              zoom: 15.0,
            ),
            markers: _markers
              ..add(
                Marker(
                  markerId: MarkerId(widget.restaurantName),
                  position: _restaurantPosition,
                ),
              ),
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
              ),
            },
          ),
          Align(
            alignment: const Alignment(.93, .60),
            child: SizedBox(
              height: 42,
              width: 42,
              child: FloatingActionButton(
                backgroundColor: Colors.red.shade600,
                onPressed: () => _googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _restaurantPosition,
                      zoom: 15.0,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.my_location,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}