import 'dart:convert';

import 'package:http/http.dart' as http;

import 'labModel.dart';

class FetchLab {
  var data = [];
  List<labModel> results = [];
  List<String> testsList = [];
  Future<List<labModel>> getLabList({String? query}) async {
    try {
      var res = await http.get(
        Uri.parse("http://10.0.2.2:3000/getLabInfo"),
      );
      if (res.statusCode == 200) {
        var obj = json.decode(res.body);
        data = json.decode(res.body);
        results = data.map((e) => labModel.fromJson(e)).toList();
        //print(results);
        // var length = results.length;
        // for (int i = 0; i < length; i++) {
        //   var testsLength = (results[i].test as dynamic).length;
        //   for (int j = 0; j < testsLength; j++) {
        //     testsList.add(results[i].test[j]);
        //     // print(results[i].test[j]);
        //     // print(testsList);
        //   }
        // }

        if (query != null) {
          results = results
              .where((e) =>
                  e.test.toString().toLowerCase().contains(query.toLowerCase()))
              .toList();
          // print(results
          //     .where((e) =>
          //         e.test.toString().toLowerCase().contains(query.toLowerCase()))
          //     .toList());
        }
        //print((labModel.fromJson(obj[2]).test).runtimeType);
        return results;
      } else
        return Future.error('error');
    } catch (error) {
      return Future.error(error);
    }
  }
}
