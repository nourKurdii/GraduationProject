import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/HomePage/allLabs/testReview.dart';

import '../../profile/components/bottomNavBar.dart';
import '../../profile/components/enums.dart';

class Tests extends StatefulWidget {
  @override
  TestsState createState() => TestsState();
}

class TestsState extends State<Tests> {
  var colors = [
    Color.fromARGB(255, 248, 245, 255),
    Color.fromARGB(255, 248, 245, 255),
    Color.fromARGB(255, 248, 245, 255),
    //Color.fromARGB(255, 255, 228, 255),
    //Color.fromARGB(255, 237, 229, 255),
    //Color.fromARGB(255, 237, 229, 255),

    ///Color.fromARGB(255, 251, 254, 164),
  ];
  List items = [
    {"list": "diabeties", Image: 'assets/images/diabeties.png'},
    {"list": "Vitamin", Image: 'assets/images/vitamin.png'},
    {"list": "hormonal", Image: 'assets/images/hormonal.png'}
  ];

  //Integer ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedMeu: MenuState.home,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tests',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Raleway')),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => testReport()));
              },
              child: Card(
                  color: Colors.white,
                  child: Container(
                    height: 80,
                    width: 200,
                    decoration: BoxDecoration(
                      color: colors[index],
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
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  //padding: EdgeInsets.only(top: 10),
                                  image: DecorationImage(
                                      image:
                                          AssetImage("${items[index][Image]}"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 17)),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 27,
                                  ),
                                  InkWell(
                                    child: Text("${items[index]['list']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'Raleway',
                                            color: Color.fromARGB(
                                                255, 33, 32, 32))),
                                    onTap: () {
                                      print('location');
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ]),
                  )),
            );
          }),
    );
  }
}

class AppColors {
  static final Color mainColor = Color(0XFF6F36A5);
}
