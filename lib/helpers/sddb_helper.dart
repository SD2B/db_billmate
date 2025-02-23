import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
        .map((word) => word.isNotEmpty && word[0].contains(RegExp(r'[a-zA-Z]')) 
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' 
            : word) // Keep numbers/special chars unchanged
        .join(' '); // Rejoin words with a single space
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
    int randomNumber = _random.nextInt(10000000);
    return int.parse('$timestamp$randomNumber');
  }
}

Future<void> shareDatabase() async {
  try {
    // Get the database path
    final dbPath = await getDatabasesPath();
    final dbFile = File(join(dbPath, 'local_storage.db'));

    // Check if the database file exists
    if (await dbFile.exists()) {
      // Share the database file via WhatsApp
      await Share.shareXFiles([XFile(dbFile.path)], text: 'Here is the database file.');
    } else {
      qp("Database file does not exist.");
    }
  } catch (e) {
    qp('Error sharing database: $e');
  }
}

