// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state, library_private_types_in_public_api, camel_case_types, must_be_immutable, avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class speceficBooking extends StatefulWidget {
  String docEmail;
  String userEmail;
  String time;
  String date;
  String id;
  speceficBooking(this.docEmail, this.userEmail, this.date, this.time, this.id,
      {super.key});

  @override
  _speceficBookingState createState() =>
      _speceficBookingState(docEmail, userEmail, time, date, id);
}

bool done = false;

class _speceficBookingState extends State<speceficBooking> {
  String docEmail;
  String userEmail;
  String time;
  String date;
  String id;
  Dio dio = Dio();

  rejectOrder(id) async {
    print(id);
    try {
      return await dio.put(
        'http://10.0.2.2:3000/rejectDoctorOrder/$id',
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

  acceptOrder(id) async {
    print(id);
    try {
      return await dio.put(
        'http://10.0.2.2:3000/acceptrequest/$id',
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

  addTime(Doctorid, Time) async {
    try {
      return await dio.put(
        'http://10.0.2.2:3000/addTimeForDoctor/$Doctorid',
        data: {
          "time": Time,
        },
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

  _speceficBookingState(
      this.docEmail, this.userEmail, this.date, this.time, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Appointement Details",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 1.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: kSecondColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: _mountainDellPage());
  }

  _mountainDellPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        const SizedBox(
          height: 20.0,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.fact_check_outlined,
                    color: kSecondColor,
                    size: 24.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text("Patient: $userEmail",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.schedule,
                color: kSecondColor,
                size: 24.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(time,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_pin,
                color: kSecondColor,
                size: 24.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                date,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            // width: size.width * 0.35,
            height: 43,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(
                          color: kPrimaryColor,
                          width: 2,
                        ))),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      //title: Text("AlertDialog"),
                      backgroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      content:
                          const Text("Do you wanna accept this appointment ?"),
                      actions: [
                        TextButton(
                          child: const Text(
                            "No",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          onPressed: () {
                            acceptOrder(id);
                            addTime(docEmail, time);
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: const Text(
                "Accept",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            // width: size.width * 0.35,
            height: 43,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(
                          color: kPrimaryColor,
                          width: 2,
                        ))),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      //title: Text("AlertDialog"),
                      backgroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      content:
                          const Text("Do you wanna reject this appointment ?"),
                      actions: [
                        TextButton(
                          child: const Text(
                            "No",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          onPressed: () {
                            rejectOrder(id);
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: const Text(
                "Reject",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ])
      ]),
    );
  }
}
