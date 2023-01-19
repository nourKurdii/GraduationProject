import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../chat/HomeScreen.dart';
import '../../../models/user.dart';
import '../../HomePage/homePage.dart';
import '../../reports/allreports.dart';
import '../profileScreen.dart';
import 'enums.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.selectedMeu,
  }) : super(key: key);

  final MenuState selectedMeu;
  //User user = new User('', '');

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xffb6b6b6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xffdadada).withOpacity(0.15))
          ]),
      child: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return homePage(User.getName());
                    },
                  ),
                );
              },
              icon: SvgPicture.asset("assets/images/homepage.svg",
                  color: MenuState.home == selectedMeu
                      ? kPrimaryColor
                      : inActiveIconColor)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const reportsPage();
                    },
                  ),
                );
              },
              icon: SvgPicture.asset("assets/images/report.svg",
                  color: MenuState.report == selectedMeu
                      ? kPrimaryColor
                      : inActiveIconColor)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Chat(User.email);
                    },
                  ),
                );
              },
              icon: SvgPicture.asset("assets/images/chat.svg",
                  color: MenuState.chat == selectedMeu
                      ? kPrimaryColor
                      : inActiveIconColor)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const profileScreen();
                    },
                  ),
                );
              },
              icon: SvgPicture.asset("assets/images/UserIcon.svg",
                  color: MenuState.profile == selectedMeu
                      ? kPrimaryColor
                      : inActiveIconColor)),
        ],
      )),
    );
  }
}
