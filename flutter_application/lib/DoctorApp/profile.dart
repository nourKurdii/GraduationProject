// ignore_for_file: sort_child_properties_last, avoid_print

import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CreatProfile extends StatefulWidget {
  var name;
  CreatProfile(this.name);

  @override
  _CreatProfileState createState() => _CreatProfileState(name);
}

class _CreatProfileState extends State<CreatProfile> {
  var name, about, phonenumber;
  late List<String> category = [];
  _CreatProfileState(this.phonenumber);
  TextEditingController namecontrol = TextEditingController();
  TextEditingController phonenumbercontrol = TextEditingController();
  TextEditingController categorycontrol = TextEditingController();
  TextEditingController regioncontrol = TextEditingController();
  TextEditingController aboutcontrol = TextEditingController();
  // final networkHandler = NetworkHandler();
  PickedFile? _imageFile;
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

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    setState(() {});
    init();
  }

  // var item;

  init() {
    List<String> cat = [];
    phonenumbercontrol.text = phonenumber;
    // AuthService().getworkerinfo(phonenumber).then((val) {
    //   print(val.data!['name']);
    //   print(arabicitems.indexOf(val.data['category'][0].toString()));
    //   name = val.data!['name'].toString();
    //   namecontrol.text = val.data!['name'].toString();

    //   for (int i = 0; i < val.data['category'].length; i++) {
    //     cat.add(val.data['category'][i].toString());
    //   }
    //   //  item = val.data['category'].toString();
    //   // print(arabicit[it.indexOf(val.data['region'].toString())]);
    //   print(val.data['region'].toString());

    //   namecontrol.text = name;

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Profile',
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: <Widget>[
            imageProfile(),
            const SizedBox(
              height: 20,
            ),
            nameTextField(),
            const SizedBox(
              height: 20,
            ),
            dobField(),
            const SizedBox(
              height: 20,
            ),
            titleTextField(),
            const SizedBox(
              height: 20,
            ),

            passTextField(),
            const SizedBox(
              height: 20,
            ),
            // cpassTextField(),
            // const SizedBox(
            //   height: 20,
            // ),

            butt(),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 60.0,
          backgroundImage: _imageFile == null
              ? const AssetImage("assets/images/avatar.png") as ImageProvider
              : FileImage(File(_imageFile!.path)),
        ),
        Positioned(
          bottom: 5.0,
          right: 10.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: kSecondColor,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  var password = '';
  Widget nameTextField() {
    return TextField(
      textAlign: TextAlign.left,
      onChanged: ((value) {
        name = value;
      }),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: kSecondColor,
          width: 2,
        )),
        suffixIcon: Icon(
          Icons.person,
          color: kSecondColor,
        ),
      ),
      controller: namecontrol,
    );
  }

  Widget butt() {
    return ElevatedButton(
      child: const Text(
        "Save changes ",
        textDirection: TextDirection.rtl,
      ),
      onPressed: () {
        print(password);
        print(phonenumber);
        // AuthService()
        //     .updateworkerinfo(
        //         name, category, password, region, phonenumber, about)
        //     .then((val) {
        //   print(val.data['msg']);
        //   Fluttertoast.showToast(
        //       msg: val.data['msg'],
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
      ),
    );
  }

  Widget dobField() {
    return TextFormField(
      controller: phonenumbercontrol,
      onChanged: (value) {
        phonenumber = value;
      },
      readOnly: true,
      textAlign: TextAlign.left,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: kPrimaryColor,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: kSecondColor,
          width: 2,
        )),
        suffixIcon: Icon(
          Icons.email,
          color: kSecondColor,
        ),
        hintText: "Enter your valid phone number",
      ),
    );
  }

  Widget titleTextField() {
    return Container(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButton(
        // Initial Value
        value: dropdownvalue,

        // Down Arrow Icon

        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              textAlign: TextAlign.right,
            ),
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
    );
  }

  Widget passTextField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        password = value;
      },
      textAlign: TextAlign.left,
      decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: kPrimaryColor,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: kSecondColor,
            width: 2,
          )),
          suffixIcon: Icon(
            Icons.lock,
            color: kSecondColor,
          ),
          hintText: "password ",
          hintTextDirection: TextDirection.rtl),
    );
  }
}
