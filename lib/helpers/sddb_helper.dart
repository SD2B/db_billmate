import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

qp(dynamic data, [String? tag]) {
  if (kDebugMode) {
    final String ttag = tag != null ? tag.toString() : '';
    debugPrint("$ttag : $data");
  }
}

extension SizedBoxExtensions on num {
  SizedBox get width => SizedBox(width: toDouble());
  SizedBox get height => SizedBox(height: toDouble());
}

extension ContextExtensions on BuildContext {
  double width() => MediaQuery.of(this).size.width;
  double height() => MediaQuery.of(this).size.height;
}

extension NegativeDouble on double {
  double toNegative() => this > 0 ? -this : this;
}

extension ShortNumberFormat on double {
  String toShortForm({int minDigits = 4}) {
    String valueStr = toStringAsFixed(0); // Convert to string without decimals
    if (valueStr.length < minDigits) {
      return valueStr; // Return original value if it doesn't exceed minDigits
    }

    if (this >= 1e9) {
      return '${(this / 1e9).toStringAsFixed(1)}B'; // Billion
    } else if (this >= 1e6) {
      return '${(this / 1e6).toStringAsFixed(1)}M'; // Million
    } else if (this >= 1e3) {
      return '${(this / 1e3).toStringAsFixed(1)}K'; // Thousand
    } else {
      return valueStr;
    }
  }
}

extension StringExtension on String {
  String toTitleCase() {
    return trim() // Remove leading/trailing spaces
        .split(RegExp(r'\s+')) // Split on multiple spaces
        .map((word) => word.isNotEmpty && word[0].contains(RegExp(r'[a-zA-Z]')) ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : word) // Keep numbers/special chars unchanged
        .join(' '); // Rejoin words with a single space
  }

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

  String routeToTitleCase() {
    return splitMapJoin(RegExp(r'([a-z])([A-Z])'), onMatch: (m) => '${m[1]} ${m[2]}', onNonMatch: (n) => n.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) => '${match.group(1)} ${match.group(2)}'))
        .replaceAll('_', ' ') // Replace underscores with spaces
        .split(' ') // Split words
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' '); // Capitalize first letter of each word
  }
}

extension GestureWidgetExtension on Widget {
  /// Add tap gesture handling to a widget
  Widget onTap(VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: this,
    );
  }

  /// Add double-tap gesture handling to a widget
  Widget onDoubleTap(VoidCallback? onDoubleTap) {
    return InkWell(
      onDoubleTap: onDoubleTap,
      child: this,
    );
  }

  /// Add long-press gesture handling to a widget
  Widget onLongPress(VoidCallback? onLongPress) {
    return InkWell(
      onLongPress: onLongPress,
      child: this,
    );
  }

  /// Add secondary tap gesture handling to a widget
  Widget onSecondaryTap(VoidCallback? onSecondaryTap) {
    return InkWell(
      onSecondaryTap: onSecondaryTap,
      child: this,
    );
  }
}

DateTime updateDateTimeWithDate(DateTime originalDateTime, DateTime newDate) {
  return DateTime(newDate.year, newDate.month, newDate.day, originalDateTime.hour, originalDateTime.minute, originalDateTime.second, originalDateTime.millisecond, originalDateTime.microsecond);
}

DateTime updateDateTimeWithTime(DateTime date, TimeOfDay time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

TimeOfDay extractTimeFromDateTime(DateTime dateTime) {
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

bool checkIfTimeEmpty(DateTime? dateTime) {
  if (dateTime != null) {
    return dateTime.hour == 0 && dateTime.minute == 0 && dateTime.second == 0;
  } else {
    return true;
  }
}

class UniqueIdGenerator {
  static final Random _random = Random();

  static int generateId({bool reverse = false}) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int randomNumber = _random.nextInt(100000);

    String idString = reverse ? '$randomNumber$timestamp' : '$timestamp$randomNumber';

    return int.parse(idString);
  }
}

Future<File> bytesToImageFile(Uint8List bytes) async {
  // Get the temporary directory
  String fileName = "Reminder${UniqueIdGenerator.generateId()}";
  Directory tempDir = await getTemporaryDirectory();
  String filePath = '${tempDir.path}/$fileName.jpg';

  // Create the file
  File file = File(filePath);

  // Write bytes to the file
  await file.writeAsBytes(bytes);

  return file;
}
