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
    required this.press,
    required this.labName,
    required this.time,
    required this.date,
    required this.id,
    required this.status,
  }) : super(key: key);
  final String name, labName, time, date;
  final GestureTapCallback press;
  final String id, status;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Test Name : $name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    cancelOrder(id);
                                  },

                                  icon: Icon(Icons.delete),
                                  //color: kPrimaryColor,
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
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 6),
                                Text(date),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.access_time_outlined,
                                ),
                                SizedBox(width: 6),
                                Text(time),
                              ],
                            ),
                            SizedBox(
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
                  ),
                ]),
              )),
        ));
  }
}
