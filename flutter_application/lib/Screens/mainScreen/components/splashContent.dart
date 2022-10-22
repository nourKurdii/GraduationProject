import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../size_config.dart';

class splashContent extends StatelessWidget {
  const splashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Spacer(),
      Text("LAB",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: getProportionateScreenWidth(34),
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          )),
      Text(
        text,
        textAlign: TextAlign.center,
        style: (TextStyle(
            fontSize: getProportionateScreenWidth(15),
            color: Colors.grey.shade500)),
      ),
      Spacer(flex: 1),
      Image.asset(
        image,
        height: getProportionateScreenHeight(270),
        width: getProportionateScreenWidth(250),
      )
    ]);
  }
}
List<splashContent> splashData = [
  splashContent(
      text: "Welcom to LAB, let's get started",
      image: "assets/images/main1.png"),
  splashContent(
      text: "High Quality Laboratories", image: "assets/images/main2.png"),
  splashContent(
      text: "You Can Request a Home Visit", image: "assets/images/main3.png")
];
