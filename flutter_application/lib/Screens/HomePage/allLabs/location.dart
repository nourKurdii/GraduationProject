import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class location extends StatefulWidget {



  @override
  locationState createState() => locationState();
}

class locationState extends State<location> {
   Completer<GoogleMapController> _controller = Completer();
 static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(title:Text('Lab Location',
     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25 ,
      fontFamily: 'Raleway')
          ),
            centerTitle: true,
     backgroundColor : AppColors.mainColor, 
  ),
  



body: Container(
  child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      height: 650,
      width: 400,
),

//AIzaSyDSBqFMm7F0xCfsTrEwfYtdm-XwVPrGY9s











  



    );
  }
}

class AppColors {

  static final Color mainColor = Color(0XFF6F36A5);
  }