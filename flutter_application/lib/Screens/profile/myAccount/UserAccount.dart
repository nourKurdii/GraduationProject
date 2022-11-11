import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  Future upload() async {
    if (_file == null) return;
    String base64 = base64Encode(_file!.readAsBytesSync());
  }

  //String userImage = User.getImage().toString();
  File? _file;

  Future pickerCamera(ImageSource imageSource) async {
    final myfile = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      _file = File(myfile!.path);
      String imageName = _file!.path.split("/").last;
      print("image name" + imageName);
      User.setImage(imageName);
      print("user image" + User.image);
    });
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
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(50),
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
                            backgroundImage: User.getImage() != ""
                                ? AssetImage("assets/images/avatar.png")
                                    as ImageProvider
                                : AssetImage(User.getImage()),
                          ),
                          /*Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: User.getImage() != ""
                                      ? AssetImage("assets/images/avatar.png")
                                          as ImageProvider
                                      : AssetImage(User.getImage()),

                                  //Image.file(_file),
                                  //image: AssetImage("assets/images/avatar.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),*/
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
                                      backgroundColor: Color(0xfff5f6f9),
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
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.grey.shade500),
                      cursorColor: Colors.grey,
                      controller: emailControl,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Your Email',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        //hintText: User.email
                      ),
                      onChanged: (Value) {},
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.grey.shade500),
                      cursorColor: Colors.grey,
                      controller: nameControl,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Your Full Name',
                              style: TextStyle(color: Colors.grey.shade500)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        //hintText: User.name,
                      ),
                      onChanged: (Value) {
                        updateName = Value;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.grey.shade500),
                      cursorColor: Colors.grey,
                      controller: TextEditingController(text: User.phone),
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Your Phone Number',
                              style: TextStyle(color: Colors.grey.shade500)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        //hintText: User.phone
                      ),
                      onChanged: (Value) {
                        updatePhone = Value;
                      },
                    ),
                    SizedBox(
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

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () {
                    pickerCamera(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: (Text("Camera")),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton.icon(
                    style: TextButton.styleFrom(primary: kPrimaryColor),
                    onPressed: () {
                      pickerCamera(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                    label: Text("Gallery")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
