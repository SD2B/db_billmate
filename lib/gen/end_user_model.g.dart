// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/end_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EndUserModelImpl _$$EndUserModelImplFromJson(Map<String, dynamic> json) =>
    _$EndUserModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      group: json['group_name'] as String?,
      balanceAmount: json['balance_amount'] as String? ?? "0.0",
      modified: json['modified'] == null
          ? null
          : DateTime.parse(json['modified'] as String),
      endUsertype: json['end_user_type'] as String? ?? EndUsertype.customer,
    );

Map<String, dynamic> _$$EndUserModelImplToJson(_$EndUserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'group_name': instance.group,
      'balance_amount': instance.balanceAmount,
      'modified': instance.modified?.toIso8601String(),
      'end_user_type': instance.endUsertype,
    };

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: (json['id'] as num?)?.toInt(),
      customerId: _$JsonConverterFromJson<String, int>(
          json['customer_id'], const IntConverter().fromJson),
      amount: json['amount'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['amount'] as String),
      description: json['description'] as String?,
      toGet: json['to_get'] == null
          ? false
          : const BoolConverter().fromJson((json['to_get'] as num).toInt()),
      dateTime: _$JsonConverterFromJson<String, DateTime>(
          json['date_time'], const DateTimeConverter().fromJson),
      transactionType:
          json['transaction_type'] as String? ?? TransactionType.normal,
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': _$JsonConverterToJson<String, int>(
          instance.customerId, const IntConverter().toJson),
      'amount': const DoubleConverter().toJson(instance.amount),
      'description': instance.description,
      'to_get': const BoolConverter().toJson(instance.toGet),
      'date_time': _$JsonConverterToJson<String, DateTime>(
          instance.dateTime, const DateTimeConverter().toJson),
      'transaction_type': instance.transactionType,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
