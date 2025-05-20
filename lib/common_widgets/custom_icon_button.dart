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
  final String? tooltipMsg;
  final Widget? badge;
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.buttonColor,
    this.iconColor,
    this.buttonSize,
    this.iconSize,
    this.shape,
    this.noTap = false,
    this.tooltipMsg,
    this.badge,
  });

  Widget iconButton(BuildContext context) {
    return Badge(
      backgroundColor: transparentColor,
      alignment: FractionalOffset(.8, 0),
      label: badge,
      child: Container(
        height: buttonSize ?? 38,
        width: buttonSize ?? 38,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.circle,
          color: buttonColor ?? ColorCode.colorList(context).primary,
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(8) : null,
        ),
        child: Icon(icon, color: iconColor ?? Colors.white, size: iconSize),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: tooltipMsg ?? "",
        child: noTap
            ? iconButton(context)
            : InkWell(
                onTap: () {
                  onTap?.call();
                },
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(500),
                child: iconButton(context)));
  }
}
