// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables, library_private_types_in_public_api, use_key_in_widget_constructors, must_be_immutable, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/reports/allreports.dart';
import 'package:flutter_application/Screens/welcome/components/roundedButton.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/size_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_application/models/report.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart';
import 'package:dio/dio.dart';

class TestReport extends StatefulWidget {
  String testId;
  String labName;
  String labEmail;

  TestReport(this.labEmail, this.labName, this.testId);

  @override
  _TestReport createState() => _TestReport(labEmail, labName, testId);
}

class _TestReport extends State<TestReport> {
  var dio = Dio();
  var initRating;
  getLabRate(labEmail) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getLabRate/$labEmail');
    } on DioError catch (e) {
      print(e);
    }
  }

  changeLabRate(labEmail, rating) async {
    try {
      return await dio.put('http://10.0.2.2:3000/changeLabRate/$labEmail',
          data: {
            "email": labEmail,
            "rating": rating,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  setRateForOrder(orderId, rate) async {
    try {
      return await dio.put('http://10.0.2.2:3000/rateorder/$orderId',
          data: {
            "rating": rate,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  String labEmail;
  var testName;
  int result = 0;
  int max = 0;
  int min = 0;
  var date = "";
  var category = "";
  String labName;
  double resultPercentage = 0.0;
  var percentage;
  @override
  initState() {
    super.initState();
    setState(() {
      getSpeceficReport();
    });
  }

  Future<List> getSpeceficReport() async {
    try {
      var res = await http.get(
        Uri.parse("http://10.0.2.2:3000/getSpeceficReport/$testId"),
      );
      if (res.statusCode == 200) {
        var obj = json.decode(res.body);
        var report1 = report.fromJson(obj[0]);
        min = testInfo.fromJson(report1.testInfo![0]).min;
        max = testInfo.fromJson(report1.testInfo![0]).max;
        date = (report1).date;
        category = testInfo.fromJson(report1.testInfo![0]).category;

        testName = (report1.testName);
        result = report1.testResult;
        resultPercentage = (result * min / max) * 0.1;
        percentage = (resultPercentage * 100).toStringAsFixed(2);

        //print(resultPercentage);
        //print(result);
        //print(min);

        return json.decode(res.body);
      } else {
        return Future.error('error');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  String testId;
  _TestReport(this.labEmail, this.labName, this.testId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Test Report Details",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 1.5,
          actions: [
            IconButton(
              onPressed: _createPDF,
              icon: const Icon(Icons.file_download_outlined),
              color: kSecondColor,
            )
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: kSecondColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const reportsPage()));
            },
          ),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: FutureBuilder<List>(
          future: getSpeceficReport(),
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              //print("no Data");
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              if (snapshot.data[0]['status'] == "finished") {
                return ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(10),
                      vertical: getProportionateScreenHeight(10)),
                  children: [
                    //Gap(getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: getProportionateScreenHeight(86),
                            width: getProportionateScreenHeight(86),
                            decoration: BoxDecoration(
                                //color: Colors.black,
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(10)),
                                image: const DecorationImage(
                                    image:
                                        AssetImage("assets/images/tube.jpg"))),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              testInfo
                                  .fromJson(report
                                      .fromJson(snapshot.data[0])
                                      .testInfo![0])
                                  .category,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Gap(getProportionateScreenHeight(3)),
                            Text(
                              snapshot.data[0]['testName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey.shade500),
                            ),
                            Gap(getProportionateScreenHeight(7)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: kSecondColor,
                                ),
                                const SizedBox(width: 6),
                                Text(snapshot.data[0]['date']),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.access_time_outlined,
                                  color: kSecondColor,
                                ),
                                const SizedBox(width: 6),
                                Text(snapshot.data[0]['time']),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(15),
                            horizontal: getProportionateScreenHeight(20)),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lab Name: $labName",
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: DataTable(columns: [
                        DataColumn(
                            label: Text(
                              "Result",
                              style: GoogleFonts.getFont('Lato',
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold),
                            ),
                            numeric: true),
                        DataColumn(
                            label: Text("Min Value",
                                style: GoogleFonts.getFont('Lato',
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold)),
                            numeric: true),
                        DataColumn(
                            label: Text(
                              "Max Value",
                              style: GoogleFonts.getFont('Lato',
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold),
                            ),
                            numeric: true),
                      ], rows: [
                        DataRow(cells: [
                          DataCell(
                            Center(
                                child: Text(
                              '$result',
                              style: GoogleFonts.getFont('Lato'),
                            )),
                          ),
                          DataCell(
                            Center(child: Text('$min')),
                          ),
                          DataCell(
                            Center(child: Text('$max')),
                          ),
                        ])
                      ]),
                    ),
                    Gap(getProportionateScreenHeight(40)),
                    Container(
                      decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Your Test Result Percentage",
                              style: GoogleFonts.getFont('Lato',
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            CircularPercentIndicator(
                              radius: 40,
                              lineWidth: 8,
                              percent: resultPercentage,
                              progressColor: kPrimaryColor,
                              backgroundColor: Colors.grey.shade300,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                "${(resultPercentage * 100).toStringAsFixed(2)}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 30),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              itemSize: 25,
                              // allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                                initRating = rating;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("Rate our service!",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Raleway'))
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 40, horizontal: 30),
                              child: roundedButton(
                                  text: "confirm rating",
                                  press: () {
                                    print(initRating);
                                    int sum = 0;
                                    var average = 0.0;
                                    var count = 0.0;
                                    setRateForOrder(testId, initRating);
                                    getLabRate(labEmail).then((val) {
                                      print("hon");
                                      print(val.data);
                                      for (int i = 0;
                                          i < val.data!.length;
                                          i++) {
                                        if (val.data![i]['rating'].toString() ==
                                            "null") {
                                          continue;
                                        }

                                        sum += int.parse(
                                            val.data![i]['rating'].toString());
                                        count++;
                                      }

                                      print(sum);
                                      print(count);
                                      average = (sum / count) % 5;
                                      print(average.round());
                                      changeLabRate(labEmail, average.floor());
                                      Fluttertoast.showToast(
                                          msg:
                                              "Ratted successfully! Thank you for your feedback",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: kPrimaryLightColor,
                                          textColor: Colors.black);
                                      setState(() {
                                        snapshot.data[0]['status'];
                                      });
                                    });
                                  },
                                  color: kPrimaryColor,
                                  textColor: Colors.white),
                            )
                          ]),
                    ),
                  ],
                  //child: Text(testId),
                );
              } else {
                return ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(10),
                      vertical: getProportionateScreenHeight(10)),
                  children: [
                    //Gap(getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: getProportionateScreenHeight(86),
                            width: getProportionateScreenHeight(86),
                            decoration: BoxDecoration(
                                //color: Colors.black,
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(10)),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/Science-rafiki.png"))),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              testInfo
                                  .fromJson(report
                                      .fromJson(snapshot.data[0])
                                      .testInfo![0])
                                  .category,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Gap(getProportionateScreenHeight(3)),
                            Text(
                              snapshot.data[0]['testName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey.shade500),
                            ),
                            Gap(getProportionateScreenHeight(7)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: kSecondColor,
                                ),
                                const SizedBox(width: 6),
                                Text(snapshot.data[0]['date']),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.access_time_outlined,
                                  color: kSecondColor,
                                ),
                                const SizedBox(width: 6),
                                Text(snapshot.data[0]['time']),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(15),
                            horizontal: getProportionateScreenHeight(20)),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lab Name: $labName",
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: DataTable(columns: [
                        DataColumn(
                            label: Text(
                              "Result",
                              style: GoogleFonts.getFont('Lato',
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold),
                            ),
                            numeric: true),
                        DataColumn(
                            label: Text("Min Value",
                                style: GoogleFonts.getFont('Lato',
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold)),
                            numeric: true),
                        DataColumn(
                            label: Text(
                              "Max Value",
                              style: GoogleFonts.getFont('Lato',
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold),
                            ),
                            numeric: true),
                      ], rows: [
                        DataRow(cells: [
                          DataCell(
                            Center(
                                child: Text(
                              '$result',
                              style: GoogleFonts.getFont('Lato'),
                            )),
                          ),
                          DataCell(
                            Center(child: Text('$min')),
                          ),
                          DataCell(
                            Center(child: Text('$max')),
                          ),
                        ])
                      ]),
                    ),
                    Gap(getProportionateScreenHeight(40)),
                    Container(
                      decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Your Test Result Percentage",
                              style: GoogleFonts.getFont('Lato',
                                  color: kSecondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            CircularPercentIndicator(
                              radius: 40,
                              lineWidth: 8,
                              percent: resultPercentage,
                              progressColor: kSecondColor,
                              backgroundColor: Colors.grey.shade300,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                "${(resultPercentage * 100).toStringAsFixed(2)}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 30),
                      child: roundedButton(
                          text: "Go Home",
                          press: () {},
                          color: kPrimaryColor,
                          textColor: Colors.white),
                    )
                  ],
                  //child: Text(testId),
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ));
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    //document.pageSettings.margins.top = 70;

    final page = document.pages.add();

    PdfPageTemplateElement header = PdfPageTemplateElement(
        Rect.fromLTWH(0, 0, document.pageSettings.size.width, 100));

    //Create the composite field with date field
    PdfCompositeField compositefields = PdfCompositeField(
      font: PdfStandardFont(
        PdfFontFamily.timesRoman,
        28,
      ),
      brush: PdfSolidBrush(PdfColor(111, 53, 165)),
      text: '\t\t\t\t\t\t\t $labName',
    );

    //Add composite field in header
    compositefields.draw(
      header.graphics,
      Offset(0, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 11).height),
    );

    //Add the header at top of the document
    document.template.top = header;
    page.graphics.drawString(
      'Date: $date',
      PdfStandardFont(PdfFontFamily.helvetica, 20),
      brush: PdfBrushes.dimGray,
    );

    page.graphics.drawString("Test: $testName \t Category: $category",
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.dimGray, bounds: const Rect.fromLTWH(0, 50, 0, 0));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 20),
      cellPadding: PdfPaddings(left: 0, right: 0, top: 7, bottom: 5),
    );
    grid.columns.add(count: 3);
    grid.headers.add(1);
    PdfGridRow headerTable = grid.headers[0];
    headerTable.cells[0].value = 'Result ';
    headerTable.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.center);
    headerTable.cells[1].value = 'Min. Value';
    headerTable.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.center);
    headerTable.cells[2].value = 'Max. Value';
    headerTable.cells[2].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.center);
    headerTable.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(0, 0, 0), width: 3),
        top: PdfPen(PdfColor(0, 0, 0), width: 3),
        bottom: PdfPen(PdfColor(0, 0, 0), width: 3),
        right: PdfPen(PdfColor(0, 0, 0), width: 3));
    headerTable.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(0, 0, 0), width: 3),
        top: PdfPen(PdfColor(0, 0, 0), width: 3),
        bottom: PdfPen(PdfColor(0, 0, 0), width: 3),
        right: PdfPen(PdfColor(0, 0, 0), width: 3));

    headerTable.cells[2].style.borders = PdfBorders(
        left: PdfPen(PdfColor(0, 0, 0), width: 3),
        top: PdfPen(PdfColor(0, 0, 0), width: 3),
        bottom: PdfPen(PdfColor(0, 0, 0), width: 3),
        right: PdfPen(PdfColor(0, 0, 0), width: 3));

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '$result';
    row.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.center);
    row.cells[1].value = '$min';
    row.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.center);
    row.cells[2].value = '$max';
    row.cells[2].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.center);

    row.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(0, 0, 0), width: 3),
        top: PdfPen(PdfColor(0, 0, 0), width: 3),
        bottom: PdfPen(PdfColor(0, 0, 0), width: 3),
        right: PdfPen(PdfColor(0, 0, 0), width: 3));
    row.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(0, 0, 0), width: 3),
        top: PdfPen(PdfColor(0, 0, 0), width: 3),
        bottom: PdfPen(PdfColor(0, 0, 0), width: 3),
        right: PdfPen(PdfColor(0, 0, 0), width: 3));

    row.cells[2].style.borders = PdfBorders(
        left: PdfPen(PdfColor(0, 0, 0), width: 3),
        top: PdfPen(PdfColor(0, 0, 0), width: 3),
        bottom: PdfPen(PdfColor(0, 0, 0), width: 3),
        right: PdfPen(PdfColor(0, 0, 0), width: 3));

    //grid.draw();
    grid.draw(
      page: page,
      bounds: const Rect.fromLTWH(0, 130, 0, 0),
    );

    List<int> bytes = document.saveSync();
    document.dispose();

    saveAndLaunchFile(bytes, 'Report.pdf');
  }
}
