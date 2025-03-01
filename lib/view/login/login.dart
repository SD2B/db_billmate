import 'package:db_billmate/common_widgets/animated_widget_switcher.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/view/login/quote_section.dart';
import 'package:db_billmate/view/login/sign_in.dart';
import 'package:db_billmate/view/login/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isChangePasswordProvider = StateProvider<bool>((ref) => false);

class Login extends HookConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChangePassword = ref.watch(isChangePasswordProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [appPrimary, appPrimary.withValues(alpha: .5), appSecondary],
        )),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: QuoteSection()),
                      AnimatedWidgetSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: isChangePassword
                            ? ChangePasswordScreen()
                            : SignIn(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
