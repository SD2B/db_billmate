import 'package:flutter/material.dart';

class AnimatedWidgetSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const AnimatedWidgetSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: child,
    );
  }
}
