// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerModelImpl _$$CustomerModelImplFromJson(Map<String, dynamic> json) =>
    _$CustomerModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      group: json['group_name'] as String?,
      balanceAmount: json['balance_amount'] as String? ?? "0.0",
      modified: json['modified'] == null
          ? null
          : DateTime.parse(json['modified'] as String),
      transactionList: (json['transactionList'] as List<dynamic>?)
          ?.map((e) => AmountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CustomerModelImplToJson(_$CustomerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'group_name': instance.group,
      'balance_amount': instance.balanceAmount,
      'modified': instance.modified?.toIso8601String(),
      'transactionList': instance.transactionList,
    };

_$AmountModelImpl _$$AmountModelImplFromJson(Map<String, dynamic> json) =>
    _$AmountModelImpl(
      id: (json['id'] as num?)?.toInt(),
      customerId: (json['customer_id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String?,
      toGet: json['to_get'] as bool? ?? false,
      dateTime: json['date_time'] == null
          ? null
          : DateTime.parse(json['date_time'] as String),
    );

Map<String, dynamic> _$$AmountModelImplToJson(_$AmountModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'amount': instance.amount,
      'description': instance.description,
      'to_get': instance.toGet,
      'date_time': instance.dateTime?.toIso8601String(),
    };
