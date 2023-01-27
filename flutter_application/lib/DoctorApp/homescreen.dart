// ignore_for_file: no_logic_in_create_state, avoid_print, prefer_typing_uninitialized_variables, library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application/DoctorApp/profile.dart';
import 'package:flutter_application/DoctorApp/schedule/schedule.dart';
import 'package:flutter_application/constants.dart';

import '../chat/HomeScreen.dart';
import '../chat/methods.dart';
import 'allBookings/allBookings.dart';
import 'logInDoctor.dart';

//import 'package:/cleaning.dart';

class HomeScreen extends StatefulWidget {
  var name, email;
  HomeScreen(this.email, this.name, {super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState(email, name);
}

class _HomeScreenState extends State<HomeScreen> {
  var name, email;
  TextEditingController namecontrol = TextEditingController();

  _HomeScreenState(this.email, this.name);
  @override
  void initState() {
    print(name);
    namecontrol.text = name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: kPrimaryColor,
                  height: 78,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            const Text(
                              //textDirection: TextDirection.rtl,
                              'Hello ',
                              style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 21.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          iconSize: 20,
                          color: Colors.white,
                          onPressed: () {
                            logOut(context);
                            // To do
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPagew()));
                          },
                          icon: const Icon(Icons.logout),
                        ),
                        // const SizedBox(
                        //   width: 200,
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => schedule(email,name)));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Image(
                                image: AssetImage("assets/images/orders.png"),
                                height: 120,
                              ),
                              Text('Scedule',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // To do
                          print(name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => doctorBookings(email,name)));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Image(
                                image: AssetImage("assets/images/scedule.png"),
                                height: 120,
                              ),
                              Text('Appointements',
                                  // textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // To do
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreatProfile(email)));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Image(
                                image: AssetImage("assets/images/setting.png"),
                                height: 120,
                              ),
                              Text('Settings',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // To do
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chat(email)));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Image(
                                image: AssetImage("assets/images/chat.png"),
                                height: 120,
                              ),
                              Text('chats',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // To do
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreatProfile(
                                        name,
                                      )));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
