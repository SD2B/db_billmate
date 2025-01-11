import 'package:db_billmate/common_widgets/header_label.dart';
import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HeaderLabel(header: "Stock"),
      ],
    );
  }
}
