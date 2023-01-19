// ignore_for_file: camel_case_types, avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../speceficBooking.dart';

Dio dio = Dio();

cancelOrder(id) async {
  print(id);
  try {
    return await dio.put(
      'http://10.0.2.2:3000/cancelOrder/$id',
    );
  } on DioError catch (e) {
    return Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kPrimaryLightColor,
        textColor: Colors.black);
  }
}

class bookingCard extends StatelessWidget {
  const bookingCard({
    Key? key,
    required this.name,
    required this.labName,
    required this.time,
    required this.date,
    required this.id,
    required this.status,
    required this.press,
  }) : super(key: key);
  final String name, labName, time, date;
  final String id, status;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
              width: size.width,
              height: 150 / 375 * size.width,
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
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Test Name : $name",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        //title: Text("AlertDialog"),
                                        backgroundColor: Colors.white,

                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        content: const Text(
                                            "Do you wanna cancel your appointment ?"),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              "No",
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            ),
                                            onPressed: () {
                                              cancelOrder(id);
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.cancel_outlined),
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Lab Name : $labName",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: kPrimaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(date),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.access_time_outlined,
                                color: kPrimaryColor,
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

  Widget bottomsheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "Do you wanna cancel your appointment?",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.camera),
                  label: (const Text("No")),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                    onPressed: () {
                      cancelOrder(id);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Yes")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
