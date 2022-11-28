import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_application/constants.dart';

import 'allBookings.dart';

class speceficBooking extends StatefulWidget {
  var testId;

  speceficBooking(this.testId);

  @override
  _speceficBookingState createState() => _speceficBookingState(testId);
}

class _speceficBookingState extends State<speceficBooking> {

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
      } else
        return Future.error('error');
    } catch (error) {
      return Future.error(error);
    }
  }

  var testId;
  _speceficBookingState(this.testId);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home Visit Details",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1.5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: kPrimaryColor,
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => allBookings()));
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Text(testId),
        ));
  }
}

