import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/HomePage/homePage.dart';
import 'package:flutter_application/Screens/LogIn/components/background.dart';
import 'package:flutter_application/Screens/SignUp/SignUpScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants.dart';
import '../../../models/user.dart';
import '../../welcome/components/roundedButton.dart';
import 'RoundedPasswordField.dart';
import 'alreadyHaveAnAccountCheck.dart';
import 'roundedInputField.dart';
import 'package:dio/dio.dart';

class Signin extends StatefulWidget {
  const Signin({
    Key? key,
  }) : super(key: key);

  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<Signin> {
  var logEmail, logPassword;
  TextEditingController emailControl = new TextEditingController();
  TextEditingController nameControl = new TextEditingController();
  TextEditingController phoneControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameControl.text = User.getName();
    phoneControl.text = User.getPhone();
  }

  var dio = Dio();

  getUserInfo(email) async {
    var res = await dio.get(('http://10.0.2.2:3000/getUserInfo/$email'));

    if (res.statusCode == 200) {
      print(User.email);
      print((res));
      User.setName(res.data["name"]);
      User.setPhone(res.data["phone"]);

      //User.getName();
      //print(res.data["name"]);
      var name;
      name = (User.getName());
      print(name);
      //return jsonDecode(res.data);
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => homePage(name)));
    } else
      return Future.error('error');
  }

  save(logEmail, logPassword) async {
    try {
      return await dio.post(
        ('http://10.0.2.2:3000/authenticate'),
        data: {"email": logEmail, "password": logPassword},
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
                child: Column(children: [
                  RounedInputField(
                    textEditingCont: TextEditingController(text: logEmail),
                    hintText: "someone@company.com",
                    icon: Icons.person,
                    onChanged: (value) {
                      logEmail = value;
                      //User.setEmail(value);
                    },
                    color: inputFieldBackground,
                  ),
                  RoundedPasswordField(
                      onChange: (Value) {
                        logPassword = Value;
                        //User.setPassword(Value);
                      },
                      color: inputFieldBackground,
                      textEditingCont:
                          TextEditingController(text: logPassword)),
                  roundedButton(
                    text: "LOGIN",
                    press: () {
                      save(logEmail, logPassword).then((value) {
                        if (value.data['success']) {
                          print("ok");
                          Fluttertoast.showToast(
                              msg: value.data['msg'],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 16.0);
                          User.setEmail(logEmail);
                          getUserInfo(logEmail);
                        } else {
                          print("not Ok");
                          Fluttertoast.showToast(
                              msg: value.data['msg'],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kPrimaryLightColor,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        }
                      });
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
