import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                Tilt(
                  tiltConfig: TiltConfig(enableReverse: true),
                  shadowConfig: ShadowConfig(enableReverse: true),
                  lightConfig: LightConfig(enableReverse: true),
                  child: Image.asset(
                    "assets/image/billmate_logo.png",
                    height: 30,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
