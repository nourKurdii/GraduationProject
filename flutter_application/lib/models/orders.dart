// ignore_for_file: camel_case_types

class order {
  String? id;
  String? patientEmail;
  String? time;
  String? date;
  double? latitude;
  double? longitude;
  int? rating;
  String testName = "";
  String? labEmail;
  int testResult = 0;
  String? status;
  List? labinfo;

  order(
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
      this.labinfo);
  order.fromJson(Map json) {
    patientEmail = json['patientEmail'];
    date = json['date'];
    labEmail = json['labEmail'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    testName = json['testName'];
    testResult = json['TestResult'];
    time = json['time'];
    labinfo = json['labInfo']; ////[{},{}]

    /* if (json['labInfo'] != null) {
      labinfo = <labInfo>[];
      (json['labInfo']).forEach((element) {
        labinfo!.add(new labInfo.fromJson(element));
      });
    }*/
  }
}

class labInfo {
  String name = "";
  String email = "";

  labInfo.fromJson(Map json) {
    name = json['name'];
    email = json['email'];
  }
}
