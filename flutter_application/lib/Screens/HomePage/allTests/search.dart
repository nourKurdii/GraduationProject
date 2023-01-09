import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/HomePage/allLabs/labPage/labPage.dart';

import '../../../constants.dart';
import 'API_services.dart';
import 'labModel.dart';

class SearchTest extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  FetchLab _labModel = FetchLab();
  List<String> testsList = [];
  List<String> labsNames = [];
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: FutureBuilder<List<labModel>>(
          future: _labModel.getLabList(query: query),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              testsList.clear();
              labsNames.clear();
              var length = (snapshot.data as dynamic).length;
              for (int i = 0; i < length; i++) {
                var testsLength = (data?[i].test as dynamic).length;
                for (int j = 0; j < testsLength; j++) {
                  if ((data![i].test[j])
                      .toLowerCase()
                      .contains(query.toLowerCase())) {
                    print(data[i].test[j]);
                    testsList.add(data[i].test[j]);
                    labsNames.add(data[i].name);
                  }

                  // print(data[i].test[j]);
                  // print(data[i].name);
                  //print(testsList);
                }
              }
              //print(testsList.length);
            }
            //testsList.add("value");
            return ListView.builder(
                itemCount: (testsList).length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => labpage(data![index].id)));
                    },
                    child: Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/tube2.jpg'),
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
                                Text(testsList[index]),
                                Text(
                                  labsNames[index],
                                  style: TextStyle(color: Colors.grey.shade400),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Search Users"),
    );
  }
}
