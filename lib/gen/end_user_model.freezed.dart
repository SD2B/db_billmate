// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../models/end_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EndUserModel _$EndUserModelFromJson(Map<String, dynamic> json) {
  return _EndUserModel.fromJson(json);
}

/// @nodoc
mixin _$EndUserModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: "group_name")
  String? get group => throw _privateConstructorUsedError;
  @JsonKey(name: "balance_amount")
  String get balanceAmount => throw _privateConstructorUsedError;
  @JsonKey(name: "modified")
  DateTime? get modified => throw _privateConstructorUsedError;
  @JsonKey(name: "end_user_type")
  String get endUsertype => throw _privateConstructorUsedError;

  /// Serializes this EndUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EndUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EndUserModelCopyWith<EndUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EndUserModelCopyWith<$Res> {
  factory $EndUserModelCopyWith(
          EndUserModel value, $Res Function(EndUserModel) then) =
      _$EndUserModelCopyWithImpl<$Res, EndUserModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? phone,
      String? address,
      @JsonKey(name: "group_name") String? group,
      @JsonKey(name: "balance_amount") String balanceAmount,
      @JsonKey(name: "modified") DateTime? modified,
      @JsonKey(name: "end_user_type") String endUsertype});
}

/// @nodoc
class _$EndUserModelCopyWithImpl<$Res, $Val extends EndUserModel>
    implements $EndUserModelCopyWith<$Res> {
  _$EndUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EndUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? group = freezed,
    Object? balanceAmount = null,
    Object? modified = freezed,
    Object? endUsertype = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      balanceAmount: null == balanceAmount
          ? _value.balanceAmount
          : balanceAmount // ignore: cast_nullable_to_non_nullable
              as String,
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endUsertype: null == endUsertype
          ? _value.endUsertype
          : endUsertype // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EndUserModelImplCopyWith<$Res>
    implements $EndUserModelCopyWith<$Res> {
  factory _$$EndUserModelImplCopyWith(
          _$EndUserModelImpl value, $Res Function(_$EndUserModelImpl) then) =
      __$$EndUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? phone,
      String? address,
      @JsonKey(name: "group_name") String? group,
      @JsonKey(name: "balance_amount") String balanceAmount,
      @JsonKey(name: "modified") DateTime? modified,
      @JsonKey(name: "end_user_type") String endUsertype});
}

/// @nodoc
class __$$EndUserModelImplCopyWithImpl<$Res>
    extends _$EndUserModelCopyWithImpl<$Res, _$EndUserModelImpl>
    implements _$$EndUserModelImplCopyWith<$Res> {
  __$$EndUserModelImplCopyWithImpl(
      _$EndUserModelImpl _value, $Res Function(_$EndUserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EndUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? group = freezed,
    Object? balanceAmount = null,
    Object? modified = freezed,
    Object? endUsertype = null,
  }) {
    return _then(_$EndUserModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      balanceAmount: null == balanceAmount
          ? _value.balanceAmount
          : balanceAmount // ignore: cast_nullable_to_non_nullable
              as String,
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endUsertype: null == endUsertype
          ? _value.endUsertype
          : endUsertype // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EndUserModelImpl implements _EndUserModel {
  const _$EndUserModelImpl(
      {this.id,
      this.name,
      this.phone,
      this.address,
      @JsonKey(name: "group_name") this.group,
      @JsonKey(name: "balance_amount") this.balanceAmount = "0.0",
      @JsonKey(name: "modified") this.modified,
      @JsonKey(name: "end_user_type") this.endUsertype = EndUsertype.customer});

  factory _$EndUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EndUserModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final String? address;
  @override
  @JsonKey(name: "group_name")
  final String? group;
  @override
  @JsonKey(name: "balance_amount")
  final String balanceAmount;
  @override
  @JsonKey(name: "modified")
  final DateTime? modified;
  @override
  @JsonKey(name: "end_user_type")
  final String endUsertype;

  @override
  String toString() {
    return 'EndUserModel(id: $id, name: $name, phone: $phone, address: $address, group: $group, balanceAmount: $balanceAmount, modified: $modified, endUsertype: $endUsertype)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EndUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.balanceAmount, balanceAmount) ||
                other.balanceAmount == balanceAmount) &&
            (identical(other.modified, modified) ||
                other.modified == modified) &&
            (identical(other.endUsertype, endUsertype) ||
                other.endUsertype == endUsertype));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, address, group,
      balanceAmount, modified, endUsertype);

  /// Create a copy of EndUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EndUserModelImplCopyWith<_$EndUserModelImpl> get copyWith =>
      __$$EndUserModelImplCopyWithImpl<_$EndUserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EndUserModelImplToJson(
      this,
    );
  }
}

abstract class _EndUserModel implements EndUserModel {
  const factory _EndUserModel(
          {final int? id,
          final String? name,
          final String? phone,
          final String? address,
          @JsonKey(name: "group_name") final String? group,
          @JsonKey(name: "balance_amount") final String balanceAmount,
          @JsonKey(name: "modified") final DateTime? modified,
          @JsonKey(name: "end_user_type") final String endUsertype}) =
      _$EndUserModelImpl;

