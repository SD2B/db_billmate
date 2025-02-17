import 'dart:math';

import 'package:flutter/material.dart';

qp(dynamic data, [String? tag]) {
  final String ttag = tag != null ? tag.toString() : '';
  debugPrint("$ttag : $data");
}

extension SizedBoxExtensions on num {
  SizedBox get width => SizedBox(width: toDouble());
  SizedBox get height => SizedBox(height: toDouble());
}

extension ContextExtensions on BuildContext {
  double width() => MediaQuery.of(this).size.width;
  double height() => MediaQuery.of(this).size.height;
}

extension StringExtension on String {
  String toTitleCase() {
    return split(' ') // Split the string into words
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '') // Capitalize first letter and lowercase the rest
        .join(' '); // Join words back with spaces
  }
}

extension NameInitials on String {
  String get initials {
    final trimmed = trim();
    final parts = trimmed.split(' ');
    if (parts.length > 1) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    } else if (parts.length == 1 && parts[0].isNotEmpty) {
      return '${parts[0][0]}${parts[0].characters.last}'.toUpperCase();
    }
    return '';
  }
}

extension GestureWidgetExtension on Widget {
  /// Add tap gesture handling to a widget
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  /// Add double-tap gesture handling to a widget
  Widget onDoubleTap(VoidCallback? onDoubleTap) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: this,
    );
  }

  /// Add long-press gesture handling to a widget
  Widget onLongPress(VoidCallback? onLongPress) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: this,
    );
  }

  /// Add secondary tap gesture handling to a widget
  Widget onSecondaryTap(VoidCallback? onSecondaryTap) {
    return GestureDetector(
      onSecondaryTap: onSecondaryTap,
      child: this,
    );
  }
}

class UniqueIdGenerator {
  static final Random _random = Random();

  static int generateId() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int randomNumber = _random.nextInt(10000000);
    return int.parse('$timestamp$randomNumber');
  }
}
