import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final TextEditingController controller;
  final String hintText;
  final String? label;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.width,
    this.height,
    required this.controller,
    required this.hintText,
    this.label,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 40,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.grey[100]!,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.grey[500]!,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: ColorCode.colorList(context).secondary!,
              )),
        ),
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
