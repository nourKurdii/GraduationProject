// ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/LogIn/LogInScreen.dart';
import 'package:flutter_application/Screens/SignUp/components/background.dart';
import 'package:flutter_application/Screens/LogIn/components/roundedInputField.dart';
import 'package:flutter_application/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../chat/methods.dart';
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
  TextEditingController emailControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailControl.text = User.getEmail();
    nameControl.text = User.getName();
    phoneControl.text = User.getPhone();
  }

  Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();
  //User user = new User();
  //final String name = '';
  var password;
  Future addUser() async {
    try {
      var res = await dio.post('http://10.0.2.2:3000/signUp',
          data: {
            "name": User.name,
            "email": User.email,
            "phone": User.phone,
            "password": User.password
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      // if (res.data["success"] == true) {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => const LogInScreen()));
      //}
    } on DioError catch (e) {
      //return e;
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kPrimaryLightColor,
          textColor: Colors.black);
    }
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
              //Image.asset("assets/images/tube.jpg", width: size.width * 0.15),
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
                              User.setPhone(number.phoneNumber!.toString());
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
                        password = value;
                      },
                      color: inputFieldBackground,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    roundedButton(
                      text: "SIGN UP",
                      press: () {
                        if (User.name == null ||
                            User.password == null ||
                            User.email == null) {
                          Fluttertoast.showToast(
                              msg: "all fields are required",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else if (User.password.toString().length < 6) {
                          Fluttertoast.showToast(
                              msg: "please choose stronger password",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else {
                          print("ok");
                          createAccount(User.name, User.email, password)
                              .then((value) {
                            addUser().then((val) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LogInScreen()));
                              // print(val.data.success);
                              // if (val.data['success'] == true) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               const LogInScreen()));
                              // } else {
                              //   Fluttertoast.showToast(
                              //       msg: val.data['msg'],
                              //       toastLength: Toast.LENGTH_SHORT,
                              //       gravity: ToastGravity.BOTTOM,
                              //       timeInSecForIosWeb: 1,
                              //       backgroundColor: kPrimaryLightColor,
                              //       textColor: Colors.white,
                              //       fontSize: 16.0);
                              // }
                            });
                          });
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
                                return const LogInScreen();
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
