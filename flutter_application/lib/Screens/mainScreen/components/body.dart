import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/mainScreen/components/splashContent.dart';
import 'package:flutter_application/constants.dart';

import '../../welcome/components/roundedButton.dart';
import '../../welcome/welcomeScreen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => splashContent(
                    text: splashData[index].text,
                    image: splashData[index].image,
                  ),
                )),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        splashData.length, (index) => dot(index: index)),
                  ),
                  Spacer(),
                  roundedButton(
                    text: "Continue",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => welcomeScreen(),
                          ));
                    },
                    color: kPrimaryColor,
                    textColor: Colors.white,
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer dot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
