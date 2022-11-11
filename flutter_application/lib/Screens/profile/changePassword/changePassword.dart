import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../models/user.dart';
import '../../LogIn/components/RoundedPasswordField.dart';
import '../../welcome/components/roundedButton.dart';

class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  State<changePassword> createState() => _changePassword();
}

class _changePassword extends State<changePassword> {
  //TextEditingController passwordControl = new TextEditingController();
  var email, oldPassword, newPassword;
  Dio dio = new Dio();

  Future updateUser(email, oldPassword, newPassword) async {
    print(email);
    try {
      return await dio.put(
        'http://10.0.2.2:3000/changePassword/$email',
        data: {
          "password": oldPassword,
          "newPassword": newPassword,
        },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(children: [
            RoundedPasswordField(
              textEditingCont: TextEditingController(text: ""),
              onChange: (value) {
                oldPassword = value;
              },
              color: inputFieldBackground,
            ),
            RoundedPasswordField(
              textEditingCont: TextEditingController(text: ""),
              onChange: (value) {
                newPassword = value;   
                             
              },
              color: inputFieldBackground,
            ),
            roundedButton(
              text: "Update",
              press: () {
                print(newPassword);
                print(User.getEmail());
                updateUser(User.getEmail(), oldPassword, newPassword)
                    .then((value) {
                  if (value.data['success']) {
                    User.setPassword(newPassword);
                  }
                  Fluttertoast.showToast(
                      msg: value.data['msg'],
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: kPrimaryLightColor,
                      textColor: Colors.grey,
                      fontSize: 16);
                });
              },
              color: kPrimaryColor,
              textColor: Colors.white,
            ),
          ]),
        ),
      )),
    );
  }
}
