import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class profilePic extends StatelessWidget {
  const profilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.png"),
          ),
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
                height: 46,
                width: 46,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(27),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Color(0xfff5f6f9),
                    ),
                    onPressed: () {},
                    child: SvgPicture.asset("assets/images/Camera.svg"),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
