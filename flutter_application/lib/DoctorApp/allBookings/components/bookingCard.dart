// ignore_for_file: camel_case_types, avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../speceficBooking.dart';



class bookingCard extends StatelessWidget {
  const bookingCard({
    Key? key,
    required this.userEmail,
    required this.time,
    required this.date,
    required this.id,
    required this.status,
    required this.press,
  }) : super(key: key);
  final String userEmail, time, date;
  final String id, status;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
          child: SizedBox(
              width: size.width,
              height: 170 / 375 * size.width,
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
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "patient : $userEmail",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calendar_month),
                              const SizedBox(width: 6),
                              Text(date),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.access_time_outlined,
                              ),
                              const SizedBox(width: 6),
                              Text(time),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: size.width * 0.35,
                            height: 30,
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                status,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ]),
                  ),
                ]),
              )),
        ));
  }
}
