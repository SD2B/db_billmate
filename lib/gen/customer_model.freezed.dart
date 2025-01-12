// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../models/customer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) {
  return _CustomerModel.fromJson(json);
}

/// @nodoc
mixin _$CustomerModel {
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
  List<AmountModel>? get transactionList => throw _privateConstructorUsedError;

  /// Serializes this CustomerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerModelCopyWith<CustomerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerModelCopyWith<$Res> {
  factory $CustomerModelCopyWith(
          CustomerModel value, $Res Function(CustomerModel) then) =
      _$CustomerModelCopyWithImpl<$Res, CustomerModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? phone,
      String? address,
      @JsonKey(name: "group_name") String? group,
      @JsonKey(name: "balance_amount") String balanceAmount,
      @JsonKey(name: "modified") DateTime? modified,
      List<AmountModel>? transactionList});
}

/// @nodoc
class _$CustomerModelCopyWithImpl<$Res, $Val extends CustomerModel>
    implements $CustomerModelCopyWith<$Res> {
  _$CustomerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerModel
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
    Object? transactionList = freezed,
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
      transactionList: freezed == transactionList
          ? _value.transactionList
          : transactionList // ignore: cast_nullable_to_non_nullable
              as List<AmountModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerModelImplCopyWith<$Res>
    implements $CustomerModelCopyWith<$Res> {
  factory _$$CustomerModelImplCopyWith(
          _$CustomerModelImpl value, $Res Function(_$CustomerModelImpl) then) =
      __$$CustomerModelImplCopyWithImpl<$Res>;
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
      List<AmountModel>? transactionList});
}

/// @nodoc
class __$$CustomerModelImplCopyWithImpl<$Res>
    extends _$CustomerModelCopyWithImpl<$Res, _$CustomerModelImpl>
    implements _$$CustomerModelImplCopyWith<$Res> {
  __$$CustomerModelImplCopyWithImpl(
      _$CustomerModelImpl _value, $Res Function(_$CustomerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomerModel
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
    Object? transactionList = freezed,
  }) {
    return _then(_$CustomerModelImpl(
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
      transactionList: freezed == transactionList
          ? _value._transactionList
          : transactionList // ignore: cast_nullable_to_non_nullable
              as List<AmountModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerModelImpl implements _CustomerModel {
  const _$CustomerModelImpl(
      {this.id,
      this.name,
      this.phone,
      this.address,
      @JsonKey(name: "group_name") this.group,
      @JsonKey(name: "balance_amount") this.balanceAmount = "0.0",
      @JsonKey(name: "modified") this.modified,
      final List<AmountModel>? transactionList})
      : _transactionList = transactionList;

  factory _$CustomerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerModelImplFromJson(json);

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
  final List<AmountModel>? _transactionList;
  @override
  List<AmountModel>? get transactionList {
    final value = _transactionList;
    if (value == null) return null;
    if (_transactionList is EqualUnmodifiableListView) return _transactionList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CustomerModel(id: $id, name: $name, phone: $phone, address: $address, group: $group, balanceAmount: $balanceAmount, modified: $modified, transactionList: $transactionList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.balanceAmount, balanceAmount) ||
                other.balanceAmount == balanceAmount) &&
            (identical(other.modified, modified) ||
                other.modified == modified) &&
            const DeepCollectionEquality()
                .equals(other._transactionList, _transactionList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      phone,
      address,
      group,
      balanceAmount,
      modified,
      const DeepCollectionEquality().hash(_transactionList));

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerModelImplCopyWith<_$CustomerModelImpl> get copyWith =>
      __$$CustomerModelImplCopyWithImpl<_$CustomerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerModelImplToJson(
      this,
    );
  }
}

abstract class _CustomerModel implements CustomerModel {
  const factory _CustomerModel(
      {final int? id,
      final String? name,
      final String? phone,
      final String? address,
      @JsonKey(name: "group_name") final String? group,
      @JsonKey(name: "balance_amount") final String balanceAmount,
      @JsonKey(name: "modified") final DateTime? modified,
      final List<AmountModel>? transactionList}) = _$CustomerModelImpl;

  factory _CustomerModel.fromJson(Map<String, dynamic> json) =
      _$CustomerModelImpl.fromJson;

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
  List<AmountModel>? get transactionList;

  /// Create a copy of CustomerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerModelImplCopyWith<_$CustomerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AmountModel _$AmountModelFromJson(Map<String, dynamic> json) {
  return _AmountModel.fromJson(json);
}

/// @nodoc
mixin _$AmountModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "customer_id")
  int? get customerId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "to_get")
  bool get toGet => throw _privateConstructorUsedError;
  @JsonKey(name: "date_time")
  DateTime? get dateTime => throw _privateConstructorUsedError;

  /// Serializes this AmountModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AmountModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmountModelCopyWith<AmountModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmountModelCopyWith<$Res> {
  factory $AmountModelCopyWith(
          AmountModel value, $Res Function(AmountModel) then) =
      _$AmountModelCopyWithImpl<$Res, AmountModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "customer_id") int? customerId,
      double amount,
      String? description,
      @JsonKey(name: "to_get") bool toGet,
      @JsonKey(name: "date_time") DateTime? dateTime});
}

