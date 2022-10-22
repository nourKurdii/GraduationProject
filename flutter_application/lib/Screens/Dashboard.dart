import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/profile/profileScreen.dart';
import 'package:flutter_application/Screens/welcome/components/roundedButton.dart';

import '../constants.dart';
import 'profile/components/bottomNavBar.dart';
import 'profile/components/enums.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedMeu: MenuState.home,
      ),
    );
  }
}
