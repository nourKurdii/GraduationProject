// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/HomePage/homePage.dart';
import 'package:flutter_application/Screens/LogIn/components/background.dart';
import 'package:flutter_application/Screens/SignUp/SignUpScreen.dart';

import '../../../constants.dart';
import '../../../models/user.dart';
import '../../welcome/components/roundedButton.dart';
import 'RoundedPasswordField.dart';
import 'alreadyHaveAnAccountCheck.dart';
import 'roundedInputField.dart';
import 'package:http/http.dart' as http;

class Signin extends StatefulWidget {
  const Signin({
    Key? key,
  }) : super(key: key);
  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  User user = new User('', '');
  Future save() async {
    var res = await http.post(Uri.parse("http://10.0.2.2:3000/authenticate"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UFT-8'
        },
        body: <String, String>{
          'email': user.email,
          'password': user.password
        });
    print(res.body);

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => homePage()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: background(
        //container
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold),),
            //SizedBox(height: size.height * 0.03, ),
            Image.asset("assets/images/signin_page.png",
                width: size.width * 0.6),
            Container(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  RounedInputField(
                    textEditingCont: user.email,
                    hintText: "someone@company.com",
                    icon: Icons.person,
                    onChanged: (value) {
                      user.email = value;
                    },
                    color: inputFieldBackground,
                  ),
                  RoundedPasswordField(
                    onChange: (Value) {
                      user.password = Value;
                    },
                    color: inputFieldBackground,
                    textEditingCont: user.password,
                  ),
                  roundedButton(
                    text: "LOGIN",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        print("ok");
                        save();
                      } else {
                        print("not Ok");
                      }
                    },
                    color: kPrimaryColor,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  alreadyHaveAnAccountCheck(press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  }),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
