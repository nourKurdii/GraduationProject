import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TespReport extends StatefulWidget {
  var testId;

  TespReport(this.testId);

  @override
  _TespReport createState() => _TespReport(testId);
}

var dio = Dio();

Future<List> getSpeceficReport(testId) async {
  try {
    var res = await dio.get(
      "http://10.0.2.2:3000/getSpeceficReport/$testId",
    );
    if (res.statusCode == 200) {
      var obj = jsonDecode(res.data);
      //print(obj);
      return jsonDecode(res.data);
    } else
      return Future.error('error');
  } catch (error) {
    return Future.error(error);
  }
}

class _TespReport extends State<TespReport> {
  var testName;
  _TespReport(this.testName);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
