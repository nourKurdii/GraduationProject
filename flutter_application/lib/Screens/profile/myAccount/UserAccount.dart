import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/profile/components/bottomNavBar.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/models/user.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../LogIn/components/RoundedPasswordField.dart';
import '../../LogIn/components/roundedInputField.dart';
import '../../welcome/components/roundedButton.dart';
import '../components/enums.dart';

class userAccount extends StatefulWidget {
  const userAccount({super.key});

  @override
  State<userAccount> createState() => _userAccount();
}

class _userAccount extends State<userAccount> {
  TextEditingController emailControl = new TextEditingController();
  TextEditingController nameControl = new TextEditingController();
  TextEditingController phoneControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailControl.text = User.getEmail();
    nameControl.text = User.getName();
    phoneControl.text = User.getPhone();
  }

  var updateName, updatePhone, updatePassword;
  Dio dio = new Dio();

  Future updateUser(email, updateName, updatePassword, updatePhone) async {
    print(email);
    try {
      return await dio.put(
        'http://10.0.2.2:3000/updateUserinfo/$email',
        data: {
          "name": updateName,
          "phone": updatePhone,
          "password": updatePassword,
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedMeu: MenuState.profile,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(50),
                  child: Form(
                      child: Column(children: [
                    Text(
                      "Profile Page",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.05),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Update Your Information",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.04,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    RounedInputField(
                      textEditingCont: emailControl,
                      color: inputFieldBackground,
                      icon: Icons.email,
                      hintText: "Your Email",
                      onChanged: ((value) => {}),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: size.width * 0.8,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: inputFieldBackground,
                          borderRadius: BorderRadius.circular(29)),
                      child: TextFormField(
                        controller: (nameControl),
                        onChanged: ((value) => {
                              updateName = value,
                            }),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.perm_identity,
                              color: kPrimaryColor,
                            ),
                            hintText: "Your Full Name"),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: size.width * 0.8,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: inputFieldBackground,
                        boxShadow: [
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
                              updatePhone = number.phoneNumber!.toString();
                            },
                            cursorColor: Colors.black,
                            formatInput: false,
                            selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET),
                            inputDecoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(bottom: 15, left: 0),
                                border: InputBorder.none,
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 15.7)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    RoundedPasswordField(
                      textEditingCont: passwordControl,
                      onChange: (value) {
                        updatePassword = value;
                      },
                      color: inputFieldBackground,
                    ),
                    roundedButton(
                      text: "Update",
                      press: () {
                        print(updatePassword);
                        print(User.getEmail());
                        updateUser(User.getEmail(), updateName, updatePassword,
                                updatePhone)
                            .then((value) {
                          if (value.data['success']) {
                            User.setName(updateName);
                            User.setPhone(updatePhone);
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
                  ]))),
            ],
          ),
        )),
      ),
    );
  }
}
