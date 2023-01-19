// ignore_for_file: avoid_print, prefer_is_not_empty

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/Screens/HomePage/allLabs/booking/test_controller.dart';
import 'package:flutter_application/Screens/HomePage/allLabs/booking/test_model.dart';
import 'package:flutter_application/constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

import '../../../../models/user.dart';
import '../../../LogIn/components/roundedInputField.dart';
import '../../../profile/components/bottomNavBar.dart';
import '../../../profile/components/enums.dart';

class HomeBookingScreen extends StatefulWidget {
  String labEmail;
  List<String> unavailable;
  double longitude;
  double latitude;
  HomeBookingScreen(
      this.labEmail, this.unavailable, this.latitude, this.longitude,
      {super.key});

  @override
  State<HomeBookingScreen> createState() =>
      _HomeBookingScreen(labEmail, unavailable, latitude, longitude);
}

class _HomeBookingScreen extends State<HomeBookingScreen> {
  String labEmail;
  List<String> unavailable;
  double longitude;
  double latitude;
  _HomeBookingScreen(
      this.labEmail, this.unavailable, this.latitude, this.longitude);
  final List<String> allTimes = <String>[
    'sunday 9:00-9:30',
    'sunday 9:30-10:00',
    'sunday 10:00-10:30',
    'sunday 10:30-11',
    'sunday 11:00-11:30',
    'sunday 11:30-12:00',
    'sunday 12:30-1:00',
    'sunday 1:00-1:30',
    'sunday 1:30-2:00',
    'sunday 2:00-2:30',
    'sunday 2:30-3:00',
    'sunday 3:00-4:30',
    'monday 9:00-9:30',
    'monday 9:30-10',
    'monday 10:00-10:30',
    'monday 10:30-11',
    'monday 11:00-11:30',
    'monday 11:30-12:00',
    'monday 12:30-1:00',
    'monday 1:00-1:30',
    'monday 1:30-2:00',
    'monday 2:00-2:30',
    'monday 2:30-3:00',
    'monday 3:00-4:30',
    'tuesday 9:00-9:30',
    'tuesday 9:30-10',
    'tuesday 10:00-10:30',
    'tuesday 10:30-11',
    'tuesday 11:00-11:30',
    'tuesday 11:30-12:00',
    'tuesday 12:30-1:00',
    'tuesday 1:00-1:30',
    'tuesday 1:30-2:00',
    'tuesday 2:00-2:30',
    'tuesday 2:30-3:00',
    'tuesday 3:00-4:30',
  ];

  final List<String> unavailableTrial = <String>[
    'sunday 9:00-9:30',
    'sunday 9:30-10:00',
    'monday 3:00-4:30',
  ];
  List<String> available = [];
  var dio = Dio();
  addOrder(
    patientEmail,
    labEmail,
    test,
    time,
    date,
    latitude,
    longitude,
    location,
  ) async {
    return await dio.post('http://10.0.2.2:3000/addHomeOrder',
        data: {
          "patientEmail": patientEmail,
          "labEmail": labEmail,
          "testName": test,
          "time": time,
          "date": date,
          "latitude": latitude,
          "longitude": longitude,
          "homeVisit": true,
          "location": location
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  var selected_h;
  var location;

  @override
  void initState() {
    print(latitude);
    print(longitude);
    available.clear();
    available = allTimes
        .toSet()
        .where((element) => !unavailable.toSet().contains(element))
        .toList();

    print(available.length);
    // TODO: implement initState
    super.initState();
  }

  final selectedSeat = ValueNotifier<List<String>>([]);
  final selectedDate = ValueNotifier<DateTime>(DateTime.now());
  final selectedTime = ValueNotifier<TimeOfDay?>(null);
  final AppDataController controller = Get.put(AppDataController());
  ItemScrollController _scrollController = ItemScrollController();

  //get controller => null;

  @override
  Widget build(BuildContext context) {
    List testData = [];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getTestData();
    });

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: kPrimaryLightColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: kPrimaryLightColor,
      bottomNavigationBar: const BottomNavBar(
        selectedMeu: MenuState.home,
      ),
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
                  children: const [
                    // const SizedBox(height: 24),
                    /////
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        " Book Date&Time here!",
                        // style: Theme.of(context).textTheme.titleLarge,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontSize: 30,
                        ),
                      ),
                    ),

                    Expanded(child: SizedBox()),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(48),
                ),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Date",
                    //style: Theme.of(context).textTheme.bodyLarge,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 9, 9, 9),
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border:
                          Border.all(width: 1.5, color: Colors.grey.shade200),
                    ),
                    child: ScrollablePositionedList.builder(
                        itemScrollController: _scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: available.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // available.clear();
                                selected_h = available[index];
                                print(selected_h);
                                //_selectedHour = hours[index];
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: selected_h == available[index]
                                    ? kPrimaryLightColor
                                    : Colors.white,
                                border: Border.all(
                                  color: selected_h == available[index]
                                      ? kPrimaryColor
                                      : Colors.white.withOpacity(0),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    available[index].toString(),
                                    style: const TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Column(children: [
                    GetBuilder<AppDataController>(builder: (controller) {
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MultiSelectDialogField(
                            //height: 200,
                            items: controller.dropDownData,
                            title: const Text(
                              "Select Test",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            selectedColor: Colors.black,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 2,
                              ),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: kPrimaryColor,
                            ),
                            buttonText: const Text(
                              "Select Test",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              for (int i = 0; i < testData.length; i++) {
                                testData.clear();
                              }

                              for (var i = 0; i < results.length; i++) {
                                TestModel data = results[i] as TestModel;
                                //print(data.TestId);
                                //print(data.TestName);
                                if (!testData.contains(data.TestName)) {
                                  testData.add(data.TestName);
                                }
                              }
                              print("data $testData");

                              //_selectedAnimals = results;
                            },
                          ));
                    }),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RounedInputField(
                        textEditingCont: TextEditingController(text: location),
                        hintText: "location description",
                        icon: Icons.location_on,
                        onChanged: (value) {
                          location = value;
                          //User.setEmail(value);
                        },
                        color: inputFieldBackground,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (selected_h == null && (testData.isEmpty)) {
                              Fluttertoast.showToast(
                                  msg: "please Select Date and Tests",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: kPrimaryLightColor,
                                  textColor: Colors.black);
                            } else if (selected_h != null && testData.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "please Select Tests",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: kPrimaryLightColor,
                                  textColor: Colors.black);
                            } else if (selected_h == null &&
                                !testData.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "please Select Date ",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: kPrimaryLightColor,
                                  textColor: Colors.black);
                            } else if (selected_h != null &&
                                !testData.isEmpty) {
                              for (int i = 0; i < testData.length; i++) {
                                addOrder(
                                    User.getEmail(),
                                    labEmail,
                                    testData[i],
                                    selected_h,
                                    DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now()),
                                    latitude,
                                    longitude,
                                    location);
                                print(testData[i]);
                              }

                              Fluttertoast.showToast(
                                  msg: "Your Order has been Added successfully",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: kPrimaryLightColor,
                                  textColor: Colors.black);
                              print(DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now()));
                              print(testData);
                              print(labEmail);
                              print(latitude);
                              print(longitude);
                            }
                            // print((selectedTime.value)?.format(context));
                          },
                          child: Container(
                            height: 50,
                            width: 140,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.all(14),
                            alignment: Alignment.center,
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontFamily: 'Raleway'
                                  //fontWeight: FontWeight.bold
                                  ),
                            ),
                          ),
                        ),
                      ),
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
