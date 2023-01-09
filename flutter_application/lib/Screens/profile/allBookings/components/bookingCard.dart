import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

Dio dio = new Dio();

cancelOrder(id) async {
  print(id);
  try {
    return await dio.put(
      'http://10.0.2.2:3000/cancelOrder/$id',
    );
  } on DioError catch (e) {
    return Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kPrimaryLightColor,
        textColor: Colors.black);
  }
}

class bookingCard extends StatelessWidget {
  const bookingCard({
    Key? key,
    required this.name,
    required this.labName,
    required this.time,
    required this.date,
    required this.id,
    required this.status,
  }) : super(key: key);
  final String name, labName, time, date;
  final String id, status;

  showALERT(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelDialog = TextButton(
        child: const Text("No"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget cancelAppointment = TextButton(
        child: const Text("Yes"),
        onPressed: () {
          cancelOrder(id);
        },
      );

      // set up the AlertDialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text("AlertDialog"),
            backgroundColor: kPrimaryColor,

            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: const Text("Do you wanna cancel your appointment ?"),
            actions: [
              cancelDialog,
              cancelAppointment,
            ],
          );
          ;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: SizedBox(
          width: size.width,
          height: 170 / 375 * size.width,
          //height: getProportionateScreenWidth(100),
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: inputFieldBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Test Name : $name",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              // showModalBottomSheet<void>(
                              //     context: context,
                              //     builder: ((builder) => bottomsheet(context)));
                              showALERT(context);
                              // print("object");
                            },
                            icon: const Icon(Icons.cancel_outlined),
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Lab Name : $labName",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month),
                          const SizedBox(width: 6),
                          Text(date),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.access_time_outlined,
                          ),
                          const SizedBox(width: 6),
                          Text(time),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: size.width * 0.35,
                        height: 30,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            status,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ]),
              ),
            ]),
          )),
    ));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
      child: const Text("لا"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
      child: const Text("نعم"),
      onPressed: () {
        cancelOrder(id);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => SelectService(name: name)));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      backgroundColor: const Color.fromARGB(255, 248, 241, 145),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: const Text("هل انت متأكد؟"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget bottomsheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "Do you wanna cancel your appointment?",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.camera),
                  label: (const Text("No")),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton.icon(
                    style: TextButton.styleFrom(primary: kPrimaryColor),
                    onPressed: () {
                      cancelOrder(id);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Yes")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
