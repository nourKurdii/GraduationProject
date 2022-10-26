import 'package:flutter/material.dart';
import 'package:flutter_application/models/lab.dart';
import '../../models/doctor.dart';
import '../Dashboard.dart';
import '../profile/components/bottomNavBar.dart';
import '../profile/components/enums.dart';
import 'components/LabsSection.dart';
import 'components/SectionTitle.dart';
import 'components/appBar.dart';
import 'components/card.dart';
import 'components/doctorCard.dart';
import 'components/listView.dart';
import 'components/searchBar.dart';
import '../../../size_config.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedMeu: MenuState.home,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            //app bar
            appBar(
              icon: Icons.person,
              name: "Nour Kurdi",
            ),
            //Card
            card(),
            SizedBox(
              height: 15,
            ),

            //search
            searchBar(),
            SizedBox(
              height: 15,
            ),

            //horizontal listview tests categories
            listView(),
            SizedBox(
              height: 15,
            ),

            //labs list
            SectionTitle(
              title: "Laboratories",
              press: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Dashboard()));
              },
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(demolab.length,
                        (index) => LabsSection(l: demolab[index]))
                  ],
                )),
            SizedBox(
              height: 15,
            ),

            //doctors list
            SectionTitle(
              title: "Doctors",
              press: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Dashboard()));
              },
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(demoDoctor.length,
                      (index) => doctorCard(d: demoDoctor[index])),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
