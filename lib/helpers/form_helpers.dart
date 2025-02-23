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
  final bool onlyFirstLetter;

  CapitalizeEachWordFormatter({this.onlyFirstLetter = false});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    String formattedText;
    if (onlyFirstLetter) {
      // Capitalize only the first letter of the entire text
      formattedText = newText.isNotEmpty
          ? newText[0].toUpperCase() + newText.substring(1)
          : '';
    } else {
      // Capitalize the first letter of each word
      formattedText = newText
          .split(' ')
          .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
          .join(' ');
    }

    // Adjust cursor position
    final selectionOffset = newValue.selection.baseOffset +
        (formattedText.length - newText.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: selectionOffset.clamp(0, formattedText.length),
      ),
    );
  }
}
