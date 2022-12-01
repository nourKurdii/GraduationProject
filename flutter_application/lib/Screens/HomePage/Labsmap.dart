import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

import 'allLabs/labPage.dart';

class labsMap extends StatefulWidget {
  const labsMap({super.key});

  @override
  State<labsMap> createState() => _labsMap();
}

Future<List> fetchLab() async {
  try {
    var res = await http.get(
      Uri.parse("http://10.0.2.2:3000/getLabInfo"),
    );
    if (res.statusCode == 200) {
      var obj = jsonDecode(res.body);
      //print(obj);
      return jsonDecode(res.body);
    } else
      return Future.error('error');
  } catch (error) {
    return Future.error(error);
  }
}

class _labsMap extends State<labsMap> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(32.2360758078, 35.233661981), zoom: 14);

  Set<Marker> markers = {};
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  LatLng point = LatLng(0, 0);
  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Labs",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Raleway')),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Stack(children: [
        FutureBuilder<List>(
            future: fetchLab(),
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                print("no Data");
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                var length = (snapshot.data as dynamic).length;
                for (var i = 0; i < length; i++) {
                  point = LatLng(snapshot.data[i]['latitude'],
                      snapshot.data[i]['longitude']);
                  markers.add(Marker(
                      onTap: () {
                        if (_customInfoWindowController.addInfoWindow != null) {
                          _customInfoWindowController.addInfoWindow!(
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: kPrimaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              snapshot.data[i]['image']),
                                          fit: BoxFit.fitWidth,
                                          filterQuality: FilterQuality.high),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      //color: Colors.red
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          labpage(snapshot
                                                              .data[i]['_id'])));
                                            },
                                            child: Text(
                                              snapshot.data[i]['name'],
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              softWrap: false,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Text("Ratting " +
                                            snapshot.data[i]['rating']
                                                .toString())
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Text(
                                      "lab Describtion",
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            LatLng(snapshot.data[i]['latitude'],
                                snapshot.data[i]['longitude']),
                          );
                        }
                      },
                      markerId: MarkerId('$i'),
                      position: LatLng(snapshot.data[i]['latitude'],
                          snapshot.data[i]['longitude'])));
                  print(snapshot.data[i]['latitude']);
                  print(snapshot.data[i]['longitude']);
                }

                return Stack(
                  children: [
                    GoogleMap(
                      onTap: (position) {
                        _customInfoWindowController.hideInfoWindow!();
                      },
                      onCameraMove: (position) {
                        _customInfoWindowController.onCameraMove!();
                      },
                      initialCameraPosition: initialCameraPosition,
                      markers: markers,
                      zoomControlsEnabled: true,
                      mapType: MapType.normal,
                      onMapCreated: (GoogleMapController controller) {
                        //googleMapController = controller;
                        _customInfoWindowController.googleMapController =
                            controller;
                      },
                    ),
                    CustomInfoWindow(
                      controller: _customInfoWindowController,
                      height: 170,
                      width: 200,
                      offset: 35,
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            })),
      ]),
    );
  }
}
