import 'package:flutter/material.dart';
import '../../profile/components/bottomNavBar.dart';
import '../../profile/components/enums.dart';
import 'labPage.dart';

class mainLab extends StatefulWidget {
  @override
  mainLabState createState() => mainLabState();
}

class mainLabState extends State<mainLab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 239, 245),
      bottomNavigationBar: BottomNavBar(selectedMeu: MenuState.home),
      appBar: AppBar(
        title: Text(
          'Nearby Laboratories',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Raleway'),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => labpage()));
              },
              child: Container(
                  constraints: BoxConstraints(minHeight: 122, maxHeight: 150),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 233, 240),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 239, 236, 244).withOpacity(0.1),
                        blurRadius: 10.0,
                        offset: Offset(0, 3),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Card(
                    color: Color.fromARGB(255, 236, 233, 240),
                    child: Container(
                      height: 110,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                Container(
                                  width: 110.0,
                                  height: 90.0,
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 5, left: 10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 232, 232, 232),
                                    borderRadius: BorderRadius.circular(20),
                                    //padding: EdgeInsets.only(top: 10),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/labm.jpg"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 17)),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    InkWell(
                                      child: Text('Julianne Laboratory',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: 'Raleway')),
                                      onTap: () {},
                                    ),
                                    SizedBox(height: 10),
                                    Wrap(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Color.fromARGB(
                                              255, 218, 199, 222),
                                          size: 17,
                                        ),
                                        Text('Nature Park,Silvana',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                fontFamily: 'Raleway',
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ),
                  )),
            );
          }),
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(
      //       label: "", icon: Icon(Icons.arrow_back, color: Colors.grey)),
      //   BottomNavigationBarItem(label: "", icon: Icon(Icons.home_max)),
      //   BottomNavigationBarItem(
      //       label: "",
      //       icon: Icon(
      //         Icons.arrow_forward,
      //         color: Colors.grey,
      //       ))
      // ]),
    );
  }
}

class AppColors {
  static final Color mainColor = Color(0XFF6F36A5);
}
