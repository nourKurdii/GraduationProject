import 'package:flutter_application/Screens/HomePage/allLabs/booking/test_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:get/get.dart';
import '../labTests/labTestsArray.dart';

class AppDataController extends GetxController {
  List<TestModel> TestData = [];
  List<MultiSelectItem> dropDownData = [];
  //List tests = labTestsArray.tests;

  getTestData() {
    TestData.clear();
    dropDownData.clear();
    print("hoon");
    print(labTestsArray.tests);

    // Map<String, dynamic> apiResponse = {
    //   "code": 200,
    //   "message": " test lists.",
    //   "data": [
    //     for (int i = 0; i < tests.length; i++)
    //       {
    //         {"test_id": i.toString(), "test_name": tests[0].toString()},
    //       }
    //   ]
    // };

    // if (apiResponse['code'] == 200) {
    //   List<TestModel> temptestData = [];
    //   apiResponse['data'].forEach(
    //     (data) {
    //       temptestData.add(
    //         TestModel(
    //           TestId: data['test_id'],
    //           TestName: data['test_name'],
    //         ),
    //       );
    //     },
    //   );
    List<TestModel> temptestData = [];
    for (int i = 0; i < labTestsArray.tests.length; i++) {
      temptestData.add(
        TestModel(
          TestId: i.toString(),
          TestName: labTestsArray.tests[i],
        ),
      );
    }
    //print(temptestData);
    TestData.addAll(temptestData);
    dropDownData = TestData.map((testdata) {
      return MultiSelectItem(testdata, testdata.TestName);
    }).toList();

    update();
    // } else if (apiResponse['code'] == 400) {
    //   print("Show Error model why error occurred..");
    // } else {
    //   print("show some error model like something went worng..");
    // }
  }
}
