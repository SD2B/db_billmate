import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';

class ItemTableHeaders extends StatelessWidget {
  final int? flex;
  final String value;

  const ItemTableHeaders({super.key, this.flex, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex ?? 1,
        child: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: ColorCode.colorList(context).primary),
          ),
        ));
  }
}
