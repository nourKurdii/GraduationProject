import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'textFieldContainer.dart';

class RounedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Color color;
  final String textEditingCont;

  const RounedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.color,
    required this.textEditingCont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return textField(
      color: color,
      child: TextFormField(
        controller: TextEditingController(text: textEditingCont),
        onChanged: onChanged,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText),
            validator: (ValueKey) {
          if (ValueKey!.isEmpty) {
            return 'Email is required';
          } else if (!(RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9. !#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(ValueKey))) {
            return 'Enter Valid email';
          }
        },
      ),
    );
  }
}
