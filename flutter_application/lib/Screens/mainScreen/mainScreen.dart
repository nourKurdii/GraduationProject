
import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/mainScreen/components/body.dart';
import 'package:flutter_application/size_config.dart';

class mainScreen extends StatelessWidget {
  const mainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
