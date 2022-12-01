import 'package:flutter/material.dart';

import '../Screens/HomePage/Labsmap.dart';
import 'map.dart';

class tempHome extends StatefulWidget {
  const tempHome({super.key});

  @override
  State<tempHome> createState() => _tempHome();
}

class _tempHome extends State<tempHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ElevatedButton(
      onPressed: () {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => labsMap()));
      },
      child: Text('Go To Map'),
    ),
        ));
  }
}
