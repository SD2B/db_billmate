import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePasswordScreen extends HookConsumerWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCtrl = useTextEditingController();
    final newCtrl = useTextEditingController();
    final reCtrl = useTextEditingController();
    return Container(
      width: 450,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                ref.read(isChangePasswordProvider.notifier).state = false;
              },
              icon:
                  Icon(Icons.arrow_back_rounded, size: 30, color: appPrimary)),
          Tilt(
            tiltConfig: TiltConfig(enableReverse: true),
            shadowConfig: ShadowConfig(enableReverse: true),
            lightConfig: LightConfig(enableReverse: true),
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/image/billmate_logo.png",
              height: 50,
            ),
          ),
          30.height,
          CustomTextField(
            width: 300,
            controller: currentCtrl,
            hintText: "",
            label: "Current Password",
          ),
          10.height,
          CustomTextField(
            width: 300,
            controller: newCtrl,
            hintText: "",
            label: "New Password",
          ),
          10.height,
          CustomTextField(
            width: 300,
            controller: reCtrl,
            hintText: "",
            label: "Re-enter Password",
            isPassword: true,
          ),
          10.height,
          CustomButton(
            height: 50,
            width: 300,
            text: "Save",
            buttonColor: appPrimary,
            textColor: whiteColor,
            onTap: () {},
          ),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't want to change password?  ",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
              ),
              Text(
                "Go Back",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: appPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
              ).onTap(() {
                ref.read(isChangePasswordProvider.notifier).state = false;
              }),
            ],
          )
        ],
      ),
    );
  }
}
