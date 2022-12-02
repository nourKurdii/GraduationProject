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
import 'components/searchBar.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class homePage extends StatefulWidget {
  var name;

  homePage(this.name);

  @override
  _homeState createState() => _homeState(name);
}

Future<List> fetchLab() async {
  try {
    var res = await http.get(
      Uri.parse("http://10.0.2.2:3000/getLabInfo"),
    );
    if (res.statusCode == 200) {
      var obj = jsonDecode(res.body);
      //print(obj);
      return jsonDecode(res.body);
    } else
      return Future.error('error');
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
      var obj = jsonDecode(res.body);
      //print(obj);
      return jsonDecode(res.body);
    } else
      return Future.error('error');
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
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedMeu: MenuState.home),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            //app bar
            //print(snapshot.data);

            appBar(
              icon: Icons.person,
              name: this.name,
            ),

            //Card
            card(),
            SizedBox(
              height: 15,
            ),

            //search
            // searchBar(),
            SizedBox(
              height: 15,
            ),

            //horizontal listview tests categories
            listView(),
            SizedBox(
              height: 15,
            ),

            //labs list
            SectionTitle(
              title: "Laboratories",
              press: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => mainLab()));
              },
            ),
            FutureBuilder<List>(
              future: fetchLab(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  print("no Data");
                  return CircularProgressIndicator();
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
                                  Image: snapshot.data[index]['image'],
                                  Location: snapshot.data[index]['location'],
                                )),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
            ),

            SizedBox(
              height: 15,
            ),

            //doctors list
            SectionTitle(
              title: "Doctors",
              press: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Dashboard()));
              },
            ),
            SizedBox(
              height: 10,
            ),

            FutureBuilder<List>(
              future: fetchLab(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  print("no Data");
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  //print(snapshot.data);

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(demoDoctor.length,
                            (index) => doctorCard(d: demoDoctor[index])),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
            ),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
