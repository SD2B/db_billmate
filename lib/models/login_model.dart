import 'package:db_billmate/helpers/model_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../gen/login_model.freezed.dart';
part '../gen/login_model.g.dart';

@freezed
class LoginModel with _$LoginModel {
  const factory LoginModel({
    int? id,
   @BoolConverter() @Default(false) bool isLoggedIn,
    String? name,
    String? userName,
    String? address,
    String? password,
    @JsonKey(name: "modified") DateTime? modified,

  }) = _LoginModel;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}

@freezed
class PasswordModel with _$PasswordModel {
  const factory PasswordModel({
    int? id,
    String? currentPassword,
    String? newPassword,
    String? rePassword,
  }) = _PasswordModel;

  factory PasswordModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordModelFromJson(json);
}
