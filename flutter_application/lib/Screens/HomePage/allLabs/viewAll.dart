import 'package:flutter/material.dart';
import '../../profile/components/bottomNavBar.dart';
import '../../profile/components/enums.dart';
import 'labPage/labPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class mainLab extends StatefulWidget {
  @override
  mainLabState createState() => mainLabState();
}

class mainLabState extends State<mainLab> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 239, 245),
      bottomNavigationBar: const BottomNavBar(selectedMeu: MenuState.home),
      appBar: AppBar(
        title: const Text(
          'Nearby Laboratories',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Raleway'),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: FutureBuilder<List>(
        future: fetchLab(),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            print("no Data");
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            //print(snapshot.data);

            return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (snapshot.data as dynamic).length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  labpage(snapshot.data[index]['_id'])));
                    },
                    child: Container(
                        constraints:
                            const BoxConstraints(minHeight: 122, maxHeight: 150),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 233, 240),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 239, 236, 244)
                                  .withOpacity(0.1),
                              blurRadius: 10.0,
                              offset: const Offset(0, 3),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: Card(
                          color: const Color.fromARGB(255, 236, 233, 240),
                          child: Container(
                            height: 110,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Wrap(
                                    children: <Widget>[
                                      Container(
                                        width: 110.0,
                                        height: 90.0,
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 5, left: 10),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 232, 232, 232),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          //padding: EdgeInsets.only(top: 10),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/labm.jpg"),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 17)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          InkWell(
                                            child: Text(
                                                snapshot.data[index]['name'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    fontFamily: 'Raleway')),
                                            onTap: () {},
                                          ),
                                          const SizedBox(height: 10),
                                          Wrap(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Color.fromARGB(
                                                    255, 218, 199, 222),
                                                size: 17,
                                              ),
                                              Text(
                                                  snapshot.data[index]
                                                      ['location'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                });
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}

class AppColors {
  static final Color mainColor = const Color(0XFF6F36A5);
}
