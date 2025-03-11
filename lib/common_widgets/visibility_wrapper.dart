import 'package:flutter/material.dart';

class SDVisibilityChecker extends StatefulWidget {
  final Widget child;
  final Function(bool isVisible) onVisibilityChanged;

  const SDVisibilityChecker({
    super.key,
    required this.child,
    required this.onVisibilityChanged,
  });

  @override
  State<SDVisibilityChecker> createState() => _SDVisibilityCheckerState();
}

class _SDVisibilityCheckerState extends State<SDVisibilityChecker> with WidgetsBindingObserver {
  final GlobalKey _key = GlobalKey();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _checkVisibility(); // Detects changes when screen size changes (e.g., rotation)
  }

  void _checkVisibility() {
    if (!mounted) return;

    final RenderObject? renderObject = _key.currentContext?.findRenderObject();
    if (renderObject is RenderBox) {
      final Offset offset = renderObject.localToGlobal(Offset.zero);
      final double widgetBottom = offset.dy + renderObject.size.height;
      final double screenHeight = MediaQuery.of(context).size.height;

      // Check if widget is inside screen bounds
      bool isVisible = offset.dy < screenHeight && widgetBottom > 0;

      if (isVisible != _isVisible) {
        setState(() {
          _isVisible = isVisible;
        });
        widget.onVisibilityChanged(_isVisible);
      }
    }

    // Continuously check visibility (useful if inside a dynamic UI)
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        _checkVisibility(); // Checks visibility when scrolling
        return false;
      },
      child: Container(
        key: _key,
        child: widget.child,
      ),
    );
  }
}
