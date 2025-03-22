import 'package:db_billmate/helpers/model_helper.dart';
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
    @FunctionConverter() Function? onTap,
  }) = _UiModel;

  factory UiModel.fromJson(Map<String, dynamic> json) => _$UiModelFromJson(json);
}

@freezed
class ResponseModel with _$ResponseModel {
  const factory ResponseModel({
    int? id,
    @Default(false) bool isSuccess,
    String? statusCode,
    dynamic data,
    String? message,
  }) = _ResponseModel;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson(json);
}
