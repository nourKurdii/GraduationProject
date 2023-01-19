// ignore_for_file: file_names, avoid_print, must_be_immutable, no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:http/http.dart' as http;
import '../../../../models/doctor.dart';
import '../../doctors/doctorBooking.dart';

class DoctorProfile extends StatefulWidget {
  var docId;
  DoctorProfile(this.docId, {super.key});

  @override
  DoctorProfileState createState() => DoctorProfileState(docId);
}

class DoctorProfileState extends State<DoctorProfile> {
  Future<Object> getSpeceficDoc() async {
    try {
      var res = await http.get(
        Uri.parse("http://10.0.2.2:3000/getSpeceficDoc/$docId"),
      );
      if (res.statusCode == 200) {
        setState(() {
          res;
        });
        //var obj = jsonDecode(res.body);
        // print("on future");
        //print(obj);
        //print(lab.fromJson(obj));
        //print(lab.fromJson(obj).name);
        return jsonDecode(res.body);
      } else {
        return Future.error('error');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  var docId;
  DoctorProfileState(this.docId);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Doctor profile",
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: FutureBuilder<Object>(
          future: getSpeceficDoc(),
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              print("no Data");
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Column(children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 120, right: 80),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: kPrimaryLightColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.1),
                              offset: const Offset(4, 10))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/doctor.png")),
                      ),

                      //Padding(padding: EdgeInsets.only(top: )),
                      //   Row(
                      // children :[
                      child: Container(
                          padding: const EdgeInsets.only(left: 110, top: 110),
                          child: Icon(
                            Icons.chat,
                            color: AppColors.mainColor,
                            size: 38,
                          ))
                      //]
                      //   )
                      ),
                ]),
                const Padding(padding: EdgeInsets.only(top: 40)),
                Container(
                    height: 57,
                    width: size.width * 0.95,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 137, 123, 163)
                              .withOpacity(0.1),
                          blurRadius: 5.0,
                          offset: const Offset(3, 3),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 20,
                            ),
                            Text('Dr Name :',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    //fontFamily: 'Raleway',
                                    color: Colors.grey.shade800)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 20,
                            ),
                            Text(doctor.fromJson(snapshot.data).name,
                                style: TextStyle(
                                    fontSize: 18,
                                    //fontFamily: 'Raleway',
                                    color: Colors.grey.shade800)),
                          ],
                        )
                      ],
                    )),
                const SizedBox(height: 7),
                Container(
                    height: 57,
                    width: size.width * 0.95,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 137, 123, 163)
                              .withOpacity(0.1),
                          blurRadius: 5.0,
                          offset: const Offset(3, 3),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        Text('Title :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                //fontFamily: 'Raleway',
                                color: Colors.grey.shade800)),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(doctor.fromJson(snapshot.data).title,
                              style: TextStyle(
                                  fontSize: 18,
                                  // fontFamily: 'Raleway',
                                  color: Colors.grey.shade800)),
                        )
                      ],
                    )),
                const SizedBox(height: 7),
                Container(
                    height: 57,
                    width: size.width * 0.95,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 137, 123, 163)
                              .withOpacity(0.1),
                          blurRadius: 5.0,
                          offset: const Offset(3, 3),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        Text('E-Mail :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                // fontFamily: 'Raleway',
                                color: Colors.grey.shade800)),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(doctor.fromJson(snapshot.data).email,
                              style: TextStyle(
                                  fontSize: 18,
//fontFamily: 'Raleway',
                                  color: Colors.grey.shade800)),
                        )
                      ],
                    )),
                const SizedBox(height: 7),
                Container(
                    height: 57,
                    width: size.width * 0.95,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 137, 123, 163)
                              .withOpacity(0.1),
                          blurRadius: 5.0,
                          offset: const Offset(3, 3),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        Text('Phone Number :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                //fontFamily: 'Raleway',
                                color: Colors.grey.shade800)),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(doctor.fromJson(snapshot.data).phone,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade800)),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40, right: 30),
                      //padding:EdgeInsets.only(top:8),
                      width: size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 196, 162, 255)
                                .withOpacity(0.1),
                            blurRadius: 5.0,
                            offset: const Offset(3, 3),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(14),
                      alignment: Alignment.center,
                      child: InkWell(
                        child: const Text(
                          'Book Consultation',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              //  fontFamily: 'Raleway',
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorBookingScreen(
                                      doctor.fromJson(snapshot.data).email,
                                      doctor.fromJson(snapshot.data).unavailable
                                          as dynamic)));
                          // print('ffff');
                        },
                      ),
                    )
                  ],
                ),
              ]);
            } else {
              return const CircularProgressIndicator();
            }
          })),
    );
  }
}

class AppColors {
  static Color mainColor = const Color(0xff425c5a);
}
