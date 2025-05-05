// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemModelImpl _$$ItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemModelImpl(
      id: (json['id'] as num?)?.toInt(),
      billId: (json['bill_id'] as num?)?.toInt(),
      barcode: json['barcode'] as String?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      salePrice: json['sale_price'] as String?,
      purchasePrice: json['purchase_price'] as String?,
      unit: json['unit'] as String?,
      quantity: json['quantity'] as String?,
      billPrice: json['bill_price'] as String?,
      modified: _$JsonConverterFromJson<String, DateTime>(
          json['modified'], const DateTimeConverter().fromJson),
      stockIn: json['stock_in'] as String? ?? "0.00",
      stockOut: json['stock_out'] as String? ?? "0.00",
      stockCount: json['stock_count'] as String? ?? "0.00",
      stockAlert: json['stock_alert'] as String? ?? "0.00",
    );

Map<String, dynamic> _$$ItemModelImplToJson(_$ItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bill_id': instance.billId,
      'barcode': instance.barcode,
      'name': instance.name,
      'category': instance.category,
      'sale_price': instance.salePrice,
      'purchase_price': instance.purchasePrice,
      'unit': instance.unit,
      'quantity': instance.quantity,
      'bill_price': instance.billPrice,
      'modified': _$JsonConverterToJson<String, DateTime>(
          instance.modified, const DateTimeConverter().toJson),
      'stock_in': instance.stockIn,
      'stock_out': instance.stockOut,
      'stock_count': instance.stockCount,
      'stock_alert': instance.stockAlert,
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
      outTrnxId: (json['outTrnxId'] as num?)?.toInt(),
      inTrnxId: (json['inTrnxId'] as num?)?.toInt(),
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
      'outTrnxId': instance.outTrnxId,
      'inTrnxId': instance.inTrnxId,
    };
