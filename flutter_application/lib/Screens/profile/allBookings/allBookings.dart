// ignore_for_file: camel_case_types, avoid_print, unnecessary_new

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/profile/allBookings/speceficBooking.dart';
import 'package:flutter_application/Screens/profile/profileScreen.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import '../../../models/user.dart';
import 'components/bookingSection.dart';
import 'package:flutter_application/models/orders.dart';

class allBookings extends StatefulWidget {
  const allBookings({super.key});

  @override
  State<allBookings> createState() => _allBookings();
}

class _allBookings extends State<allBookings> {
  @override
  void initState() {
    super.initState();
  }

  Future<List> getBookings(userEmail) async {
    try {
      var res = await http
          .get(Uri.parse("http://10.0.2.2:3000/getBookings/$userEmail"));

      print(userEmail);
      if (res.statusCode == 200) {
        setState(() {
          res;
        });
        //var obj = json.decode(res.body);
        //print(obj);

        /*for (var i = 0; i < obj.length; i++) {
          labInfo = obj[i]['labInfo'];
          print(labInfo[i]['name']);
        }*/

        return json.decode(res.body);
      } else {
        return Future.error('error');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Bookings",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: kPrimaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const profileScreen()));
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(alignment: Alignment.center, children: [
            FutureBuilder<List>(
              future: getBookings(User.email),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  //print("no Data");
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  //print(snapshot.data);
                  var length = (snapshot.data as dynamic).length;
                  if (length == 0) {
                    return SingleChildScrollView(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            child: Container(
                              height: size.height * 0.18,
                              width: size.width,
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  color:
                                      kPrimaryLightColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.asset(
                                "assets/images/homeLocation.png",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "No Test Bookings Yet",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                            width: size.width * 0.35,
                            height: 43,
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ))),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Go to Book Test",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        ...List.generate(
                          length,
                          (index) => bookingSection(
                            name: snapshot.data[index]['testName'],
                            labinfo: const [],
                            time: snapshot.data[index]['time'],
                            date: snapshot.data[index]['date'],
                            labName: labInfo
                                .fromJson(order
                                    .fromJson(snapshot.data[index])
                                    .labinfo![0])
                                .name,
                            id: snapshot.data[index]['_id'],
                            status: snapshot.data[index]['status'],
                            press: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => speceficBooking(
                                          snapshot.data[index]['_id'],
                                          labInfo
                                              .fromJson(order
                                                  .fromJson(
                                                      snapshot.data[index])
                                                  .labinfo![0])
                                              .name,
                                          labInfo
                                              .fromJson(order
                                                  .fromJson(
                                                      snapshot.data[index])
                                                  .labinfo![0])
                                              .email,
                                          snapshot.data[index]['testName'],
                                          snapshot.data[index]['time'],
                                          snapshot.data[index]['date'])));
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
