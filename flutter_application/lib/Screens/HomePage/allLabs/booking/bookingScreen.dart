import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/Screens/HomePage/allLabs/booking/timeExtention.dart';
import 'package:flutter_application/Screens/welcome/components/roundedButton.dart';
import 'package:flutter_application/constants.dart';

import '../../../../map/map.dart';
import 'dateWidget.dart';
import 'timeWidget.dart';

class MovieBookingScreen extends StatefulWidget {
  const MovieBookingScreen({super.key});

  @override
  State<MovieBookingScreen> createState() => _MovieBookingScreenState();
}

class _MovieBookingScreenState extends State<MovieBookingScreen> {
  int _value = 0;

  final selectedSeat = ValueNotifier<List<String>>([]);
  final selectedDate = ValueNotifier<DateTime>(DateTime.now());
  final selectedTime = ValueNotifier<TimeOfDay?>(null);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Color.fromARGB(255, 233, 227, 243),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0XFF6F36A5),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 233, 227, 243),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<List<String>>(
            valueListenable: selectedSeat,
            builder: (context, value, _) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 24),
                    /////
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        " Book Date&Time here!",
                        // style: Theme.of(context).textTheme.titleLarge,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 90, 43, 133),
                          fontSize: 30,
                        ),
                      ),
                    ),

                    const Expanded(child: SizedBox()),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(48),
                ),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Date",
                    //style: Theme.of(context).textTheme.bodyLarge,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 9, 9, 9),
                      fontSize: 22,
                    ),
                  ),
                  ValueListenableBuilder<DateTime>(
                    valueListenable: selectedDate,
                    builder: (context, value, _) {
                      return SizedBox(
                        height: 96,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            14,
                            (index) {
                              final date = DateTime.now().add(
                                Duration(days: index),
                              );
                              return InkWell(
                                onTap: () {
                                  selectedDate.value = date;
                                },
                                child: DateWidget(
                                  date: date,
                                  isSelected:
                                      value.simpleDate == date.simpleDate,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const Text(
                    "Select Time",
                    //style: Theme.of(context).textTheme.bodyLarge,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 9, 9, 9),
                      fontSize: 22,
                    ),
                  ),
                  ValueListenableBuilder<TimeOfDay?>(
                    valueListenable: selectedTime,
                    builder: (context, value, _) {
                      return SizedBox(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            8,
                            (index) {
                              final time = TimeOfDay(
                                hour: 10 + (index),
                                minute: 30,
                              );
                              return InkWell(
                                onTap: () {
                                  selectedTime.value = time;
                                },
                                child: TimeWidget(
                                  time: time,
                                  isSelected: value == time,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Column(children: <Widget>[
                    const Text(
                      "Visit",
                      //style: Theme.of(context).textTheme.bodyLarge,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 9, 9, 9),
                        fontSize: 22,
                      ),
                    ),
                    Row(children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value as int;
                          });
                        },
                      ),
                      //
                      Text("Lab Visit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Raleway')),
                      SizedBox(
                        width: 20.0,
                      ),
                      Radio(
                        value: 2,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value as int;
                          });
                        },
                      ),
                      //SizedBox(width: 5.0,),
                      Text("Home Visit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Raleway')),
                    ])
                  ]),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        //height: size.height * 0.069,
                        width: size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(27),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          CurrentLocationScreen()));
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                              backgroundColor: kPrimaryColor,
                            ),
                            child: Text(
                              "Set Your Location",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
