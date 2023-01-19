// ignore_for_file: avoid_print, camel_case_types

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../models/user.dart';
import '../../welcome/components/roundedButton.dart';
import '../profileScreen.dart';

class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  State<changePassword> createState() => _changePassword();
}

class _changePassword extends State<changePassword> {
  //TextEditingController passwordControl = new TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
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
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: kPrimaryColor,
          onPressed: () {
            Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const profileScreen()));
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(children: [
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.grey.shade500),
                cursorColor: Colors.grey,
                controller: TextEditingController(text: ""),
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text('Your Old Password',
                        style: TextStyle(color: Colors.grey.shade500)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey,
                  )),
                  //hintText: User.phone
                ),
                onChanged: (Value) {
                  oldPassword = Value;
                },
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.grey.shade500),
                cursorColor: Colors.grey,
                controller: TextEditingController(text: ""),
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text('Your New Password',
                        style: TextStyle(color: Colors.grey.shade500)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey,
                  )),
                  //hintText: User.phone
                ),
                onChanged: (Value) {
                  newPassword = Value;
                },
              ),
              const SizedBox(
                height: 20,
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
          )),
    );
  }
}
