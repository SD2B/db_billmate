import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:image/image.dart' as img;

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

class UniqueIdGenerator {
  static final Random _random = Random();

  static int generateId() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int randomNumber = _random.nextInt(100000);
    return int.parse('$timestamp$randomNumber');
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

