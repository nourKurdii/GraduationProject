import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Screens/HomePage/allLabs/booking/homeBookingScreen.dart';

class CurrentLocationScreen extends StatefulWidget {
  String labEmail;
  List<String> unavailable;
  CurrentLocationScreen(this.labEmail, this.unavailable, {super.key});

  @override
  _CurrentLocationScreenState createState() =>
      _CurrentLocationScreenState(labEmail, unavailable);
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  Dio dio = new Dio();
  String labEmail;
  List<String> unavailable;
  _CurrentLocationScreenState(this.labEmail, this.unavailable);
  // savelocation(latitude, longitude, email) async {
  //   try {
  //     return await dio.put('http://10.0.2.2:3000/savelocation',
  //         data: {
  //           "email": email,
  //           "latitude": latitude,
  //           "longitude": longitude,
  //         },
  //         options: Options(contentType: HeademUrlEncodedContentType));
  //   } on DioError catch (e) {
  //     Fluttertoast.showToast(
  //   msg: e.response!.data['msg'],
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }

  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};
  var point ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your location",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Raleway')),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
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
                    Position position = await _determinePosition();

                    googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 14)),
                    );
                    point = LatLng(position.latitude, position.longitude);

                    markers.clear();

                    markers.add(Marker(
                        markerId: const MarkerId('currentLocation'),
                        position:
                            LatLng(position.latitude, position.longitude)));

                    setState(() {});
                  },
                  label: const Text("Current Location"),
                  icon: const Icon(Icons.location_history),
                  backgroundColor: kPrimaryColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeBookingScreen(labEmail,
                                unavailable, point.latitude, point.longitude)));
                    // savelocation(point.latitude, point.longitude, User.email)
                    //     .then((val) {
                    //   Fluttertoast.showToast(
                    //       msg: 'Saved successfully',
                    //       toastLength: Toast.LENGTH_SHORT,
                    //       gravity: ToastGravity.BOTTOM,
                    //       backgroundColor: kPrimaryLightColor,
                    //       textColor: Colors.black,
                    //       fontSize: 16.0);
                    // });
                  },
                  label: const Text("Submit"),
                  backgroundColor: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
