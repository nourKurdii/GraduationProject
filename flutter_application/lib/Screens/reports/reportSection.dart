import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/Dashboard.dart';
import 'package:flutter_application/Screens/reports/reportCard.dart';

class reportSection extends StatelessWidget {
  const reportSection({
    Key? key,
    required this.name,
    required this.labName,
    required this.time,
    required this.date,
  }) : super(key: key);
  final String name, labName, time, date;

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
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                reportCard(
                  name: name,
                  labName: labName,
                  date: date,
                  time: time,
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
