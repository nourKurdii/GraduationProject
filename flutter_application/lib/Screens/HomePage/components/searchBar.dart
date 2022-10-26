import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_svg/svg.dart';

class searchBar extends StatelessWidget {
  const searchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: inputFieldBackground),
        child: TextField(
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: kPrimaryColor,
              ),
              /*SvgPicture.asset(
                "assets/images/search.svg",
                width: 1,
                color: kPrimaryColor,
              ),*/
              border: InputBorder.none,
              hintText: "How Can We Help You?"),
        ),
      ),
    );
  }
}
