// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../models/item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return _ItemModel.fromJson(json);
}

/// @nodoc
mixin _$ItemModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "bill_id")
  int? get billId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: "sale_price")
  String? get salePrice => throw _privateConstructorUsedError;
  @JsonKey(name: "purchase_price")
  String? get purchasePrice => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  String? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: "bill_price")
  String? get billPrice => throw _privateConstructorUsedError;

  /// Serializes this ItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemModelCopyWith<ItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemModelCopyWith<$Res> {
  factory $ItemModelCopyWith(ItemModel value, $Res Function(ItemModel) then) =
      _$ItemModelCopyWithImpl<$Res, ItemModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "bill_id") int? billId,
      String? name,
      String? category,
      @JsonKey(name: "sale_price") String? salePrice,
      @JsonKey(name: "purchase_price") String? purchasePrice,
      String? unit,
      String? quantity,
      @JsonKey(name: "bill_price") String? billPrice});
}

/// @nodoc
class _$ItemModelCopyWithImpl<$Res, $Val extends ItemModel>
    implements $ItemModelCopyWith<$Res> {
  _$ItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? billId = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? salePrice = freezed,
    Object? purchasePrice = freezed,
    Object? unit = freezed,
    Object? quantity = freezed,
    Object? billPrice = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      billId: freezed == billId
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      salePrice: freezed == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      purchasePrice: freezed == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      billPrice: freezed == billPrice
          ? _value.billPrice
          : billPrice // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemModelImplCopyWith<$Res>
    implements $ItemModelCopyWith<$Res> {
  factory _$$ItemModelImplCopyWith(
          _$ItemModelImpl value, $Res Function(_$ItemModelImpl) then) =
      __$$ItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "bill_id") int? billId,
      String? name,
      String? category,
      @JsonKey(name: "sale_price") String? salePrice,
      @JsonKey(name: "purchase_price") String? purchasePrice,
      String? unit,
      String? quantity,
      @JsonKey(name: "bill_price") String? billPrice});
}

/// @nodoc
class __$$ItemModelImplCopyWithImpl<$Res>
    extends _$ItemModelCopyWithImpl<$Res, _$ItemModelImpl>
    implements _$$ItemModelImplCopyWith<$Res> {
  __$$ItemModelImplCopyWithImpl(
      _$ItemModelImpl _value, $Res Function(_$ItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? billId = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? salePrice = freezed,
    Object? purchasePrice = freezed,
    Object? unit = freezed,
    Object? quantity = freezed,
    Object? billPrice = freezed,
  }) {
    return _then(_$ItemModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      billId: freezed == billId
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      salePrice: freezed == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      purchasePrice: freezed == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      billPrice: freezed == billPrice
          ? _value.billPrice
          : billPrice // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemModelImpl implements _ItemModel {
  const _$ItemModelImpl(
      {this.id,
      @JsonKey(name: "bill_id") this.billId,
      this.name,
      this.category,
      @JsonKey(name: "sale_price") this.salePrice,
      @JsonKey(name: "purchase_price") this.purchasePrice,
      this.unit,
      this.quantity,
      @JsonKey(name: "bill_price") this.billPrice});

  factory _$ItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: "bill_id")
  final int? billId;
  @override
  final String? name;
  @override
  final String? category;
  @override
  @JsonKey(name: "sale_price")
  final String? salePrice;
  @override
  @JsonKey(name: "purchase_price")
  final String? purchasePrice;
  @override
  final String? unit;
  @override
  final String? quantity;
  @override
  @JsonKey(name: "bill_price")
  final String? billPrice;

  @override
  String toString() {
    return 'ItemModel(id: $id, billId: $billId, name: $name, category: $category, salePrice: $salePrice, purchasePrice: $purchasePrice, unit: $unit, quantity: $quantity, billPrice: $billPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.billId, billId) || other.billId == billId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.purchasePrice, purchasePrice) ||
                other.purchasePrice == purchasePrice) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.billPrice, billPrice) ||
                other.billPrice == billPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, billId, name, category,
      salePrice, purchasePrice, unit, quantity, billPrice);

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemModelImplCopyWith<_$ItemModelImpl> get copyWith =>
      __$$ItemModelImplCopyWithImpl<_$ItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemModelImplToJson(
      this,
    );
  }
}

