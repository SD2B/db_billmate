import 'dart:io';
import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/helpers/send_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ReminderPop extends HookWidget {
  final EndUserModel model;
  const ReminderPop({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    WidgetsToImageController controller = WidgetsToImageController();
    final isDue = useState<bool>((model.balanceAmount.contains("-") || (double.parse(model.balanceAmount) == 0)) ? false : true);
    final customText = useState(isDue.value ? "Please clear it out as soon as you can." : "");
    final customTextController = useTextEditingController(text: customText.value);
    return AlertDialog(
      backgroundColor: whiteColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetsToImage(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: redColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isDue.value ? "Dear Customer, you have a due amount of" : "Dear Customer, your wallet have",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      "₹ ${double.parse(model.balanceAmount).toStringAsFixed(2).split("-").join()}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: isDue.value ? redColor : greenColor,
                          ),
                    ),
                    10.height,
                    Text(
                      customText.value,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          10.height,
          CustomTextField(
            width: 300,
            height: 80,
            controller: customTextController,
            hintText: "",
            label: "Reminder message",
            maxLines: 4,
            onChanged: (p0) => customText.value = p0,
          )
        ],
      ),
      actions: [
        CustomButton(
          width: 150,
          height: 45,
          buttonColor: appPrimary,
          textColor: whiteColor,
          text: "Send",
          onTap: () async {
            Uint8List? bytes = await controller.capture();
            File file = await bytesToImageFile(bytes!);
            await SendHelper.openWhatsAppAndSendImage(model.phone ?? "9656595353", file.path);
          },
        ),
        CustomButton(
          width: 150,
          height: 45,
          buttonColor: appSecondary,
          textColor: appPrimary,
          text: "Cancel",
          onTap: () {
            context.pop();
          },
        ),
      ],
    );
  }
}
