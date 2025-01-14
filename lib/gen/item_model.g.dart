// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemModelImpl _$$ItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      category: json['category'] as String?,
      salePrice: json['sale_price'] as String?,
      purchasePrice: json['purchase_price'] as String?,
      unit: json['unit'] as String?,
      quantity: json['quantity'] as String?,
    );

Map<String, dynamic> _$$ItemModelImplToJson(_$ItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'sale_price': instance.salePrice,
      'purchase_price': instance.purchasePrice,
      'unit': instance.unit,
      'quantity': instance.quantity,
    };
