import 'package:freezed_annotation/freezed_annotation.dart';
part '../gen/ui_model.freezed.dart';
part '../gen/ui_model.g.dart';

@freezed
class UiModel with _$UiModel {
  const factory UiModel({
    int? id,
    String? title,
    String? subTitle,
    String? description,
    String? value,
    String? count,
    String? svg,
    List<String>? valueList,
    List<String>? labelList,
  }) = _UiModel;

  factory UiModel.fromJson(Map<String, dynamic> json) => _$UiModelFromJson(json);
}
