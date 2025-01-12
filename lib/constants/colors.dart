import 'package:flutter/material.dart';

class ColorList {
  final Color? primary;
  final Color? secondary;
  final Color? middlePrimary;
  final Color? middleSecondary;
  final Color? labelColor;
  final Color? success;
  final Color? error;
  final Color? borderColor;
  final Color? ratingColor;
  final Color? customTextColor;
  final Color? bgColor;

  ColorList({this.primary, this.secondary, this.middlePrimary, this.middleSecondary, this.labelColor, this.success, this.error, this.borderColor, this.ratingColor, this.customTextColor, this.bgColor});

  factory ColorList.light() {
    return ColorList(
      primary: Colors.black87,
      secondary: const Color(0xFFfbfff1),
      middlePrimary: const Color(0xFF3066be),
      middleSecondary: const Color(0xFFb4c5e4),
      labelColor: const Color(0xFF6C7584),
      borderColor: Colors.grey[350],
      success: const Color(0xFF007C5A),
      error: Colors.red[900],
      ratingColor: const Color(0xFFF0A500),
      customTextColor: const Color(0xFF1D2F47),
      bgColor: const Color(0xFFbae5f5),
    );
  }

  factory ColorList.dark() {
    return ColorList(
      primary: const Color(0xFFbae5f5),
      secondary: const Color(0xFFE83D3D),
      middlePrimary: const Color(0xFF3066be),
      middleSecondary: const Color(0xFFb4c5e4),
      labelColor: const Color(0xFF6C7584),
      borderColor: const Color(0xFFE5E8EC),
      success: const Color(0xFF007C5A),
      error: Colors.red[900],
      ratingColor: const Color(0xFFF0A500),
      customTextColor: const Color(0xFF1D2F47),
      bgColor: const Color(0xFFbae5f5),
    );
  }
}

class ColorCode {
  static ColorList colorList(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? ColorList.light() : ColorList.dark();
  }
}

const redColor = Colors.red;
const redAccentColor = Colors.redAccent;

const pinkColor = Colors.pink;
const pinkAccentColor = Colors.pinkAccent;

const purpleColor = Colors.purple;
const purpleAccentColor = Colors.purpleAccent;

const deepPurpleColor = Colors.deepPurple;
const deepPurpleAccentColor = Colors.deepPurpleAccent;

const indigoColor = Colors.indigo;
const indigoAccentColor = Colors.indigoAccent;

const blueColor = Colors.blue;
const blueAccentColor = Colors.blueAccent;

const lightBlueColor = Colors.lightBlue;
const lightBlueAccentColor = Colors.lightBlueAccent;

const cyanColor = Colors.cyan;
const cyanAccentColor = Colors.cyanAccent;

const tealColor = Colors.teal;
const tealAccentColor = Colors.tealAccent;

const greenColor = Colors.green;
const greenAccentColor = Colors.greenAccent;

const lightGreenColor = Colors.lightGreen;
const lightGreenAccentColor = Colors.lightGreenAccent;

const limeColor = Colors.lime;
const limeAccentColor = Colors.limeAccent;

const yellowColor = Colors.yellow;
const yellowAccentColor = Colors.yellowAccent;

const amberColor = Colors.amber;
const amberAccentColor = Colors.amberAccent;

const orangeColor = Colors.orange;
const orangeAccentColor = Colors.orangeAccent;

const deepOrangeColor = Colors.deepOrange;
const deepOrangeAccentColor = Colors.deepOrangeAccent;

const brownColor = Colors.brown;

const greyColor = Colors.grey;

const blueGreyColor = Colors.blueGrey;

const blackColor = Colors.black;
const black12Color = Colors.black12;
const black26Color = Colors.black26;
const black38Color = Colors.black38;
const black45Color = Colors.black45;
const black54Color = Colors.black54;
const black87Color = Colors.black87;

const whiteColor = Colors.white;
const white10Color = Colors.white10;
const white12Color = Colors.white12;
const white24Color = Colors.white24;
const white30Color = Colors.white30;
const white38Color = Colors.white38;
const white54Color = Colors.white54;
const white60Color = Colors.white60;
const white70Color = Colors.white70;

const transparentColor = Colors.transparent;
