// ignore_for_file: camel_case_types, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import '../../profile/components/bottomNavBar.dart';
import '../../profile/components/enums.dart';
import 'labPage/labPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class mainLab extends StatefulWidget {
  const mainLab({super.key});

  @override
  mainLabState createState() => mainLabState();
}

class mainLabState extends State<mainLab> {
  Future<List> fetchLab() async {
    try {
      var res = await http.get(
        Uri.parse("http://10.0.2.2:3000/getLabInfo"),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 239, 245),
      bottomNavigationBar: const BottomNavBar(selectedMeu: MenuState.home),
      appBar: AppBar(
        title: const Text(
          'Nearby Laboratories',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Raleway'),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
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
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(children: [
                      ...List.generate(
                          (snapshot.data as dynamic).length,
                          (index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => labpage(
                                              snapshot.data[index]['_id'])));
                                },
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Container(
                                    height: 110,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Wrap(
                                            children: <Widget>[
                                              Container(
                                                width: 110.0,
                                                height: 90.0,
                                                margin: const EdgeInsets.only(
                                                    top: 10, bottom: 5, left: 10),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 232, 232, 232),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  //padding: EdgeInsets.only(top: 10),

                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/imageee.png"),
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 17)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  InkWell(
                                                    child: Text(
                                                        snapshot.data[index]
                                                            ['name'],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            fontFamily:
                                                                'Raleway')),
                                                    onTap: () {},
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Wrap(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: kPrimaryColor,
                                                        size: 17,
                                                      ),
                                                      Text(
                                                          snapshot
                                                                  .data[index]
                                                              ['location'],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Raleway',
                                                              color:
                                                                  Colors.grey)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                ),
                              ))
                    ]),
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

class AppColors {
  static Color mainColor = const Color(0xff425c5a);
  //const Color(0XFF6F36A5);
}
