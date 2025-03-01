// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginModelImpl _$$LoginModelImplFromJson(Map<String, dynamic> json) =>
    _$LoginModelImpl(
      id: (json['id'] as num?)?.toInt(),
      isLoggedIn: json['isLoggedIn'] == null
          ? false
          : const BoolConverter().fromJson((json['isLoggedIn'] as num).toInt()),
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      address: json['address'] as String?,
      password: json['password'] as String?,
      modified: json['modified'] == null
          ? null
          : DateTime.parse(json['modified'] as String),
    );

Map<String, dynamic> _$$LoginModelImplToJson(_$LoginModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isLoggedIn': const BoolConverter().toJson(instance.isLoggedIn),
      'name': instance.name,
      'userName': instance.userName,
      'address': instance.address,
      'password': instance.password,
      'modified': instance.modified?.toIso8601String(),
    };

_$PasswordModelImpl _$$PasswordModelImplFromJson(Map<String, dynamic> json) =>
    _$PasswordModelImpl(
      id: (json['id'] as num?)?.toInt(),
      currentPassword: json['currentPassword'] as String?,
      newPassword: json['newPassword'] as String?,
      rePassword: json['rePassword'] as String?,
    );

Map<String, dynamic> _$$PasswordModelImplToJson(_$PasswordModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'rePassword': instance.rePassword,
    };
