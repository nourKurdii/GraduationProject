import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/reports/reportCard.dart';

class reportSection extends StatelessWidget {
  const reportSection({
    Key? key,
    required this.name,
    required this.labName,
    required this.time,
    required this.date,
    required this.press, required this.labinfo,
  }) : super(key: key);
  final String name, labName, time, date;
  final GestureTapCallback press;
  final List labinfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    labinfo:labinfo,
                    date: date,
                    time: time,
                    press: press),
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
