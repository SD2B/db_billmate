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
        Text(label),
        Text(text),
      ],
    );
  }
}
