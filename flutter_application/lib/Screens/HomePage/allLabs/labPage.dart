import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../profile/components/bottomNavBar.dart';
import '../../profile/components/enums.dart';
import 'DoctorProfile.dart';
import 'aboutLab.dart';
import 'labTests.dart';
import 'location.dart';
import 'package:http/http.dart' as http;
import '../../../models/lab.dart';

class labpage extends StatefulWidget {
  var labId;
  labpage(this.labId);
  @override
  labpageState createState() => labpageState(labId);
}

class labpageState extends State<labpage> {
  var labId;
  labpageState(this.labId);

  Future<Object> getSpeceficLab() async {
    try {
      var res = await http.get(
        Uri.parse("http://10.0.2.2:3000/getSpeceficLab/$labId"),
      );
      if (res.statusCode == 200) {
        var obj = jsonDecode(res.body);
        print("on future");
        print(obj);
        print(lab.fromJson(obj));
        print(lab.fromJson(obj).name);
        return jsonDecode(res.body);
      } else
        return Future.error('error');
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  initState() {
    setState(() {
      //print(labId);
      getSpeceficLab();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      bottomNavigationBar: const BottomNavBar(selectedMeu: MenuState.home),
      body: FutureBuilder<Object>(
          future: getSpeceficLab(),
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              print("no Data");
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/f.jpg"),
                            fit: BoxFit.cover)),
                    padding: const EdgeInsets.only(top: 25),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          top: 120.0, right: 20.0, left: 20.0),
                      width: double.infinity,
                      height: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: AppColors.backgroundColor),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 100.0,
                            offset: Offset(2, 2),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                lab.fromJson(snapshot.data).name,
                                //lab.fromJson(snapshot.data[0]).name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Raleway'),
                                textAlign: TextAlign.left,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 13.0,
                                      right: 10.0,
                                      left: 10.0,
                                      bottom: 2.0),
                                  height: 195,
                                  width: 290,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 253, 249, 255),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23, vertical: 26),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.phone,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
                                          ],
                                        ),
                                        Text(
                                          lab.fromJson(snapshot.data).phone,
                                          //lab.fromJson(snapshot.data[0]).phone,
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ]),
                                      Container(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(children: [
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 6)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.mail,
                                                color: Color.fromARGB(
                                                    255, 233, 30, 176),
                                                size: 20,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                            ],
                                          ),
                                          Text(
                                            lab.fromJson(snapshot.data).email,
                                            //lab.fromJson(snapshot.data[0]).email,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Raleway'),
                                          )
                                        ]),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(children: [
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.timer,
                                                color: Color.fromARGB(
                                                    255, 237, 230, 23),
                                                size: 20,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                            ],
                                          ),
                                          Text(
                                              "${lab.fromJson(snapshot.data).openTime} am",
                                              // lab
                                              //         .fromJson(
                                              //             snapshot.data[0])
                                              //         .openTime +
                                              //     " am",
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const Text(' to ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Raleway')),
                                          Text(
                                            "${lab.fromJson(snapshot.data).closeTime} pm",
                                            // lab
                                            //         .fromJson(snapshot.data[0])
                                            //         .closeTime +
                                            //     " pm",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ]),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(
                                              top: 14, left: 38),
                                          child: Row(children: [
                                            RatingBar.builder(
                                              initialRating: 0,
                                              minRating: 1,
                                              itemSize: 25,
                                              // allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ])),
                                      Container(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 75),
                                          child: Row(children: [
                                            const Text("Rating us!",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Raleway'))
                                          ])),
                                    ],
                                  ))
                            ],
                          )
                        ],
                      )),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DoctorProfile()));
                        },
                        child: Container(
                            // padding: const EdgeInsets.only(top: 500),
                            margin: const EdgeInsets.only(
                                top: 407, left: 12, right: 12),
                            width: 450,
                            height: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 84, 35, 158)
                                            .withOpacity(0.1),
                                    blurRadius: 15.0,
                                    offset: const Offset(3, 3),
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            width: 58,
                                            height: 58,
                                            margin: const EdgeInsets.only(
                                                left: 23, top: 15),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 232, 232, 232),
                                              borderRadius:
                                                  BorderRadius.circular(360),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/doctor.png"),
                                                  fit: BoxFit.fill),
                                            )),
                                        const SizedBox(width: 25),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const SizedBox(height: 25),
                                            InkWell(
                                              child: const Text(
                                                  'Dr.' + 'Vina Belgium',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      fontFamily: 'Raleway')),
                                              onTap: () {},
                                            ),
                                            const SizedBox(height: 5),
                                            const Text('Owner',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    fontFamily: 'Raleway',
                                                    color: Colors.grey)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: 30, top: 5),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.message,
                                        color:
                                            Color.fromARGB(255, 202, 178, 207),
                                      ),
                                    ),
                                  ]),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => About()));
                        },
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 9, right: 9, top: 10),
                            width: 400,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 196, 162, 255)
                                          .withOpacity(0.1),
                                  blurRadius: 5.0,
                                  offset: const Offset(3, 3),
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  child: const Text("About",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          fontFamily: 'Raleway')),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => About()));
                                    print('about');
                                  },
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 140)),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromARGB(255, 62, 60, 60),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => location()));
                        },
                        child: Container(
                            margin: const EdgeInsets.only(left: 9, right: 9),
                            width: 400,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 196, 162, 255)
                                          .withOpacity(0.1),
                                  blurRadius: 5.0,
                                  offset: const Offset(3, 3),
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  child: const Text("Location",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          fontFamily: 'Raleway')),
                                  onTap: () {
                                    print('location');
                                  },
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 140)),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromARGB(255, 62, 60, 60),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Container(
                      margin:
                          const EdgeInsets.only(left: 40, right: 30, top: 650),
                      //padding:EdgeInsets.only(top:8) ,
                      width: 310,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(24),
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
                          'Tests',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              fontFamily: 'Raleway',
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Tests()));
                          // print('ffff');
                        },
                      )),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          })),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //         label: "",
      //         icon: Icon(
      //           Icons.arrow_back,
      //           color: Colors.grey,
      //         )),
      //     BottomNavigationBarItem(label: "", icon: Icon(Icons.home_max)),

      //     //BottomNavigationBarItem(label: "",icon: Icon(Icons.arrow_forward,color: Colors.grey,))
      //   ],
      // ),
    );
  }
}

class AppColors {
  static const Color mainColor = Color.fromARGB(255, 133, 73, 188);
  static const Color backgroundColor = Color.fromARGB(255, 255, 255, 255);
}
