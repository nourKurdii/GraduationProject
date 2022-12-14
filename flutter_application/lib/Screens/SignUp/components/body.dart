import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/HomePage/homePage.dart';
import 'package:flutter_application/Screens/LogIn/LogInScreen.dart';
import 'package:flutter_application/Screens/SignUp/components/background.dart';
import 'package:flutter_application/Screens/LogIn/components/roundedInputField.dart';
import 'package:flutter_application/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/user.dart';
import '../../LogIn/components/RoundedPasswordField.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../LogIn/components/alreadyHaveAnAccountCheck.dart';
import '../../welcome/components/roundedButton.dart';

class Signup extends StatefulWidget {
  const Signup({
    Key? key,
  }) : super(key: key);
  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<Signup> {
  TextEditingController emailControl = new TextEditingController();
  TextEditingController nameControl = new TextEditingController();
  TextEditingController phoneControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    emailControl.text = User.getEmail();
    nameControl.text = User.getName();
    phoneControl.text = User.getPhone();
  }

  Dio dio = new Dio();
  final _formKey = GlobalKey<FormState>();
  //User user = new User();
  final String name = '';

  Future addUser() async {
    return await dio.post('http://10.0.2.2:3000/signUp',
        data: {
          "name": User.name,
          "email": User.email,
          "phone": User.phone,
          "password": User.password
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/tube.jpg", width: size.width * 0.15),
              Form(
                  key: _formKey,
                  child: Column(children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.05),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Use your details to create new account!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.04,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    RounedInputField(
                      textEditingCont: emailControl,
                      color: inputFieldBackground,
                      icon: Icons.person,
                      hintText: "Your Email",
                      onChanged: ((value) => {
                            User.setEmail(value),
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: size.width * 0.8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: inputFieldBackground,
                          borderRadius: BorderRadius.circular(29)),
                      child: TextFormField(
                        controller: (nameControl),
                        onChanged: ((value) => {User.setName(value)}),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.perm_identity,
                              color: kPrimaryColor,
                            ),
                            hintText: "Your Full Name"),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: size.width * 0.8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: inputFieldBackground,
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffeeeeee),
                              blurRadius: 10,
                              offset: Offset(0, 4))
                        ],
                        borderRadius: BorderRadius.circular(27),
                        //border: Border.all(color: kPrimaryColor)
                      ),
                      child: Stack(
                        children: [
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              User.setPhone(
                                  number.phoneNumber!.toString());
                            },
                            cursorColor: Colors.black,
                            formatInput: false,
                            selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET),
                            inputDecoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 15, left: 0),
                                border: InputBorder.none,
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 15.7)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    RoundedPasswordField(
                      textEditingCont: passwordControl,
                      onChange: (value) {
                        User.setPassword(value);
                      },
                      color: inputFieldBackground,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    roundedButton(
                      text: "SIGN UP",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          print("ok");
                          addUser();
                          Fluttertoast.showToast(
                              msg: "Signed Up Successfully",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return homePage(User.name);
                              },
                            ),
                          );
                        } else {
                          print("not Ok");
                        }
                      },
                      color: kPrimaryColor,
                      textColor: Colors.white,
                    ),
                    alreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LogInScreen();
                              },
                            ),
                          );
                        }),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
