import 'package:flutter/material.dart';

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black54,
  Offset? anchorPoint,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  bool useSafeArea = true,
  String? barrierLabel,
  TraversalEdgeBehavior? traversalEdgeBehavior,
  Function()? onClosed,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    builder: builder,
    anchorPoint: anchorPoint,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    useSafeArea: useSafeArea,
    barrierLabel: barrierLabel,
    traversalEdgeBehavior: traversalEdgeBehavior,
  ).then((value) {
    if (onClosed != null) {
      onClosed();
    }
    return value;
  });
}
