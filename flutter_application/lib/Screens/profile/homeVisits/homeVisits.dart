import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/profile/homeVisits/speceficHomeVisit.dart';

import '../../../constants.dart';
import '../../../models/user.dart';
import '../../reports/reportSection.dart';
import '../profileScreen.dart';
import 'package:http/http.dart' as http;

class homeVisits extends StatefulWidget {
  const homeVisits({super.key});

  @override
  State<homeVisits> createState() => _homeVisits();
}

class _homeVisits extends State<homeVisits> {
  @override
  var dio = Dio();

  Future<List> getHomeVisits(userEmail) async {
    try {
      var res = await http
          .get(Uri.parse("http://10.0.2.2:3000/getHomeVisits/$userEmail"));

      print(userEmail);
      if (res.statusCode == 200) {
        var obj = json.decode(res.body);
        print(obj);
        return json.decode(res.body);
      } else
        return Future.error('error');
    } catch (error) {
      return Future.error(error);
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Home Visits",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 1.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => profileScreen()));
          },
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(alignment: Alignment.center, children: [
            FutureBuilder<List>(
              future: getHomeVisits(User.email),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  //print("no Data");
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  //print(snapshot.data);
                  var length = (snapshot.data as dynamic).length;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        ...List.generate(
                            length,
                            (index) => reportSection(
                                  name: snapshot.data[index]['testName'],
                                  labName: "",
                                  time: snapshot.data[index]['time'],
                                  date: snapshot.data[index]['date'],
                                  labinfo: [],
                                  press: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                speceficHomeVisit(snapshot
                                                    .data[index]['_id'])));
                                  },
                                )),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: SingleChildScrollView(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            child: Container(
                              height: size.height * 0.18,
                              width: size.width,
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 235, 222, 250),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.asset(
                                "assets/images/homeLocation.png",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "No Home Visits Yet",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            " Set Your Location then Book your home vist ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: size.width * 0.35,
                            height: 43,
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ))),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Go to Book Test",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
