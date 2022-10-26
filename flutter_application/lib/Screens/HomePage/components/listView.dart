import 'package:flutter/material.dart';

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
                child: categories(
              icon: 'assets/images/report.svg',
              text: " Tests",
            )),
            Center(
                child:
                    categories(icon: 'assets/images/tube.svg', text: " Labs")),
            Center(
                child: categories(
                    icon: 'assets/images/report.svg', text: " Tips  ")),
          ],
        ),
      ),
    );
  }
}
