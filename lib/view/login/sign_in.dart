import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/common_widgets/sd_toast.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/login_model.dart';
import 'package:db_billmate/view/login/login.dart';
import 'package:db_billmate/vm/repositories/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

class SignIn extends HookConsumerWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Container(
      width: 450,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const SizedBox(height: 30),
            CustomTextField(
              width: 300,
              controller: usernameController,
              hintText: "Enter your username",
              label: "Username",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username is required";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              width: 300,
              controller: passwordController,
              hintText: "Enter your password",
              label: "Password",
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              height: 50,
              width: 300,
              text: "Log In",
              buttonColor: appPrimary,
              textColor: whiteColor,
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  LoginModel model = await LoginRepo.get();
                  if (usernameController.text == model.userName && passwordController.text == model.password) {
                    model = model.copyWith(isLoggedIn: true);
                    final res = await LoginRepo.update(model);
                    if (res) {
                      context.goNamed(RouteEnum.scaffold.name);
                    }
                  } else {
                    SDToast.showToast(description: "Incorrect Username or Password", type: ToastificationType.error);
                  }
                }
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Want to change password?  ",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                ),
                Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: appPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                ).onTap(() => ref.read(isChangePasswordProvider.notifier).state = true),
              ],
            )
          ],
        ),
      ),
    );
  }
}
