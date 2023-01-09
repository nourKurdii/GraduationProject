import 'package:flutter/material.dart';
import '../../../../map/map.dart';
import 'package:dio/dio.dart';

class HomeTestReport extends StatefulWidget {
  String testName;
  String labEmail;
  List<String> unavailable;
  HomeTestReport(this.testName, this.labEmail, this.unavailable);
  @override
  HomeTestReportState createState() =>
      HomeTestReportState(testName, labEmail, unavailable);
}

class HomeTestReportState extends State<HomeTestReport> {
  String testName;
  String labEmail;
  List<String> unavailable;
  HomeTestReportState(this.testName, this.labEmail, this.unavailable);
  int _value = 0;

  TextEditingController _date = TextEditingController();
  Dio dio = new Dio();

  Future<Object> getTestInfo(testName) async {
    try {
      var res = await dio.get(("http://10.0.2.2:3000/getTestInfo/$testName"));
      if (res.statusCode == 200) {
        setState(() {
          res;
        });
        return res.data;
      } else
        return Future.error('error');
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Test',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Raleway')),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: FutureBuilder<Object>(
        future: getTestInfo(testName),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  Row(children: [
                    Container(
                        padding: const EdgeInsets.only(top: 5, left: 13),
                        height: 50,
                        width: 385,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 137, 123, 163)
                                  .withOpacity(0.1),
                              blurRadius: 5.0,
                              offset: const Offset(3, 3),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(children: <Widget>[
                          const Text('Test Name :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'Raleway',
                                  color: Colors.black)),
                          const SizedBox(width: 6),
                          Expanded(
                              child: Text(snapshot.data['name'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Raleway',
                                      color: Colors.black)))
                        ])),
                  ]),
                  const Padding(padding: EdgeInsets.only(bottom: 7)),
                  const Padding(padding: EdgeInsets.only(bottom: 7)),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 5, left: 13),
                          height: 130,
                          width: 385,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 137, 123, 163)
                                          .withOpacity(0.1),
                                  blurRadius: 5.0,
                                  offset: const Offset(3, 3),
                                  spreadRadius: 1,
                                ),
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text('About the test :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                        color: Colors.black)),
                                const SizedBox(width: 6),
                                Expanded(
                                    child: Text(snapshot.data['description'],
                                        maxLines: 10,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway',
                                            color: Colors.black)))
                              ])),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 7)),
                  const Padding(padding: EdgeInsets.only(bottom: 7)),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 5, left: 13),
                          height: 30,
                          width: 385,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 137, 123, 163)
                                          .withOpacity(0.1),
                                  blurRadius: 5.0,
                                  offset: const Offset(3, 3),
                                  spreadRadius: 1,
                                ),
                              ]),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text('Test Price :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                        color: Colors.black)),
                                const SizedBox(width: 6),
                                Text(snapshot.data['price'],
                                    maxLines: 10,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black))
                              ])),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 200)),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        //padding:EdgeInsets.only(top:8),
                        width: 310,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(25),
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
                            'Set Location',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                fontFamily: 'Raleway',
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CurrentLocationScreen(labEmail,unavailable)));
                            // print('ffff');
                          },
                        ),
                      )
                    ],
                  ),
                ]);
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}

class AppColors {
  static Color mainColor = const Color.fromARGB(255, 133, 73, 188);
  static Color backgroundColor = const Color.fromARGB(255, 255, 255, 255);
}
