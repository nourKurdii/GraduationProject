import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/Dashboard.dart';

import '../../../models/lab.dart';
import 'LabCard.dart';

class LabsSection extends StatelessWidget {
  const LabsSection({
    Key? key,
    required this.name,
    required this.Image,
    required this.Location,
  }) : super(key: key);
  final String name, Image, Location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Dashboard()));
      },
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                LabCard(
                  image: Image,
                  name: name,
                  location: Location,
                  press: () {},
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
