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
      CameraPosition(target: LatLng(24.834394, 67.180149), zoom: 14.4746);

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(24.834394, 67.180149),
        infoWindow: InfoWindow(title: "My current location")),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(24.844364, 67.193710),
        infoWindow: InfoWindow(title: "My current location"))
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Google Map"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _keyGooglePlex,
          markers: Set<Marker>.of(_marker),
          // mapType: MapType.normal,
          // myLocationEnabled: true,
          // compassEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(24.834394, 67.180149), zoom: 14)));
          setState(() {});
        },
        child: Icon(Icons.location_disabled_outlined),
      ),
    );
  }
}
