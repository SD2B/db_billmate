import 'package:db_billmate/common_widgets/header_label.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataFound extends StatelessWidget {
  final String? message;
  final String? subtitle;
  final bool? nolottie;
  const NoDataFound(
      {super.key, this.message, this.nolottie = false, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (nolottie == false)
            LottieBuilder.asset('assets/images/nodatafound.json',
                height: 200, width: 200, fit: BoxFit.fill),
          HeaderLabel(
            header: message ?? "",
            subHeader: subtitle ?? "",
            headFontSize: 15,
            centerAlign: true,
          ),
        ],
      ),
    );
  }
}
