import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/HomePage/allTests/allTests.dart';

import '../Labsmap.dart';
import 'categories.dart';

class listView extends StatelessWidget {
  const listView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Center(
                child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => allTests()));
              },
              child: categories(
                icon: 'assets/images/report.svg',
                text: " Tests",
              ),
            )),
            Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => labsMap()));
                    },
                    child: categories(
                        icon: 'assets/images/tube.svg', text: " Labs"))),
            Center(
                child: categories(
                    icon: 'assets/images/report.svg', text: " Tips  ")),
          ],
        ),
      ),
    );
  }
}
