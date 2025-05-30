import 'package:freezed_annotation/freezed_annotation.dart';

typedef FunctionMap = Map<String, Function>;

const functionMap = <String, Function>{}; // Define globally

class FunctionConverter implements JsonConverter<Function?, String?> {
  const FunctionConverter(); // Const constructor for Freezed support

  @override
  Function? fromJson(String? json) {
    if (json == null) return null;
    return functionMap[json];
  }

  @override
  String? toJson(Function? object) {
    return functionMap.entries
        .firstWhere((entry) => entry.value == object,
            orElse: () => MapEntry('', () => {}))
        .key;
  }
}

class BoolConverter implements JsonConverter<bool, int> {
  const BoolConverter(); // Ensure this is a const constructor.

  @override
  bool fromJson(int json) => json == 1 ? true : false;

  @override
  int toJson(bool object) => object ? 1 : 0;
}

class DoubleConverter implements JsonConverter<double, String> {
  const DoubleConverter(); // Ensure this is a const constructor.

  @override
  double fromJson(String json) => double.tryParse(json) ?? 0.0;

  @override
  String toJson(double object) => object.toString();
}

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter(); // Ensure this is a const constructor.

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}

class IntConverter implements JsonConverter<int, String> {
  const IntConverter(); // Ensure this is a const constructor.

  @override
  int fromJson(String json) => int.tryParse(json) ?? 0;

  @override
  String toJson(int object) => object.toString();
}
