// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state, must_be_immutable, camel_case_types, library_private_types_in_public_api, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_application/constants.dart';

import 'homeVisits.dart';

class speceficHomeVisit extends StatefulWidget {
  var testId;

  speceficHomeVisit(this.testId, {super.key});

  @override
  _speceficHomeVisit createState() => _speceficHomeVisit(testId);
}

class _speceficHomeVisit extends State<speceficHomeVisit> {
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

  var testId;
  _speceficHomeVisit(this.testId);
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home Visit Details",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: kPrimaryColor,
            onPressed: () {
              Navigator.push(context,
                   MaterialPageRoute(builder: (context) => const homeVisits()));
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
