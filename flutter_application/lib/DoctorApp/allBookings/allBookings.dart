// ignore_for_file: camel_case_types, avoid_print, unnecessary_new, must_be_immutable, no_logic_in_create_state

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/DoctorApp/allBookings/speceficBooking.dart';
import 'package:flutter_application/DoctorApp/homescreen.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'components/bookingSection.dart';

class doctorBookings extends StatefulWidget {
  String docEmail;
  String name;
  doctorBookings(this.docEmail, this.name, {super.key});

  @override
  State<doctorBookings> createState() => _doctorBookings(docEmail, name);
}

class _doctorBookings extends State<doctorBookings> {
  String docEmail;
  String name;
  _doctorBookings(this.docEmail, this.name);
  @override
  void initState() {
    super.initState();
  }

  Future<List> getDoctorBookings(docEmail) async {
    try {
      var res = await http
          .get(Uri.parse("http://10.0.2.2:3000/getDoctorOrders/$docEmail"));

      print(docEmail);
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
          style: TextStyle(color: Colors.white),
        ),
        elevation: 1.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(docEmail, name)));
          },
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(alignment: Alignment.center, children: [
            FutureBuilder<List>(
              future: getDoctorBookings(docEmail),
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
                                  color: kPrimaryLightColor,
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
                            userEmail: snapshot.data[index]['patientEmail'],
                            time: snapshot.data[index]['time'],
                            date: snapshot.data[index]['date'],
                            id: snapshot.data[index]['_id'],
                            status: snapshot.data[index]['status'],
                            press: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => speceficBooking(
                                        docEmail,
                                            snapshot.data[index]
                                                ['patientEmail'],
                                            snapshot.data[index]['time'],
                                            snapshot.data[index]['date'],
                                            snapshot.data[index]['_id'],
                                          )));
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
