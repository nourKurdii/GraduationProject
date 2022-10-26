import 'package:flutter/material.dart';

class LabCard extends StatelessWidget {
  const LabCard({
    Key? key,
    required this.name,
    required this.image,
    required this.press,
    required this.location,
  }) : super(key: key);
  final String name, image, location;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SizedBox(
        width: 242 / 375 * size.width,
        height: 100 / 375 * size.width,
        //height: getProportionateScreenWidth(100),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xff343434).withOpacity(0.4),
                    Color(0XFF343434).withOpacity(0.15)
                  ])),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "$name\n",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: location),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
