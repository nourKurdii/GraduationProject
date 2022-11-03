import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/mainScreen/mainScreen.dart';
import 'package:flutter_application/Screens/profile/components/profileMenu.dart';
import 'package:flutter_application/Screens/profile/components/profilePic.dart';

import '../myAccount/UserAccount.dart';

class body extends StatelessWidget {
  const body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        profilePic(),
        SizedBox(
          height: 20,
        ),
        profileMenu(
          icon: "assets/images/UserIcon.svg",
          text: "My Account",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return userAccount();
                },
              ),
            );
          },
        ),
        profileMenu(
          icon: "assets/images/bell.svg",
          text: "Notification",
          press: () {},
        ),
        profileMenu(
          icon: "assets/images/map.svg",
          text: "My Home Visit",
          press: () {},
        ),
        profileMenu(
          icon: "assets/images/tube.svg",
          text: "My test Bookings",
          press: () {},
        ),
        profileMenu(
          icon: "assets/images/logout.svg",
          text: "Log Out",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return mainScreen();
                },
              ),
            );
          },
        ),
      ]),
    );
  }
}
