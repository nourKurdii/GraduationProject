import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';

class reportCard extends StatelessWidget {
  const reportCard({
    Key? key,
    required this.name,
    required this.press,
    required this.labName,
    required this.time,
    required this.date,
    required this.labinfo,
  }) : super(key: key);
  final String name, labName, time, date;
  final List labinfo;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: press,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: SizedBox(
                width: size.width,
                height: 100 / 375 * size.width,
                //height: getProportionateScreenWidth(100),
                child: ClipRRect(
                  //borderRadius: BorderRadius.circular(20),
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: inputFieldBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Test Name : $name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Lab Name : $labName",
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_month),
                                  SizedBox(width: 6),
                                  Text(date),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.access_time_outlined,
                                  ),
                                  SizedBox(width: 6),
                                  Text(time),
                                ],
                              )
                            ]),
                      ),
                    ),
                  ]),
                ))));
  }
}
