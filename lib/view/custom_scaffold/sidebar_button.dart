import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/models/ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SidebarButton extends HookConsumerWidget {
  final UiModel e;
  const SidebarButton({super.key, required this.e});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = GoRouter.of(context).routeInformationProvider.value.uri;
    final routeName = currentRoute.toString() == "/" ? RouteEnum.home.name : currentRoute.toString().split("/").last;
    final isSelected = routeName.toString() == "${e.value}";
    final isHovered = useState(false);

    return InkWell(
        onTap: () {
          e.onTap?.call(ref);
          context.goNamed(e.value!);
        },
        onHover: (value) => isHovered.value = value,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
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
            ),
            // if (isHovered.value)
            //   Text(
            //     e.title ?? "",
            //     style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //           color: whiteColor,
            //           fontWeight: FontWeight.w700,
            //           fontSize: 10,
            //         ),
            //   )
          ],
        ));
  }
}
