// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, camel_case_types, no_logic_in_create_state, library_private_types_in_public_api, avoid_print, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/doctor.dart';
import '../Dashboard.dart';
import '../profile/components/bottomNavBar.dart';
import '../profile/components/enums.dart';
import 'allLabs/viewAll.dart';
import 'components/LabsSection.dart';
import 'components/SectionTitle.dart';
import 'components/appBar.dart';
import 'components/card.dart';
import 'components/doctorCard.dart';
import 'components/listView.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class homePage extends StatefulWidget {
  var name;

  homePage(this.name, {super.key});

  @override
  _homeState createState() => _homeState(name);
}

Future<List> fetchLab() async {
  try {
    var res = await http.get(
      Uri.parse("http://10.0.2.2:3000/topThreeLabs"),
    );
    if (res.statusCode == 200) {
      //var obj = jsonDecode(res.body);
      //print(obj);
      return jsonDecode(res.body);
    } else {
      return Future.error('error');
    }
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> fetchDoctor() async {
  try {
    var res = await http.get(
      Uri.parse("http://10.0.2.2:3000/getDoctorInfo"),
    );
    if (res.statusCode == 200) {
      // var obj = jsonDecode(res.body);
      //print(obj);
      return jsonDecode(res.body);
    } else {
      return Future.error('error');
    }
  } catch (error) {
    return Future.error(error);
  }
}

class _homeState extends State<homePage> {
  var dio = Dio();
  var name;
  _homeState(this.name);
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedMeu: MenuState.home),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 45,
            ),
            //app bar
            //print(snapshot.data);

            appBar(
              icon: Icons.person,
              name: name,
            ),

            //Card
            const card(),
            const SizedBox(
              height: 15,
            ),

            //search
            // searchBar(),
            const SizedBox(
              height: 15,
            ),

            //horizontal listview tests categories
            const listView(),
            const SizedBox(
              height: 15,
            ),

            //labs list
            SectionTitle(
              title: "Top Three Labs",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const mainLab()));
              },
            ),
            FutureBuilder<List>(
              future: fetchLab(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  print("no Data");
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  //print(snapshot.data);

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                            (snapshot.data as dynamic).length,
                            (index) => LabsSection(
                                  name: snapshot.data[index]['name'],
                                  Image: "assets/images/lab1.jpg",
                                  Location: snapshot.data[index]['rating'].toString(),
                                )),
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

            const SizedBox(
              height: 15,
            ),

            //doctors list
            SectionTitle(
              title: "Doctors",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Dashboard()));
              },
            ),
            const SizedBox(
              height: 10,
            ),

            FutureBuilder<List>(
              future: fetchLab(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  print("no Data");
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  //print(snapshot.data);

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(demoDoctor.length,
                            (index) => doctorCard(d: demoDoctor[index])),
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

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
