import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/mainScreen/mainScreen.dart';
import 'package:flutter_application/Screens/profile/changePassword/changePassword.dart';
import 'package:flutter_application/Screens/profile/components/profileMenu.dart';

import '../allBookings/allBookings.dart';
import '../homeVisits/homeVisits.dart';
import '../myAccount/UserAccount.dart';

class body extends StatelessWidget {
  const body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        // SizedBox(
        //   height: 115,
        //   width: 115,
        //   child: Stack(
        //     fit: StackFit.expand,
        //     clipBehavior: Clip.none,
        //     children: [
        //       CircleAvatar(
        //         backgroundImage: AssetImage("assets/images/avatar.png"),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 20,
        ),
        profileMenu(
          icon: Icons.person,
          text: "My Account",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const userAccount();
                },
              ),
            );
          },
        ),
        profileMenu(
          icon: Icons.home_filled,
          text: "My Home Visit",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const homeVisits();
                },
              ),
            );
          },
        ),

        profileMenu(
          icon: Icons.event,
          text: "My test Bookings",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const allBookings();
                },
              ),
            );
          },
        ),
       
        profileMenu(
          icon: Icons.location_city,
          text: "Doctor bookings",
          press: () {},
        ),
         profileMenu(
          icon: Icons.password,
          text: "Change password",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const changePassword();
                },
              ),
            );
          },
        ),
        profileMenu(
          icon: Icons.logout,
          text: "Log Out",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const mainScreen();
                },
              ),
            );
          },
        ),
      ]),
    );
  }
}
