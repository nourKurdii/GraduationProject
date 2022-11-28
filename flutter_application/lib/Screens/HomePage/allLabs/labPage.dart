import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../profile/components/bottomNavBar.dart';
import '../../profile/components/enums.dart';
import 'DoctorProfile.dart';
import 'aboutLab.dart';
import 'labTests.dart';
import 'location.dart';

class labpage extends StatefulWidget {
  @override
  labpageState createState() => labpageState();
}

class labpageState extends State<labpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      bottomNavigationBar: BottomNavBar(selectedMeu: MenuState.home),
      body: Stack(
        children: <Widget>[
          Container(
            height: 280,
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                image: DecorationImage(
                    image: AssetImage("assets/images/f.jpg"),
                    fit: BoxFit.cover)),
            padding: EdgeInsets.only(top: 25),
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: AppColors.backgroundColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 100.0,
                    offset: Offset(2, 2),
                    spreadRadius: 1,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Julianne Laboratory',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'Raleway'),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: 13.0, right: 10.0, left: 10.0, bottom: 2.0),
                          height: 195,
                          width: 290,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 253, 249, 255),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 23, vertical: 26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                  ],
                                ),
                                Text(
                                  '+98 952888565',
                                  style: TextStyle(fontSize: 16),
                                )
                              ]),
                              Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Row(children: [
                                  Padding(padding: EdgeInsets.only(left: 6)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        color:
                                            Color.fromARGB(255, 233, 30, 176),
                                        size: 20,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                    ],
                                  ),
                                  Text(
                                    'laboratory@gmail.com',
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Raleway'),
                                  )
                                ]),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Row(children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color:
                                            Color.fromARGB(255, 237, 230, 23),
                                        size: 20,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                    ],
                                  ),
                                  Text('09:00 am',
                                      style: TextStyle(fontSize: 16)),
                                  Text(' to ',
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: 'Raleway')),
                                  Text(
                                    '10 :00 pm',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ]),
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 14, left: 38),
                                  child: Row(children: [
                                    RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      itemSize: 25,
                                      // allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ])),
                              Container(
                                  padding: EdgeInsets.only(top: 8, left: 75),
                                  child: Row(children: [
                                    Text("Rating us!",
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DoctorProfile()));
                },
                child: Container(
                    // padding: const EdgeInsets.only(top: 500),
                    margin: EdgeInsets.only(top: 407, left: 12, right: 12),
                    width: 450,
                    height: 90,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 84, 35, 158)
                                .withOpacity(0.1),
                            blurRadius: 15.0,
                            offset: Offset(3, 3),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    width: 58,
                                    height: 58,
                                    margin: EdgeInsets.only(left: 23, top: 15),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 232, 232, 232),
                                      borderRadius: BorderRadius.circular(360),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/doctor.png"),
                                          fit: BoxFit.fill),
                                    )),
                                SizedBox(width: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 25),
                                    InkWell(
                                      child: Text('Dr.' + 'Vina Belgium',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              fontFamily: 'Raleway')),
                                      onTap: () {},
                                    ),
                                    SizedBox(height: 5),
                                    Text('Owner',
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
                              margin: EdgeInsets.only(right: 30, top: 5),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.message,
                                color: Color.fromARGB(255, 202, 178, 207),
                              ),
                            ),
                          ]),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => About()));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 9, right: 9, top: 10),
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 196, 162, 255)
                              .withOpacity(0.1),
                          blurRadius: 5.0,
                          offset: Offset(3, 3),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Text("About",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'Raleway')),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => About()));
                            print('about');
                          },
                        ),
                        Padding(padding: EdgeInsets.only(left: 140)),
                        Icon(
                          Icons.arrow_forward,
                          color: Color.fromARGB(255, 62, 60, 60),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => location()));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 9, right: 9),
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 196, 162, 255)
                              .withOpacity(0.1),
                          blurRadius: 5.0,
                          offset: Offset(3, 3),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Text("Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'Raleway')),
                          onTap: () {
                            print('location');
                          },
                        ),
                        Padding(padding: EdgeInsets.only(left: 140)),
                        Icon(
                          Icons.arrow_forward,
                          color: Color.fromARGB(255, 62, 60, 60),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          
            Container(
                margin: EdgeInsets.only(left: 40, right: 30, top: 650),
                //padding:EdgeInsets.only(top:8) ,
                width: 310,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 196, 162, 255).withOpacity(0.1),
                      blurRadius: 5.0,
                      offset: Offset(3, 3),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(14),
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    'Tests',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'Raleway',
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Tests()));
                    // print('ffff');
                  },
                )),
          
        ],
      ),
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
  static final Color mainColor = Color.fromARGB(255, 133, 73, 188);
  static final Color backgroundColor = Color.fromARGB(255, 255, 255, 255);
}
