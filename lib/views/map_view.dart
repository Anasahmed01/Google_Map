import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _keyGooglePlex =
      CameraPosition(target: LatLng(24.9043140, 67.0576249), zoom: 14.4746);

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(24.9043140, 67.0576249),
        infoWindow: InfoWindow(title: "My current location")),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(24.844364, 67.193710),
        infoWindow: InfoWindow(title: "My current location"))
  ];

  LatLng point = LatLng(24.9043140, 67.0576249);
  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _keyGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Colors.white,
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                const CameraPosition(
                    target: LatLng(24.9043140, 67.0576249), zoom: 14),
              ),
            );
            setState(() {});
          },
          child: const Icon(
            Icons.my_location_sharp,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