/// @nodoc
class _$AmountModelCopyWithImpl<$Res, $Val extends AmountModel>
    implements $AmountModelCopyWith<$Res> {
  _$AmountModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AmountModel
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AmountModelImplCopyWith<$Res>
    implements $AmountModelCopyWith<$Res> {
  factory _$$AmountModelImplCopyWith(
          _$AmountModelImpl value, $Res Function(_$AmountModelImpl) then) =
      __$$AmountModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: "customer_id") int? customerId,
      double amount,
      String? description,
      @JsonKey(name: "to_get") bool toGet,
      @JsonKey(name: "date_time") DateTime? dateTime});
}

/// @nodoc
class __$$AmountModelImplCopyWithImpl<$Res>
    extends _$AmountModelCopyWithImpl<$Res, _$AmountModelImpl>
    implements _$$AmountModelImplCopyWith<$Res> {
  __$$AmountModelImplCopyWithImpl(
      _$AmountModelImpl _value, $Res Function(_$AmountModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AmountModel
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
  }) {
    return _then(_$AmountModelImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmountModelImpl implements _AmountModel {
  const _$AmountModelImpl(
      {this.id,
      @JsonKey(name: "customer_id") this.customerId,
      this.amount = 0.0,
      this.description,
      @JsonKey(name: "to_get") this.toGet = false,
      @JsonKey(name: "date_time") this.dateTime});

  factory _$AmountModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AmountModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: "customer_id")
  final int? customerId;
  @override
  @JsonKey()
  final double amount;
  @override
  final String? description;
  @override
  @JsonKey(name: "to_get")
  final bool toGet;
  @override
  @JsonKey(name: "date_time")
  final DateTime? dateTime;

  @override
  String toString() {
    return 'AmountModel(id: $id, customerId: $customerId, amount: $amount, description: $description, toGet: $toGet, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmountModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.toGet, toGet) || other.toGet == toGet) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, customerId, amount, description, toGet, dateTime);

  /// Create a copy of AmountModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmountModelImplCopyWith<_$AmountModelImpl> get copyWith =>
      __$$AmountModelImplCopyWithImpl<_$AmountModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmountModelImplToJson(
      this,
    );
  }
}

abstract class _AmountModel implements AmountModel {
  const factory _AmountModel(
          {final int? id,
          @JsonKey(name: "customer_id") final int? customerId,
          final double amount,
          final String? description,
          @JsonKey(name: "to_get") final bool toGet,
          @JsonKey(name: "date_time") final DateTime? dateTime}) =
      _$AmountModelImpl;

  factory _AmountModel.fromJson(Map<String, dynamic> json) =
      _$AmountModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: "customer_id")
  int? get customerId;
  @override
  double get amount;
  @override
  String? get description;
  @override
  @JsonKey(name: "to_get")
  bool get toGet;
  @override
  @JsonKey(name: "date_time")
  DateTime? get dateTime;

  /// Create a copy of AmountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmountModelImplCopyWith<_$AmountModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
