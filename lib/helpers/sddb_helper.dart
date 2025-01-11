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
  /// Returns the initials based on the name.
  /// - If both first and last names exist, it returns the first letters of both.
  /// - If only one name exists, it returns the first and last letters of the name.
  String get initials {
    // Trim any leading/trailing whitespace
    final trimmed = trim();

    // Split the string by spaces
    final parts = trimmed.split(' ');

    if (parts.length > 1) {
      // Return the first letter of the first and last words
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    } else if (parts.length == 1 && parts[0].isNotEmpty) {
      // Return the first and last letters of the single word
      return '${parts[0][0]}${parts[0].characters.last}'.toUpperCase();
    }

    // Return an empty string if input is invalid
    return '';
  }
}