  factory _EndUserModel.fromJson(Map<String, dynamic> json) =
      _$EndUserModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  String? get address;
  @override
  @JsonKey(name: "group_name")
  String? get group;
  @override
  @JsonKey(name: "balance_amount")
  String get balanceAmount;
  @override
  @JsonKey(name: "modified")
  DateTime? get modified;
  @override
  @JsonKey(name: "end_user_type")
  String get endUsertype;

  /// Create a copy of EndUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EndUserModelImplCopyWith<_$EndUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  int? get id => throw _privateConstructorUsedError;
  @IntConverter()
  @JsonKey(name: "customer_id")
  int? get customerId => throw _privateConstructorUsedError;
  @DoubleConverter()
  double get amount => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @BoolConverter()
  @JsonKey(name: "to_get")
  bool get toGet => throw _privateConstructorUsedError;
  @DateTimeConverter()
  @JsonKey(name: "date_time")
  DateTime? get dateTime => throw _privateConstructorUsedError;
  @JsonKey(name: "transaction_type")
  String get transactionType => throw _privateConstructorUsedError;

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {int? id,
      @IntConverter() @JsonKey(name: "customer_id") int? customerId,
      @DoubleConverter() double amount,
      String? description,
      @BoolConverter() @JsonKey(name: "to_get") bool toGet,
      @DateTimeConverter() @JsonKey(name: "date_time") DateTime? dateTime,
      @JsonKey(name: "transaction_type") String transactionType});
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? amount = null,
    Object? description = freezed,
    Object? toGet = null,
    Object? dateTime = freezed,
    Object? transactionType = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      toGet: null == toGet
          ? _value.toGet
          : toGet // ignore: cast_nullable_to_non_nullable
              as bool,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(_$TransactionModelImpl value,
          $Res Function(_$TransactionModelImpl) then) =
      __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @IntConverter() @JsonKey(name: "customer_id") int? customerId,
      @DoubleConverter() double amount,
      String? description,
      @BoolConverter() @JsonKey(name: "to_get") bool toGet,
      @DateTimeConverter() @JsonKey(name: "date_time") DateTime? dateTime,
      @JsonKey(name: "transaction_type") String transactionType});
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(_$TransactionModelImpl _value,
      $Res Function(_$TransactionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? amount = null,
    Object? description = freezed,
    Object? toGet = null,
    Object? dateTime = freezed,
    Object? transactionType = null,
  }) {
    return _then(_$TransactionModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      toGet: null == toGet
          ? _value.toGet
          : toGet // ignore: cast_nullable_to_non_nullable
              as bool,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl implements _TransactionModel {
  const _$TransactionModelImpl(
      {this.id,
      @IntConverter() @JsonKey(name: "customer_id") this.customerId,
      @DoubleConverter() this.amount = 0.0,
      this.description,
      @BoolConverter() @JsonKey(name: "to_get") this.toGet = false,
      @DateTimeConverter() @JsonKey(name: "date_time") this.dateTime,
      @JsonKey(name: "transaction_type")
      this.transactionType = TransactionType.normal});

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  final int? id;
  @override
  @IntConverter()
  @JsonKey(name: "customer_id")
  final int? customerId;
  @override
  @JsonKey()
  @DoubleConverter()
  final double amount;
  @override
  final String? description;
  @override
  @BoolConverter()
  @JsonKey(name: "to_get")
  final bool toGet;
  @override
  @DateTimeConverter()
  @JsonKey(name: "date_time")
  final DateTime? dateTime;
  @override
  @JsonKey(name: "transaction_type")
  final String transactionType;

  @override
  String toString() {
    return 'TransactionModel(id: $id, customerId: $customerId, amount: $amount, description: $description, toGet: $toGet, dateTime: $dateTime, transactionType: $transactionType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.toGet, toGet) || other.toGet == toGet) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, customerId, amount,
      description, toGet, dateTime, transactionType);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(
      this,
    );
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel(
      {final int? id,
      @IntConverter() @JsonKey(name: "customer_id") final int? customerId,
      @DoubleConverter() final double amount,
      final String? description,
      @BoolConverter() @JsonKey(name: "to_get") final bool toGet,
      @DateTimeConverter() @JsonKey(name: "date_time") final DateTime? dateTime,
      @JsonKey(name: "transaction_type")
      final String transactionType}) = _$TransactionModelImpl;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  int? get id;
  @override
  @IntConverter()
  @JsonKey(name: "customer_id")
  int? get customerId;
  @override
  @DoubleConverter()
  double get amount;
  @override
  String? get description;
  @override
  @BoolConverter()
  @JsonKey(name: "to_get")
  bool get toGet;
  @override
  @DateTimeConverter()
  @JsonKey(name: "date_time")
  DateTime? get dateTime;
  @override
  @JsonKey(name: "transaction_type")
  String get transactionType;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
