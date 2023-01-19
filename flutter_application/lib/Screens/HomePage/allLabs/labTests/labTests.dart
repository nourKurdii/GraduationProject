import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import '../../../profile/components/bottomNavBar.dart';
import '../../../profile/components/enums.dart';
import 'labTestsAccordingToCat.dart';
import 'package:dio/dio.dart';
import '../labTests/labTestsArray.dart';

// ignore: must_be_immutable
class Tests extends StatefulWidget {
  List<String> labTests;
  String labEmail;
  List<String> unavailable;

  Tests(this.labTests, this.labEmail, this.unavailable, {super.key});

  @override
  // ignore: no_logic_in_create_state
  TestsState createState() => TestsState(labTests, labEmail, this.unavailable);
}

class TestsState extends State<Tests> {
  List<String> labTests;
  String labEmail;
  List<String> unavailable;

  var colors = [
    const Color.fromARGB(255, 248, 245, 255),
    const Color.fromARGB(255, 248, 245, 255),
    const Color.fromARGB(255, 248, 245, 255),
  ];
  List items = [
    {"list": "Diabetes", Image: 'assets/images/diabeties.png'},
    {"list": "Vitamin", Image: 'assets/images/vitamin.png'},
    {"list": "Hormonal", Image: 'assets/images/hormonal.png'},
    {
      "list": "Thyroid",
      Image:
          'assets/images/tiny-endocrinologists-doctors-diagnose-treat-human-thyroid-gland-thyroid-examination-with-magnifying-glass-hypothyroidism-hyperthyroidism-concept-health-medical-treatment_458444-985.jpg'
    },
  ];

  TestsState(this.labTests, this.labEmail, this.unavailable);
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
      } else
        return Future.error("error");
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print(labEmail);
    print(unavailable);
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
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 18),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => labTestAccordingToCat(
                          diabetes, labEmail, unavailable)));
                },
                child: Card(
                    elevation: 0,
                    //color: Colors.white,
                    child: Container(
                      height: 80,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
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
                                      onTap: () {
                                        print('location');
                                      },
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
                      builder: (context) => labTestAccordingToCat(
                          vitamins, labEmail, unavailable)));
                },
                child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                      height: 80,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
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
                                      onTap: () {
                                        print('location');
                                      },
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
                      builder: (context) => labTestAccordingToCat(
                          hormon, labEmail, unavailable)));
                },
                child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Container(
                      height: 80,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
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
                                      onTap: () {
                                        print('location');
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    )),
              )
            ]),
          ),
        )

        //}
        //),
        );
  }
}

class AppColors {
  static const Color mainColor = Color(0XFF6F36A5);
}
