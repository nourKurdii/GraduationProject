import 'package:flutter/material.dart';

import '../../../constants.dart';

class appBar extends StatelessWidget {
  const appBar({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello,',
                style: (TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              )
            ],
          ),
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(
                icon,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
