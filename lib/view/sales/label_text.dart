import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String label;
  final String text;
  final double? textSize;
  final double? labelAreaSizeSize;
  final double? textAreaSizeSize;
  final TextAlign? textAlign;
  const LabelText({super.key, required this.label, required this.text, this.textSize, this.labelAreaSizeSize, this.textAreaSizeSize, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: labelAreaSizeSize,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: textSize ?? 12,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: textSize ?? 12,
                fontWeight: FontWeight.w500,
              ),
        ),
        5.width,
        SizedBox(
          width: textAreaSizeSize,
          child: Text(
            text,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: textSize ?? 12,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
      ],
    );
  }
}
