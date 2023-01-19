// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/Screens/LogIn/components/alreadyHaveAnAccountCheck.dart';
import 'package:flutter_application/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../chat/methods.dart';
import 'logInDoctor.dart';

class SignupWPage extends StatefulWidget {
  const SignupWPage({super.key});

  @override
  State<SignupWPage> createState() => _SignupWPageState();
}

class _SignupWPageState extends State<SignupWPage> {
  Dio dio = Dio();

  addDoctor(name, password, phone, title, email) async {
    return await dio.post('http://10.0.2.2:3000/addDoctor',
        data: {
          "name": name,
          "password": password,
          "phone": phone,
          "title": title,
          "email": email
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  var name, password, phone, title, email;
  late List<String> category = [];

  Widget inputFile({label, obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
          
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          TextField(
            // textAlign: TextAlign.right,
            obscureText: obscureText,
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            onChanged: (val) {
              if (label == "name") {
                name = val;
              } else if (label == "password") {
                password = val;
              } else if (label == "email") {
                email = val;
              } else {
                phone = val;
              }
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  // Initial Selected Value
  String dropdownvalue = 'cardiologists';

  // List of items in our dropdown menu
  var items = [
    'cardiologists',
    'dermatologists',
    'geriatricians',
    'neurologists',
    'endocrinologists',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 850),
            child: Container(
              padding: const EdgeInsets.all(12),
              //height: MediaQuery.of(context).size.height - 60,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Make your life work easier!",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      inputFile(label: "email"),
                      inputFile(label: "name"),
                      inputFile(label: "phone"),
                      inputFile(label: "password", obscureText: true),

                      //inputFile(label: "what's your major? ", obscureText: true),
                    ],
                  ),
                  const Text(
                    "What is your specialization",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    
                    child: MaterialButton(
                      minWidth: 250,
                      height: 50,
                      onPressed: () {
                        print("ok");
                        // ignore: avoid_print
                        print(name);
                        print(password.runtimeType);
                        print(email);
                        print(password);
                        //var firebase = '';
                        //firebase = phone + "@gmail.com";
                        createAccount(name, email, password).then((value) {
                          // print(email);
                          addDoctor(name, password, phone, dropdownvalue, email)
                              .then((val) {
                            Fluttertoast.showToast(
                                msg: val.data['msg'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: kPrimaryLightColor,
                                textColor: Colors.grey.shade700,
                                fontSize: 16.0);
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPagew()));
                        });
                        print(dropdownvalue.runtimeType);
                      },
                      color: kPrimaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "create",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  alreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPagew();
                            },
                          ),
                        );
                      }),
                ],
              ),
            ),
          )),
    );
  }
}
