import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Buttontype type;
  final Function onTap;
  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: width == null ? Expanded(child: CustomButtonCard(width: width, height: height, type: type, text: text)) : CustomButtonCard(width: width, height: height, type: type, text: text),
    );
  }
}

class CustomButtonCard extends StatelessWidget {
  const CustomButtonCard({
    super.key,
    required this.width,
    required this.height,
    required this.type,
    required this.text,
  });

  final double? width;
  final double? height;
  final Buttontype type;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _fromType(type),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _fromTypeForText(type),
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

enum Buttontype { primary, secondary }

Color _fromType(Buttontype type) {
  Color color = Colors.white;
  if (type == Buttontype.primary) {
    return Colors.black;
  } else if (type == Buttontype.secondary) {
    return Colors.grey[300]!;
  }
  return color;
}

Color _fromTypeForText(Buttontype type) {
  Color color = Colors.white;
  if (type == Buttontype.primary) {
    return Colors.white;
  } else if (type == Buttontype.secondary) {
    return Colors.black;
  }
  return color;
}
