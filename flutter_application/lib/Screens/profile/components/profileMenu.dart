import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../mainScreen/mainScreen.dart';

class profileMenu extends StatelessWidget {
  const profileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(20),
              backgroundColor: inputFieldBackground,
            ),
            onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return mainScreen();
                    },
                  ),
                );
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 22,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ));
  }
}