abstract class _ItemModel implements ItemModel {
  const factory _ItemModel(
      {final int? id,
      @JsonKey(name: "bill_id") final int? billId,
      final String? name,
      final String? category,
      @JsonKey(name: "sale_price") final String? salePrice,
      @JsonKey(name: "purchase_price") final String? purchasePrice,
      final String? unit,
      final String? quantity,
      @JsonKey(name: "bill_price") final String? billPrice}) = _$ItemModelImpl;

  factory _ItemModel.fromJson(Map<String, dynamic> json) =
      _$ItemModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: "bill_id")
  int? get billId;
  @override
  String? get name;
  @override
  String? get category;
  @override
  @JsonKey(name: "sale_price")
  String? get salePrice;
  @override
  @JsonKey(name: "purchase_price")
  String? get purchasePrice;
  @override
  String? get unit;
  @override
  String? get quantity;
  @override
  @JsonKey(name: "bill_price")
  String? get billPrice;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemModelImplCopyWith<_$ItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillModel _$BillModelFromJson(Map<String, dynamic> json) {
  return _BillModel.fromJson(json);
}

/// @nodoc
mixin _$BillModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "invoice_number")
  String? get invoiceNumber => throw _privateConstructorUsedError;
  @JsonKey(name: "customer_id")
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: "customer_name")
  String? get customerName => throw _privateConstructorUsedError;
  List<ItemModel>? get items => throw _privateConstructorUsedError;
  String? get total => throw _privateConstructorUsedError;
  String? get ob => throw _privateConstructorUsedError;
  @JsonKey(name: "grand_total")
  String? get grandTotal => throw _privateConstructorUsedError;
  String get discount => throw _privateConstructorUsedError;
  String get received => throw _privateConstructorUsedError;
  @JsonKey(name: "current_balance")
  String? get currentBalance => throw _privateConstructorUsedError;
  @DateTimeConverter()
  @JsonKey(name: "date_time")
  DateTime? get dateTime => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this BillModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillModelCopyWith<BillModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillModelCopyWith<$Res> {
  factory $BillModelCopyWith(BillModel value, $Res Function(BillModel) then) =
      _$BillModelCopyWithImpl<$Res, BillModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "invoice_number") String? invoiceNumber,
      @JsonKey(name: "customer_id") int? customerId,
      @JsonKey(name: "customer_name") String? customerName,
      List<ItemModel>? items,
      String? total,
      String? ob,
      @JsonKey(name: "grand_total") String? grandTotal,
      String discount,
      String received,
      @JsonKey(name: "current_balance") String? currentBalance,
      @DateTimeConverter() @JsonKey(name: "date_time") DateTime? dateTime,
      String? note});
}

/// @nodoc
class _$BillModelCopyWithImpl<$Res, $Val extends BillModel>
    implements $BillModelCopyWith<$Res> {
  _$BillModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? invoiceNumber = freezed,
    Object? customerId = freezed,
    Object? customerName = freezed,
    Object? items = freezed,
    Object? total = freezed,
    Object? ob = freezed,
    Object? grandTotal = freezed,
    Object? discount = null,
    Object? received = null,
    Object? currentBalance = freezed,
    Object? dateTime = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemModel>?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String?,
      ob: freezed == ob
          ? _value.ob
          : ob // ignore: cast_nullable_to_non_nullable
              as String?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as String,
      received: null == received
          ? _value.received
          : received // ignore: cast_nullable_to_non_nullable
              as String,
      currentBalance: freezed == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillModelImplCopyWith<$Res>
    implements $BillModelCopyWith<$Res> {
  factory _$$BillModelImplCopyWith(
          _$BillModelImpl value, $Res Function(_$BillModelImpl) then) =
      __$$BillModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "invoice_number") String? invoiceNumber,
      @JsonKey(name: "customer_id") int? customerId,
      @JsonKey(name: "customer_name") String? customerName,
      List<ItemModel>? items,
      String? total,
      String? ob,
      @JsonKey(name: "grand_total") String? grandTotal,
      String discount,
      String received,
      @JsonKey(name: "current_balance") String? currentBalance,
      @DateTimeConverter() @JsonKey(name: "date_time") DateTime? dateTime,
      String? note});
}

