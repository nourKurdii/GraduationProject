import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/reports/allreports.dart';
import 'package:flutter_application/Screens/welcome/components/roundedButton.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/size_config.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_application/models/report.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart';

class TespReport extends StatefulWidget {
  var testId;
  var labName;

  TespReport(this.testId);

  @override
  _TespReport createState() => _TespReport(testId);
}

class _TespReport extends State<TespReport> {
  var testName;
  int result = 0;
  int max = 0;
  int min = 0;
  var labName = "lab Name";
  var date = "";
  var category = "";

  double resultPercentage = 0.0;
  var percentage;
  @override
  initState() {
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
      } else
        return Future.error('error');
    } catch (error) {
      return Future.error(error);
    }
  }

  var testId;
  _TespReport(this.testId);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Test Report Details",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1.5,
          actions: [
            IconButton(
              onPressed: _createPDF,
              icon: Icon(Icons.file_download_outlined),
              color: kPrimaryColor,
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: kPrimaryColor,
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => reportsPage()));
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List>(
          future: getSpeceficReport(),
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              //print("no Data");
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
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
                              image: DecorationImage(
                                  image: AssetImage("assets/images/tube.jpg"))),
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
                            style: TextStyle(
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
                              Icon(Icons.calendar_month),
                              SizedBox(width: 6),
                              Text(snapshot.data[0]['date']),
                              SizedBox(width: 6),
                              Icon(
                                Icons.access_time_outlined,
                              ),
                              SizedBox(width: 6),
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
                                "Lab Name: ",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Lab name")
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
                              (resultPercentage * 100).toStringAsFixed(2) + "%",
                              style: TextStyle(fontWeight: FontWeight.bold),
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
            } else {
              return CircularProgressIndicator();
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
