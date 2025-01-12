import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class IntegerOnlyFormatter extends TextInputFormatter {
  final int? maxDigits;

  IntegerOnlyFormatter({this.maxDigits});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp integerRegExp = RegExp(r'^[0-9]*$');

    if (!integerRegExp.hasMatch(newValue.text)) {
      return oldValue;
    }

    if (maxDigits != null && newValue.text.length > maxDigits!) {
      return oldValue;
    }

    return newValue;
  }
}


class DoubleOnlyFormatter extends TextInputFormatter {
  final int? maxDigitsBeforeDecimal;
  final int? maxDigitsAfterDecimal;

  DoubleOnlyFormatter({this.maxDigitsBeforeDecimal, this.maxDigitsAfterDecimal});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Regular expression for matching valid double values (e.g., "123", "123.45", ".45")
    final RegExp doubleRegExp = RegExp(
      r'^[0-9]*\.?[0-9]*$', 
    );

    // Check if the new value matches the double pattern
    if (!doubleRegExp.hasMatch(newValue.text)) {
      return oldValue;
    }

    // Limit the number of digits before the decimal point
    if (maxDigitsBeforeDecimal != null &&
        newValue.text.contains('.') &&
        newValue.text.split('.')[0].length > maxDigitsBeforeDecimal!) {
      return oldValue;
    }

    // Limit the number of digits after the decimal point
    if (maxDigitsAfterDecimal != null &&
        newValue.text.contains('.') &&
        newValue.text.split('.')[1].length > maxDigitsAfterDecimal!) {
      return oldValue;
    }

    return newValue;
  }
}


class CapitalizeEachWordFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Split the text by spaces, capitalize the first letter of each word, and rejoin.
    final newText = newValue.text
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');

    // Return the updated TextEditingValue, preserving the cursor position.
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
