import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            border: Border.all(color: appPrimary),
            borderRadius: BorderRadius.circular(10),
          ),
        )
      ],
    );
  }
}
