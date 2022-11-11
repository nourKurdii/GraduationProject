import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/profile/components/bottomNavBar.dart';
import 'package:flutter_application/Screens/reports/reportSection.dart';
import 'package:flutter_application/models/user.dart';
import '../profile/components/enums.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class reportsPage extends StatefulWidget {
  const reportsPage({super.key});

  @override
  _reportsPage createState() => _reportsPage();
}

Future<List> allOrders(userEmail) async {
  try {
    var res = await http.get(
      Uri.parse("http://10.0.2.2:3000/getReports/$userEmail"),
    );
    if (res.statusCode == 200) {
      //var obj = jsonDecode(res.body);
      var decodedJson = json.decode(res.body);
      //var jsonValue = json.decode(decodedJson['labInfo']);
      //var labInfo = obj['labInfo'];
      //print(jsonValue['name']);
      //print(labInfo);
      print(decodedJson);
      return jsonDecode(res.body);
    } else
      return Future.error('error');
  } catch (error) {
    return Future.error(error);
  }
}

class _reportsPage extends State<reportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      ...List.generate(
                          (snapshot.data as dynamic).length,
                          (index) => reportSection(
                                name: snapshot.data[index]['testName'],
                                labName: "",
                                time: snapshot.data[index]['time'],
                                date: snapshot.data[index]['date'],
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
