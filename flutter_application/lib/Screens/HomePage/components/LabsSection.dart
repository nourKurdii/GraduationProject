// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../allLabs/labPage/labPage.dart';
import 'LabCard.dart';

class LabsSection extends StatelessWidget {
  const LabsSection({
    Key? key,
    required this.name,
    required this.Image,
    required this.Location,
    required this.labId,
  }) : super(key: key);
  final String name, Image, Location;
  final String labId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => labpage(labId)));
      },
      child: Column(
        children: [
          const SizedBox(
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
                const SizedBox(
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
