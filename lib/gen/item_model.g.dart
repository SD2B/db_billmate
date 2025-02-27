// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemModelImpl _$$ItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemModelImpl(
      id: (json['id'] as num?)?.toInt(),
      billId: (json['bill_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      category: json['category'] as String?,
      salePrice: json['sale_price'] as String?,
      purchasePrice: json['purchase_price'] as String?,
      unit: json['unit'] as String?,
      quantity: json['quantity'] as String?,
      billPrice: json['bill_price'] as String?,
    );

Map<String, dynamic> _$$ItemModelImplToJson(_$ItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bill_id': instance.billId,
      'name': instance.name,
      'category': instance.category,
      'sale_price': instance.salePrice,
      'purchase_price': instance.purchasePrice,
      'unit': instance.unit,
      'quantity': instance.quantity,
      'bill_price': instance.billPrice,
    };

_$BillModelImpl _$$BillModelImplFromJson(Map<String, dynamic> json) =>
    _$BillModelImpl(
      id: (json['id'] as num?)?.toInt(),
      invoiceNumber: json['invoice_number'] as String?,
      customerId: (json['customer_id'] as num?)?.toInt(),
      customerName: json['customer_name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as String?,
      ob: json['ob'] as String?,
      grandTotal: json['grand_total'] as String?,
      discount: json['discount'] as String? ?? "0.00",
      received: json['received'] as String? ?? "0.00",
      currentBalance: json['current_balance'] as String?,
      dateTime: _$JsonConverterFromJson<String, DateTime>(
          json['date_time'], const DateTimeConverter().fromJson),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$BillModelImplToJson(_$BillModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_number': instance.invoiceNumber,
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
      'items': instance.items,
      'total': instance.total,
      'ob': instance.ob,
      'grand_total': instance.grandTotal,
      'discount': instance.discount,
      'received': instance.received,
      'current_balance': instance.currentBalance,
      'date_time': _$JsonConverterToJson<String, DateTime>(
          instance.dateTime, const DateTimeConverter().toJson),
      'note': instance.note,
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
