// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/Screens/profile/components/bottomNavBar.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../LogIn/components/RoundedPasswordField.dart';
import '../../welcome/components/roundedButton.dart';
import '../components/enums.dart';
import 'package:image_picker/image_picker.dart';

class userAccount extends StatefulWidget {
  const userAccount({super.key});

  @override
  State<userAccount> createState() => _userAccount();
}

class _userAccount extends State<userAccount> {
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

  // ignore: prefer_typing_uninitialized_variables
  var updateName, updatePhone, updatePassword;
  Dio dio = Dio();

  Future updateUser(email, updateName, updatePassword, updatePhone) async {
    //print(email);
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

  /*Future upload() async {
    if (_file == null) return;
    String base64 = base64Encode(_file!.readAsBytesSync());
  }*/

  //String userImage = User.getImage().toString();
  File? image;

  Future pickerCamera(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final imageTemp = File(image.path);
      //User.setImage(imageTemp.toString());
      //print("ppp" + User.image);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick Image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        selectedMeu: MenuState.profile,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(50),
              child: Form(
                  child: Column(children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage: image != null
                            ? FileImage(image!)
                            : const AssetImage("assets/images/avatar.png")
                                as ImageProvider,
                      ),
                      Positioned(
                        right: -12,
                        bottom: 0,
                        child: SizedBox(
                            height: 46,
                            width: 46,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(27),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: const Color(0xfff5f6f9),
                                ),
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: ((builder) =>
                                          bottomsheet()));
                                },
                                child: SvgPicture.asset(
                                    "assets/images/Camera.svg"),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.grey.shade500),
                  cursorColor: Colors.grey,
                  controller: emailControl,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Your Email',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    //hintText: User.email
                  ),
                  onChanged: (Value) {},
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  style: TextStyle(color: Colors.grey.shade500),
                  cursorColor: Colors.grey,
                  controller: nameControl,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text('Your Full Name',
                          style: TextStyle(color: Colors.grey.shade500)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    //hintText: User.name,
                  ),
                  onChanged: (Value) {
                    updateName = Value;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  style: TextStyle(color: Colors.grey.shade500),
                  cursorColor: Colors.grey,
                  controller: TextEditingController(text: User.phone),
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text('Your Phone Number',
                          style: TextStyle(color: Colors.grey.shade500)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    //hintText: User.phone
                  ),
                  onChanged: (Value) {
                    updatePhone = Value;
                  },
                ),
                const SizedBox(
                  height: 150,
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
                    //print(updatePassword);
                    //print(User.getEmail());
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
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                  onPressed: () {
                    pickerCamera(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: (const Text("Camera")),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                    onPressed: () {
                      pickerCamera(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Gallery")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
