import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';

class ItemTableValues extends StatelessWidget {
  final int? flex;
  final String value;

  const ItemTableValues({super.key, this.flex, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex ?? 1,
        child: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: ColorCode.colorList(context).primary),
          ),
        ));
  }
}
