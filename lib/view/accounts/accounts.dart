import 'package:db_billmate/common_widgets/header_label.dart';
import 'package:flutter/material.dart';

class Accounts extends StatelessWidget {
  const Accounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HeaderLabel(header: "Accounts"),
      ],
    );
  }
}
