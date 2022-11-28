import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/profile/components/bottomNavBar.dart';
import 'package:flutter_application/Screens/reports/reportSection.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/models/orders.dart';
import 'package:flutter_application/models/user.dart';
import '../profile/components/enums.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'TestReport.dart';

class reportsPage extends StatefulWidget {
  const reportsPage({super.key});

  @override
  _reportsPage createState() => _reportsPage();
}

class _reportsPage extends State<reportsPage> {
  var Labname;
  Future<List> allOrders(userEmail) async {
    try {
      var res = await http.get(
        Uri.parse("http://10.0.2.2:3000/getReports/$userEmail"),
      );
      if (res.statusCode == 200) {
        var obj = json.decode(res.body);
        //print(obj[0]);

        var order1 = order.fromJson(obj[0]);

        // print(labInfo.fromJson(order1.labinfo![0]).email);
        return json.decode(res.body);
      } else
        print(Future.error);
      return Future.error('error');
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Tests Reports",
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          FutureBuilder<List>(
            future: allOrders(User.email),
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                //print("no Data");
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                //print(snapshot.data);
                var length = (snapshot.data as dynamic).length;
                //var labInfoList = snapshot.data[index]['labInfo'];

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ...List.generate(
                          length,
                          (index) => reportSection(
                                labinfo: [],
                                name: order
                                    .fromJson(snapshot.data[index])
                                    .testName,
                                //snapshot.data[index]['testName'],
                                labName: labInfo
                                    .fromJson(order
                                        .fromJson(snapshot.data[index])
                                        .labinfo![0])
                                    .name,
                                time: snapshot.data[index]['time'],
                                date: snapshot.data[index]['date'],
                                press: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => TespReport(
                                              snapshot.data[index]['_id'])));
                                },
                              )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavBar(selectedMeu: MenuState.report),
    );
  }
}
