import 'package:flutter/services.dart';

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
    final oldText = oldValue.text;
    final newText = newValue.text;

    // Capitalize each word in the new text.
    final formattedText = newText
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');

    // Calculate the new cursor position based on the difference in text length.
    final selectionOffset = newValue.selection.baseOffset +
        (formattedText.length - newText.length);

    // Return the updated TextEditingValue with the adjusted cursor position.
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: selectionOffset.clamp(0, formattedText.length),
      ),
    );
  }
}
