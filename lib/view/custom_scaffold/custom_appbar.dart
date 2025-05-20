import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/print_helper/print_helper.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = GoRouter.of(context).routeInformationProvider.value.uri;
    final routeName = currentRoute.toString() == "/" ? RouteEnum.home.name : currentRoute.toString().split("/").last;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(),
            padding: EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  routeName.toString().routeToTitleCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: blackColor,
                      ),
                ),
                Spacer(),
                CustomIconButton(
                  tooltipMsg: ref.watch(printerProvider).url == "" ? "Select Printer" : "Current printer is ${ref.watch(printerProvider).url}",
                  buttonSize: 50,
                  icon: Icons.print,
                  shape: BoxShape.rectangle,
                  buttonColor: appPrimary,
                  iconColor: whiteColor,
                  badge: ref.watch(printerProvider).url == ""
                      ? CircleAvatar(
                          radius: 10,
                          backgroundColor: redColor,
                          child: Icon(
                            Icons.close_rounded,
                            color: whiteColor,
                            size: 15,
                          ))
                      : Icon(
                          Icons.check_circle,
                          color: greenColor,
                        ),
                  onTap: () {
                    PrintHelper.printerPop(context, ref);
                  },
                ),
                10.width,
                Tilt(
                  tiltConfig: TiltConfig(enableReverse: true),
                  shadowConfig: ShadowConfig(enableReverse: true),
                  lightConfig: LightConfig(enableReverse: true),
                  child: Container(
                    decoration: BoxDecoration(
                      color: appPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/image/dbbm_logo.png",
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
