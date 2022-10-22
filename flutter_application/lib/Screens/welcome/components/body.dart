// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/LogIn/LogInScreen.dart';
import 'package:flutter_application/Screens/welcome/components/background.dart';
import 'package:flutter_application/Screens/welcome/components/roundedButton.dart';
import 'package:flutter_application/constants.dart';

import '../../SignUp/SignUpScreen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image.asset("assets/images/welcome_page.jpg",
                width: size.width * 0.6),
            SizedBox(
              height: size.height * 0.04,
            ),
            roundedButton(
              text: "LOG IN",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogInScreen(),
                    ));
              },
              color: kPrimaryColor,
              textColor: Colors.white,
            ),
            roundedButton(
              text: "SIGN UP",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ));
              },
              color: kPrimaryLightColor,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
