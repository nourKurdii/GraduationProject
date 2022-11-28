import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/HomePage/allLabs/location.dart';

import 'package:flutter_application/Screens/profile/profileScreen.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/map/tempHome.dart';

import 'Screens/mainScreen/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        // home: mainScreen()
        home: tempHome()
        //home: location()
        );
  }
}
