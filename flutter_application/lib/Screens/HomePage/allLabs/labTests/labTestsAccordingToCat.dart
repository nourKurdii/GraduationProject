import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'testReview.dart';

class labTestAccordingToCat extends StatefulWidget {
  List<String> testsArray;
  String labEmail;
  List<String> unavailable;

  labTestAccordingToCat(this.testsArray, this.labEmail, this.unavailable);

  @override
  _labTestAccordingToCat createState() =>
      _labTestAccordingToCat(testsArray, labEmail, unavailable);
}

class _labTestAccordingToCat extends State<labTestAccordingToCat> {
  List<String> testsArray;
  String labEmail;
  List<String> unavailable;
  _labTestAccordingToCat(this.testsArray, this.labEmail, this.unavailable);
  @override
  void initState() {
    // TODO: implement initState
    print(labEmail);
    print(testsArray);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lab Tests",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0.5,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GridView.count(crossAxisCount: 3, children: [
            for (int i = 0; i < testsArray.length; i++)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => testReport(
                              testsArray[i], labEmail, unavailable)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 248, 245, 255),
                        borderRadius: BorderRadius.circular(20)),
                    //color: Colors.black,
                    //height: 20,
                    //width: 20,
                    child: Center(
                      child: Text(
                        testsArray[i],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }
}
