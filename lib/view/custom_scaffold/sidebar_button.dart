import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/models/ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SidebarButton extends HookWidget {
  final UiModel e;
  const SidebarButton({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouter.of(context).routeInformationProvider.value.uri;
    final isSelected = currentRoute.toString() == "/${e.value}";

    return InkWell(
        onTap: () {
          context.goNamed(e.value!);
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? whiteColor.withValues(alpha: .2) : transparentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: SvgPicture.asset(
            e.svg!,
            height: 30,
            width: 30,
          ),
        ));
  }
}
