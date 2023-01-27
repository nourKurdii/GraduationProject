// ignore_for_file: avoid_print, unrelated_type_equality_checks, prefer_typing_uninitialized_variables, no_logic_in_create_state, must_be_immutable, file_names

import 'package:flutter/material.dart';
import '../../../profile/components/bottomNavBar.dart';
import '../../../profile/components/enums.dart';
import 'HomeTestsAccordingToCat.dart';
import 'package:dio/dio.dart';
import '../labTests/labTestsArray.dart';

class HomeTests extends StatefulWidget {
  List<String> labTests;
  String labEmail;
  List<String> unavailable;
  HomeTests(this.labTests, this.labEmail, this.unavailable, {super.key});

  @override
  HomeTestsState createState() =>
      HomeTestsState(labTests, labEmail, unavailable);
}

class HomeTestsState extends State<HomeTests> {
  List<String> labTests;
  String labEmail;
  List<String> unavailable;

  var colors = [
    const Color.fromARGB(255, 248, 245, 255),
    const Color.fromARGB(255, 248, 245, 255),
    const Color.fromARGB(255, 248, 245, 255),
    const Color.fromARGB(255, 248, 245, 255),
  ];
  List items = [
    {"list": "Diabetes", Image: 'assets/images/diabeties.png'},
    {"list": "Vitamin", Image: 'assets/images/vitamin.png'},
    {"list": "Hormonal", Image: 'assets/images/hormonal.png'},
    {"list": "Thyroid", Image: 'assets/images/diabeties.png'},
  ];

  HomeTestsState(this.labTests, this.labEmail, this.unavailable);
  List<String> diabetes = [];
  List<String> vitamins = [];
  List<String> hormon = [];
  var testName;
  Dio dio = Dio();

  getTestCat(testName) async {
    try {
      var res = await dio.get(("http://10.0.2.2:3000/getTestCat/$testName"));
      if (res.statusCode == 200) {
        return res.data;
      } else {
        return Future.error("error");
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  void initState() {
    super.initState();

    if (labTests != 0) {
      print(labTests);

      for (int i = 0; i < labTests.length; i++) {
        getTestCat(labTests[i]).then((value) {
          // print("value " + value);
          if (value == 'vitamin') {
            if (!vitamins.toString().contains(labTests[i])) {
              vitamins.add(labTests[i]);
            }
          } else if (value == 'diabetes') {
            if (!diabetes.toString().contains(labTests[i])) {
              diabetes.add(labTests[i]);
            }
          } else if (value == 'hormon') {
            if (!hormon.toString().contains(labTests[i])) {
              hormon.add(labTests[i]);
            }
          }
        });
      }
    }
    // print("vitamins list:");
    // print(vitamins);
    // print("diabetes list:");
    // print(diabetes);
    print('blablahhfvh');
    labTestsArray.setArray(labTests);
    print(labTestsArray.getArray());
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        bottomNavigationBar: const BottomNavBar(
          selectedMeu: MenuState.home,
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Tests',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Raleway')),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 18),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeTestAccordingToCat(
                          diabetes, labEmail, unavailable)));
                },
                child: Card(
                    elevation: 0,
                    //color: Colors.white,
                    child: Container(
                      height: 80,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: const Color(0xffa2bfbd),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                Container(
                                  width: 110.0,
                                  height: 60.0,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 5, left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    //padding: EdgeInsets.only(top: 10),
                                    image: DecorationImage(
                                        image: AssetImage("${items[0][Image]}"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 17)),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 27,
                                    ),
                                    InkWell(
                                      child: Text("${items[0]['list']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: 'Raleway',
                                              color: Color.fromARGB(
                                                  255, 33, 32, 32))),
                                      onTap: () {},
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeTestAccordingToCat(
                          vitamins, labEmail, unavailable)));
                },
                child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                      height: 80,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: const Color(0xffa2bfbd),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                Container(
                                  width: 110.0,
                                  height: 60.0,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 5, left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    //padding: EdgeInsets.only(top: 10),
                                    image: DecorationImage(
                                        image: AssetImage("${items[1][Image]}"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 17)),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 27,
                                    ),
                                    InkWell(
                                      child: Text("${items[1]['list']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: 'Raleway',
                                              color: Color.fromARGB(
                                                  255, 33, 32, 32))),
                                      onTap: () {},
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeTestAccordingToCat(
                          hormon, labEmail, unavailable)));
                },
                child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                      height: 80,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Color(0xffa2bfbd),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                Container(
                                  width: 110.0,
                                  height: 60.0,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 5, left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    //padding: EdgeInsets.only(top: 10),
                                    image: DecorationImage(
                                        image: AssetImage("${items[2][Image]}"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 17)),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 27,
                                    ),
                                    InkWell(
                                      child: Text("${items[2]['list']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: 'Raleway',
                                              color: Color.fromARGB(
                                                  255, 33, 32, 32))),
                                      onTap: () {},
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    )),
              ),
              //   GestureDetector(
              //     onTap: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => HomeTestAccordingToCat(
              //               diabetes, labEmail, unavailable)));
              //     },
              //     child: Card(
              //         elevation: 0,
              //         //color: Colors.white,
              //         child: Container(
              //           height: 80,
              //           width: size.width * 0.9,
              //           decoration: BoxDecoration(
              //             color: const Color(0xffa2bfbd),
              //             borderRadius: BorderRadius.circular(25),
              //           ),
              //           child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: <Widget>[
              //                 Wrap(
              //                   children: <Widget>[
              //                     Container(
              //                       width: 110.0,
              //                       height: 60.0,
              //                       margin: const EdgeInsets.only(
              //                           top: 10, bottom: 5, left: 10),
              //                       decoration: BoxDecoration(
              //                         color: Colors.white,
              //                         borderRadius: BorderRadius.circular(20),
              //                         //padding: EdgeInsets.only(top: 10),
              //                         image: const DecorationImage(
              //                             image: AssetImage(
              //                                 'assets/images/thyroid.jpg'),
              //                             fit: BoxFit.cover),
              //                       ),
              //                     ),
              //                     const Padding(
              //                         padding: EdgeInsets.only(left: 17)),
              //                     Column(
              //                       children: [
              //                         const SizedBox(
              //                           height: 27,
              //                         ),
              //                         InkWell(
              //                           child: const Text("Thyroid",
              //                               style: TextStyle(
              //                                   fontWeight: FontWeight.bold,
              //                                   fontSize: 18,
              //                                   fontFamily: 'Raleway',
              //                                   color: Color.fromARGB(
              //                                       255, 33, 32, 32))),
              //                           onTap: () {

              //                           },
              //                         ),
              //                         const SizedBox(height: 10),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ]),
              //         )),
              //   ),
            ]),
          ),
        )

        //}
        //),
        );
  }
}

class AppColors {
  static const Color mainColor = Color(0xff425c5a);
}
