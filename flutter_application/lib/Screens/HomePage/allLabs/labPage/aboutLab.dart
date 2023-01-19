import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Lab',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Raleway')),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: Stack(children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          height: 700,
          width: 360,
          //color: Color.fromARGB(255, 212, 42, 42),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 241, 246),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 186, 179, 198).withOpacity(0.1),
                blurRadius: 10.0,
                offset: const Offset(0, 3),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 13),
                  height: 170,
                  width: 310,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      image: DecorationImage(
                          image: AssetImage("assets/images/about.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: const Text(
                    'Labor is the amount of physical, mental, and social effort used to produce goods and services in an economy. It supplies the expertise, manpower, and service needed to turn raw materials into finished products and services. In return for their labor, workers receive a wage to buy the goods and services they dont produce themselves.',
                    maxLines: 20,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Raleway'),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class AppColors {
  static final Color mainColor = Color(0xff425c5a);
}
