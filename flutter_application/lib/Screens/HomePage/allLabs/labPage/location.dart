// ignore_for_file: must_be_immutable, camel_case_types, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../constants.dart';

class location extends StatefulWidget {
  double lat, long;
  location(this.lat, this.long, {super.key});
  @override
  locationState createState() => locationState(lat, long);
}

class locationState extends State<location> {
  double lat = 0.0;
  double long = 0.0;
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(32.2360758078, 35.233661981),
    zoom: 14.4746,
  );
  Set<Marker> markers = {};
  var point = const LatLng(0, 0);

  locationState(this.lat, this.long);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lab Location',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Raleway')),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
        ),
        body: Stack(children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    //heroTag: null,
                    onPressed: () async {
                      googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(lat, long), zoom: 14)),
                      );

                      markers.clear();

                      markers.add(Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: LatLng(lat, long)));

                      setState(() {});
                    },
                    label: const Text("Lab Location"),
                    icon: const Icon(Icons.location_history),
                    backgroundColor: kPrimaryColor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}

class AppColors {
  static  Color mainColor = Color(0xff425c5a);
}
