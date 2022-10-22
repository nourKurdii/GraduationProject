// ignore: file_names
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'textFieldContainer.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChange;
  final Color color;
  final String textEditingCont;

  const RoundedPasswordField({
    Key? key,
    required this.onChange,
    required this.color,
    required this.textEditingCont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return textField(
      color: color,
      child: TextFormField(
          controller: TextEditingController(text: textEditingCont),
          onChanged: onChange,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "password",
            border: InputBorder.none,
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ),
          ),
          validator: (ValueKey) {
            if (ValueKey!.isEmpty) {
              return 'password is required';
            }
          }),
    );
  }
}
