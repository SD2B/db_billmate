import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScalingText extends HookWidget {
  final String text;
  final TextStyle? style;
  final double minScale;
  final double maxScale;
  final Duration duration;

  const ScalingText({
    super.key,
    required this.text,
    this.style,
    this.minScale = .9,
    this.maxScale = 1,
    this.duration = const Duration(seconds: 1),
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: duration,
      lowerBound: minScale,
      upperBound: maxScale,
    )..repeat(reverse: true);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.value,
          child: Text(
            text,
            style: style ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
