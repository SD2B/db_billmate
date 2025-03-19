import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/custom_scaffold/custom_appbar.dart';
import 'package:db_billmate/view/custom_scaffold/custom_sidebar.dart';
import 'package:db_billmate/view/custom_scaffold/scaffold_body.dart';
import 'package:db_billmate/view/custom_scaffold/scaffold_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomScaffold extends HookConsumerWidget {
  final Widget child;
  const CustomScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardListener(
      focusNode: useMemoized(() => FocusNode(), []),
      autofocus: true,
      onKeyEvent: (KeyEvent event) {
        bool alt = HardwareKeyboard.instance.isAltPressed;
        bool s = HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.keyS);
        bool a = HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.keyA);

        if (alt && s) {
          qp("Alt + S Pressed!");
          context.goNamed(RouteEnum.sales.name);
        }
        if (alt && a) {
          qp("Alt + A Pressed!");
          context.goNamed(RouteEnum.customers.name);
        }
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CustomSidebar(),
              SizedBox(
                width: context.width() - 100,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      CustomAppbar(),
                      10.height,
                      ScaffoldBody(child: child),
                      ScaffoldFooter(),
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
