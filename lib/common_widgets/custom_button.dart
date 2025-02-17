import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final TextStyle? style;
  final Color? buttonColor;
  final Color? textColor;
  final Function onTap;
  final bool isLoading;
  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    this.style,
    this.buttonColor,
    this.textColor,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: width == null ? Expanded(child: CustomButtonCard(width: width, height: height, buttonColor: buttonColor, textColor: textColor, text: text, isLoading: isLoading, style: style)) : CustomButtonCard(width: width, height: height, buttonColor: buttonColor, textColor: textColor, text: text, isLoading: isLoading, style: style),
    );
  }
}

class CustomButtonCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? textColor;

  final String text;
  final TextStyle? style;
  final bool isLoading;

  const CustomButtonCard({
    super.key,
    required this.width,
    required this.height,
    this.buttonColor,
    this.textColor,
    required this.text,
    this.style,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: height ?? 40,
            width: width,
            child: SpinKitSpinningLines(
              size: 25,
              color: ColorCode.colorList(context).primary!,
            ),
          )
        : Container(
            height: height ?? 40,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: buttonColor ?? Colors.white,
            ),
            child: Center(
              child: Text(
                text,
                style: style ??
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: textColor ?? Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
              ),
            ),
          );
  }
}
