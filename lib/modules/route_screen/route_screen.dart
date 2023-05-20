import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' show LocationData;

import '../../config/config.dart';
import '../../models/place_location.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({
    super.key,
    required this.sourceLocation,
    required this.destinationLocation,
  });

  final Location sourceLocation;
  final Location destinationLocation;

  LatLng get source {
    return LatLng(sourceLocation.latitude, sourceLocation.longitude);
  }

  LatLng get destination {
    return LatLng(destinationLocation.latitude, destinationLocation.longitude);
  }

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController googleMapController;
  late StreamSubscription<LocationData> locationSubscription;
  List<LatLng> polylineCoordinate = [];
  LocationData? currentLocation;

  void getCurrentLocation() async {
    TrainingApp.myLocation.getLocation().then((location) {
      currentLocation = location;
      setState(() {});
    });
    googleMapController = await _controller.future;
    locationSubscription =
        TrainingApp.myLocation.onLocationChanged.listen(changeCurrentLocation);
  }

  changeCurrentLocation(newLocation) {
    currentLocation = newLocation;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(newLocation.latitude!, newLocation.longitude!),
          zoom: 13.5,
        ),
      ),
    );
    setState(() {});
  }

  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  );

  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/source_location_icon(128).png',
    ).then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/destination_location_icon(128).png',
    ).then((icon) {
      destinationIcon = icon;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    locationSubscription.cancel();
    super.dispose();
  }

  void getPolylinePoints() async {
    TrainingApp.polylinePoints = PolylinePoints();
    PolylineResult result =
        await TrainingApp.polylinePoints.getRouteBetweenCoordinates(
      TrainingApp.API_KEY,
      PointLatLng(widget.source.latitude, widget.source.longitude),
      PointLatLng(widget.destination.latitude, widget.destination.longitude),
    );
    if (result.points.isNotEmpty) {
      for (PointLatLng point in result.points) {
        polylineCoordinate.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setCustomMarker();
    getCurrentLocation();
    getPolylinePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route Map')),
      body: currentLocation == null
          ? const Center(
              child: Text('Loading...'),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('Route'),
                  points: polylineCoordinate,
                  color: Colors.blueAccent,
                  width: 4,
                )
              },
              markers: {
                Marker(
                  markerId: const MarkerId('Current Location'),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  icon: currentLocationIcon,
                ),
                Marker(
                  markerId: const MarkerId('Source'),
                  position: widget.source,
                  icon: sourceIcon,
                ),
                Marker(
                  markerId: const MarkerId('Destination'),
                  position: widget.destination,
                  icon: destinationIcon,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
