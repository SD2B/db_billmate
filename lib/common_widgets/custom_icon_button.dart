import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Function? onTap;
  final Color? buttonColor;
  final Color? iconColor;
  final double? buttonSize;
  final double? iconSize;
  final BoxShape? shape;
  final bool noTap;
  const CustomIconButton(
      {super.key,
      required this.icon,
      this.onTap,
      this.buttonColor,
      this.iconColor,
      this.buttonSize,
      this.iconSize,
      this.shape,
      this.noTap = false});

  @override
  Widget build(BuildContext context) {
    return noTap
        ? CustomIconButtonCard(
            buttonSize: buttonSize,
            shape: shape,
            buttonColor: buttonColor,
            icon: icon,
            iconColor: iconColor,
            iconSize: iconSize)
        : InkWell(
            onTap: () {
              onTap?.call();
            },
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
            child: CustomIconButtonCard(
                buttonSize: buttonSize,
                shape: shape,
                buttonColor: buttonColor,
                icon: icon,
                iconColor: iconColor,
                iconSize: iconSize),
          );
  }
}

class CustomIconButtonCard extends StatelessWidget {
  const CustomIconButtonCard({
    super.key,
    required this.buttonSize,
    required this.shape,
    required this.buttonColor,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
  });

  final double? buttonSize;
  final BoxShape? shape;
  final Color? buttonColor;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonSize ?? 38,
      width: buttonSize ?? 38,
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.circle,
        color: buttonColor ?? ColorCode.colorList(context).primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: iconColor ?? Colors.white, size: iconSize),
    );
  }
}