/// @nodoc
class __$$BillModelImplCopyWithImpl<$Res>
    extends _$BillModelCopyWithImpl<$Res, _$BillModelImpl>
    implements _$$BillModelImplCopyWith<$Res> {
  __$$BillModelImplCopyWithImpl(
      _$BillModelImpl _value, $Res Function(_$BillModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BillModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? invoiceNumber = freezed,
    Object? customerId = freezed,
    Object? customerName = freezed,
    Object? items = freezed,
    Object? total = freezed,
    Object? ob = freezed,
    Object? grandTotal = freezed,
    Object? discount = null,
    Object? received = null,
    Object? currentBalance = freezed,
    Object? dateTime = freezed,
    Object? note = freezed,
  }) {
    return _then(_$BillModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemModel>?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String?,
      ob: freezed == ob
          ? _value.ob
          : ob // ignore: cast_nullable_to_non_nullable
              as String?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as String,
      received: null == received
          ? _value.received
          : received // ignore: cast_nullable_to_non_nullable
              as String,
      currentBalance: freezed == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BillModelImpl implements _BillModel {
  const _$BillModelImpl(
      {this.id,
      @JsonKey(name: "invoice_number") this.invoiceNumber,
      @JsonKey(name: "customer_id") this.customerId,
      @JsonKey(name: "customer_name") this.customerName,
      final List<ItemModel>? items,
      this.total,
      this.ob,
      @JsonKey(name: "grand_total") this.grandTotal,
      this.discount = "0.00",
      this.received = "0.00",
      @JsonKey(name: "current_balance") this.currentBalance,
      @DateTimeConverter() @JsonKey(name: "date_time") this.dateTime,
      this.note})
      : _items = items;

  factory _$BillModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: "invoice_number")
  final String? invoiceNumber;
  @override
  @JsonKey(name: "customer_id")
  final int? customerId;
  @override
  @JsonKey(name: "customer_name")
  final String? customerName;
  final List<ItemModel>? _items;
  @override
  List<ItemModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? total;
  @override
  final String? ob;
  @override
  @JsonKey(name: "grand_total")
  final String? grandTotal;
  @override
  @JsonKey()
  final String discount;
  @override
  @JsonKey()
  final String received;
  @override
  @JsonKey(name: "current_balance")
  final String? currentBalance;
  @override
  @DateTimeConverter()
  @JsonKey(name: "date_time")
  final DateTime? dateTime;
  @override
  final String? note;

  @override
  String toString() {
    return 'BillModel(id: $id, invoiceNumber: $invoiceNumber, customerId: $customerId, customerName: $customerName, items: $items, total: $total, ob: $ob, grandTotal: $grandTotal, discount: $discount, received: $received, currentBalance: $currentBalance, dateTime: $dateTime, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.ob, ob) || other.ob == ob) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.received, received) ||
                other.received == received) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      invoiceNumber,
      customerId,
      customerName,
      const DeepCollectionEquality().hash(_items),
      total,
      ob,
      grandTotal,
      discount,
      received,
      currentBalance,
      dateTime,
      note);

  /// Create a copy of BillModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillModelImplCopyWith<_$BillModelImpl> get copyWith =>
      __$$BillModelImplCopyWithImpl<_$BillModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillModelImplToJson(
      this,
    );
  }
}

abstract class _BillModel implements BillModel {
  const factory _BillModel(
      {final int? id,
      @JsonKey(name: "invoice_number") final String? invoiceNumber,
      @JsonKey(name: "customer_id") final int? customerId,
      @JsonKey(name: "customer_name") final String? customerName,
      final List<ItemModel>? items,
      final String? total,
      final String? ob,
      @JsonKey(name: "grand_total") final String? grandTotal,
      final String discount,
      final String received,
      @JsonKey(name: "current_balance") final String? currentBalance,
      @DateTimeConverter() @JsonKey(name: "date_time") final DateTime? dateTime,
      final String? note}) = _$BillModelImpl;

  factory _BillModel.fromJson(Map<String, dynamic> json) =
      _$BillModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: "invoice_number")
  String? get invoiceNumber;
  @override
  @JsonKey(name: "customer_id")
  int? get customerId;
  @override
  @JsonKey(name: "customer_name")
  String? get customerName;
  @override
  List<ItemModel>? get items;
  @override
  String? get total;
  @override
  String? get ob;
  @override
  @JsonKey(name: "grand_total")
  String? get grandTotal;
  @override
  String get discount;
  @override
  String get received;
  @override
  @JsonKey(name: "current_balance")
  String? get currentBalance;
  @override
  @DateTimeConverter()
  @JsonKey(name: "date_time")
  DateTime? get dateTime;
  @override
  String? get note;

  /// Create a copy of BillModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillModelImplCopyWith<_$BillModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
