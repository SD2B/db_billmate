import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String label;
  final String text;
  const LabelText({
    super.key,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
        ),
        5.width,
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
        ),
      ],
    );
  }
}
