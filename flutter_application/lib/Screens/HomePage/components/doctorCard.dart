import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/doctor.dart';
import '../../../size_config.dart';
import '../../Dashboard.dart';

class doctorCard extends StatelessWidget {
  const doctorCard({
    Key? key,
    required this.d,
  }) : super(key: key);
  final doctor d;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => Dashboard()));
        },
        child: SizedBox(
            width: getProportionateScreenWidth(100),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: inputFieldBackground,
              ),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.05,
                    child: Container(
                      //decoration: BoxDecoration(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          d.image,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    d.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    d.title,
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
