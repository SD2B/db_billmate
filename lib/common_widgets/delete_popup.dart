import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeletePopup extends StatelessWidget {
  final String title;
  final Function onYes;
  const DeletePopup({
    super.key,
    required this.title,
    required this.onYes,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: SizedBox(width: 250, child: Text(title)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              width: 120,
              text: "Yes",
              textColor: whiteColor,
              buttonColor: black54Color,
              onTap: () async {
                onYes();
                context.pop();
              },
            ),
            CustomButton(
              width: 120,
              text: "No",
              textColor: whiteColor,
              buttonColor: ColorCode.colorList(context).primary,
              onTap: () async => context.pop(),
            ),
          ],
        ),
      ],
    );
  }
}
