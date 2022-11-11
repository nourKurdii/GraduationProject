import 'package:flutter/material.dart';

class reportCard extends StatelessWidget {
  const reportCard({
    Key? key,
    required this.name,
    required this.press,
    required this.labName,
    required this.time,
    required this.date,
  }) : super(key: key);
  final String name, labName, time, date;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          width: 242 / 375 * size.width,
          height: 100 / 375 * size.width,
          //height: getProportionateScreenWidth(100),
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75)),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Test Name : $name\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: "Lab Name : $labName\n"),
                      TextSpan(text: "date"),
                      TextSpan(text: "time")
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
