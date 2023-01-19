import 'package:flutter/material.dart';
import 'profile/components/bottomNavBar.dart';
import 'profile/components/enums.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedMeu: MenuState.home,
      ),
    );
  }
}
