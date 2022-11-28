class report {
  String? id;
  String? patientEmail;
  String? time;
  String date = "";
  int? latitude;
  int? longitude;
  int? rating;
  String testName = "";
  String? labEmail;
  int testResult = 0;
  String? status;
  List? testInfo;

  report(
      this.id,
      this.patientEmail,
      this.date,
      this.labEmail,
      this.latitude,
      this.longitude,
      this.rating,
      this.status,
      this.testName,
      this.testResult,
      this.time,
      this.testInfo);
  report.fromJson(Map json) {
    patientEmail = json['patientEmail'];
    date = json['date'];
    labEmail = json['labEmail'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    testName = json['testName'];
    testResult = json['TestResult'];
    time = json['time'];
    testInfo = json['testInfo']; ////[{},{}]

    /* if (json['labInfo'] != null) {
      labinfo = <labInfo>[];
      (json['labInfo']).forEach((element) {
        labinfo!.add(new labInfo.fromJson(element));
      });
    }*/
  }
}

class testInfo {
  String name = "";
  String category = "";
  String? description;
  int min = 0;
  int max = 0;

  testInfo.fromJson(Map json) {
    name = json['name'];
    description = json['description'];
    min = json['min'];
    max = json['max'];
    category = json['category'];
  }
}
