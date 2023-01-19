// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state, library_private_types_in_public_api, camel_case_types, must_be_immutable, avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/profile/homeVisits/homeVisits.dart';
import 'dart:convert';
import 'package:flutter_application/constants.dart';

class speceficHomevisit extends StatefulWidget {
  String testId;
  String labName;
  String labEmail;
  String testName;
  String time;
  String date;
  String location;
  speceficHomevisit(this.testId, this.labEmail, this.labName, this.testName,
      this.date, this.time, this.location,
      {super.key});

  @override
  _speceficHomevisit createState() => _speceficHomevisit(
      testId, labName, labEmail, testName, time, date, location);
}

class _speceficHomevisit extends State<speceficHomevisit> {
  String testId;
  String labName;
  String labEmail;
  String testName;
  String time;
  String date;
  String location;
  var dio = Dio();

  Future<List> getSpeceficReport() async {
    try {
      var res = await dio.get(
        "http://10.0.2.2:3000/getSpeceficReport/$testId",
      );
      if (res.statusCode == 200) {
        var obj = jsonDecode(res.data);
        print(obj);
        return jsonDecode(res.data);
      } else {
        return Future.error('error');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  _speceficHomevisit(this.testId, this.labEmail, this.labName, this.testName,
      this.date, this.time, this.location);

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
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const homeVisits()));
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: 20.0,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.fact_check_outlined,
                    color: kPrimaryColor,
                    size: 24.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text("Test Name: $testName",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                color: kPrimaryColor,
                size: 28.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                labEmail,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.schedule,
                color: kPrimaryColor,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_month,
                color: kPrimaryColor,
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
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: kPrimaryColor,
                size: 24.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                location,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
