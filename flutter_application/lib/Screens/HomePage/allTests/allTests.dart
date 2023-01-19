// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/HomePage/allTests/API_services.dart';
import 'package:flutter_application/Screens/HomePage/allTests/labModel.dart';
import 'package:flutter_application/Screens/HomePage/allTests/search.dart';
import 'package:flutter_application/constants.dart';

class allTests extends StatefulWidget {
  const allTests({super.key});

  @override
  State<allTests> createState() => _allTests();
}

class _allTests extends State<allTests> {
  final FetchLab _labModel = FetchLab();
  List<String> testsList = [];
  List<String> labsNames = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: const Text("All Tests List"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchTest());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FutureBuilder<List<labModel>>(
                future: _labModel.getLabList(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    testsList.clear();
                    labsNames.clear();
                    var length = (snapshot.data as dynamic).length;
                    for (int i = 0; i < length; i++) {
                      var testsLength = (data?[i].test as dynamic).length;
                      for (int j = 0; j < testsLength; j++) {
                        testsList.add(data![i].test[j]);
                        labsNames.add(data[i].name);
                        // print(data[i].test[j]);
                        //print(data[i].name);
                        //print(testsList);
                      }
                    }
                    // print(testsList.length);
                  }
                  //testsList.add("value");
                  return ListView.builder(
                      itemCount: (testsList).length,
                      itemBuilder: ((context, index) {
                        return Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/Blood test-rafiki.png'),
                                        fit: BoxFit.fitWidth,
                                        filterQuality: FilterQuality.high),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    //color: Colors.red
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      testsList[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      labsNames[index],
                                      style: TextStyle(
                                          color: Colors.grey.shade400,fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }));
                }),
          )),
    );
  }
}
