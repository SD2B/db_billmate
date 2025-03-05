import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitThreeInOut(
            color: ColorCode.colorList(context).primary!,
          ),
          // SpinKitChasingDots(
          //   color: ColorCode.colorList(context).borderColor,
          // ),
        ],
      ),
    );
  }
}
