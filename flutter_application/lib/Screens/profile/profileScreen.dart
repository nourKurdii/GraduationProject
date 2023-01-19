import 'package:flutter/material.dart';
import 'package:flutter_application/Screens/profile/components/body.dart';
import 'components/bottomNavBar.dart';
import 'components/enums.dart';

class profileScreen extends StatelessWidget {
  static String routeName = '/profile';
  const profileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: const body(),
      bottomNavigationBar: const BottomNavBar(
        selectedMeu: MenuState.profile,
      ),
    );
  }
}
