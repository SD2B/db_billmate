// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../models/login_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) {
  return _LoginModel.fromJson(json);
}

/// @nodoc
mixin _$LoginModel {
  int? get id => throw _privateConstructorUsedError;
  @BoolConverter()
  bool get isLoggedIn => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  @JsonKey(name: "modified")
  DateTime? get modified => throw _privateConstructorUsedError;

  /// Serializes this LoginModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginModelCopyWith<LoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginModelCopyWith<$Res> {
  factory $LoginModelCopyWith(
          LoginModel value, $Res Function(LoginModel) then) =
      _$LoginModelCopyWithImpl<$Res, LoginModel>;
  @useResult
  $Res call(
      {int? id,
      @BoolConverter() bool isLoggedIn,
      String? name,
      String? userName,
      String? address,
      String? password,
      @JsonKey(name: "modified") DateTime? modified});
}

/// @nodoc
class _$LoginModelCopyWithImpl<$Res, $Val extends LoginModel>
    implements $LoginModelCopyWith<$Res> {
  _$LoginModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isLoggedIn = null,
    Object? name = freezed,
    Object? userName = freezed,
    Object? address = freezed,
    Object? password = freezed,
    Object? modified = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginModelImplCopyWith<$Res>
    implements $LoginModelCopyWith<$Res> {
  factory _$$LoginModelImplCopyWith(
          _$LoginModelImpl value, $Res Function(_$LoginModelImpl) then) =
      __$$LoginModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @BoolConverter() bool isLoggedIn,
      String? name,
      String? userName,
      String? address,
      String? password,
      @JsonKey(name: "modified") DateTime? modified});
}

/// @nodoc
class __$$LoginModelImplCopyWithImpl<$Res>
    extends _$LoginModelCopyWithImpl<$Res, _$LoginModelImpl>
    implements _$$LoginModelImplCopyWith<$Res> {
  __$$LoginModelImplCopyWithImpl(
      _$LoginModelImpl _value, $Res Function(_$LoginModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isLoggedIn = null,
    Object? name = freezed,
    Object? userName = freezed,
    Object? address = freezed,
    Object? password = freezed,
    Object? modified = freezed,
  }) {
    return _then(_$LoginModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginModelImpl implements _LoginModel {
  const _$LoginModelImpl(
      {this.id,
      @BoolConverter() this.isLoggedIn = false,
      this.name,
      this.userName,
      this.address,
      this.password,
      @JsonKey(name: "modified") this.modified});

  factory _$LoginModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey()
  @BoolConverter()
  final bool isLoggedIn;
  @override
  final String? name;
  @override
  final String? userName;
  @override
  final String? address;
  @override
  final String? password;
  @override
  @JsonKey(name: "modified")
  final DateTime? modified;

  @override
  String toString() {
    return 'LoginModel(id: $id, isLoggedIn: $isLoggedIn, name: $name, userName: $userName, address: $address, password: $password, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, isLoggedIn, name, userName, address, password, modified);

  /// Create a copy of LoginModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginModelImplCopyWith<_$LoginModelImpl> get copyWith =>
      __$$LoginModelImplCopyWithImpl<_$LoginModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginModelImplToJson(
      this,
    );
  }
}

abstract class _LoginModel implements LoginModel {
  const factory _LoginModel(
      {final int? id,
      @BoolConverter() final bool isLoggedIn,
      final String? name,
      final String? userName,
      final String? address,
      final String? password,
      @JsonKey(name: "modified") final DateTime? modified}) = _$LoginModelImpl;

  factory _LoginModel.fromJson(Map<String, dynamic> json) =
      _$LoginModelImpl.fromJson;

  @override
  int? get id;
  @override
  @BoolConverter()
  bool get isLoggedIn;
  @override
  String? get name;
  @override
  String? get userName;
  @override
  String? get address;
  @override
  String? get password;
  @override
  @JsonKey(name: "modified")
  DateTime? get modified;

  /// Create a copy of LoginModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginModelImplCopyWith<_$LoginModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PasswordModel _$PasswordModelFromJson(Map<String, dynamic> json) {
  return _PasswordModel.fromJson(json);
}

/// @nodoc
mixin _$PasswordModel {
  int? get id => throw _privateConstructorUsedError;
  String? get currentPassword => throw _privateConstructorUsedError;
  String? get newPassword => throw _privateConstructorUsedError;
  String? get rePassword => throw _privateConstructorUsedError;

  /// Serializes this PasswordModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PasswordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PasswordModelCopyWith<PasswordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordModelCopyWith<$Res> {
  factory $PasswordModelCopyWith(
          PasswordModel value, $Res Function(PasswordModel) then) =
      _$PasswordModelCopyWithImpl<$Res, PasswordModel>;
  @useResult
  $Res call(
      {int? id,
      String? currentPassword,
      String? newPassword,
      String? rePassword});
}

/// @nodoc
class _$PasswordModelCopyWithImpl<$Res, $Val extends PasswordModel>
    implements $PasswordModelCopyWith<$Res> {
  _$PasswordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PasswordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? currentPassword = freezed,
    Object? newPassword = freezed,
    Object? rePassword = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      currentPassword: freezed == currentPassword
          ? _value.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      newPassword: freezed == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      rePassword: freezed == rePassword
          ? _value.rePassword
          : rePassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PasswordModelImplCopyWith<$Res>
    implements $PasswordModelCopyWith<$Res> {
  factory _$$PasswordModelImplCopyWith(
          _$PasswordModelImpl value, $Res Function(_$PasswordModelImpl) then) =
      __$$PasswordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? currentPassword,
      String? newPassword,
      String? rePassword});
}

/// @nodoc
class __$$PasswordModelImplCopyWithImpl<$Res>
    extends _$PasswordModelCopyWithImpl<$Res, _$PasswordModelImpl>
    implements _$$PasswordModelImplCopyWith<$Res> {
  __$$PasswordModelImplCopyWithImpl(
      _$PasswordModelImpl _value, $Res Function(_$PasswordModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PasswordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? currentPassword = freezed,
    Object? newPassword = freezed,
    Object? rePassword = freezed,
  }) {
    return _then(_$PasswordModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      currentPassword: freezed == currentPassword
          ? _value.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      newPassword: freezed == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      rePassword: freezed == rePassword
          ? _value.rePassword
          : rePassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PasswordModelImpl implements _PasswordModel {
  const _$PasswordModelImpl(
      {this.id, this.currentPassword, this.newPassword, this.rePassword});

  factory _$PasswordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PasswordModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? currentPassword;
  @override
  final String? newPassword;
  @override
  final String? rePassword;

  @override
  String toString() {
    return 'PasswordModel(id: $id, currentPassword: $currentPassword, newPassword: $newPassword, rePassword: $rePassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.currentPassword, currentPassword) ||
                other.currentPassword == currentPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword) &&
            (identical(other.rePassword, rePassword) ||
                other.rePassword == rePassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, currentPassword, newPassword, rePassword);

  /// Create a copy of PasswordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordModelImplCopyWith<_$PasswordModelImpl> get copyWith =>
      __$$PasswordModelImplCopyWithImpl<_$PasswordModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PasswordModelImplToJson(
      this,
    );
  }
}

abstract class _PasswordModel implements PasswordModel {
  const factory _PasswordModel(
      {final int? id,
      final String? currentPassword,
      final String? newPassword,
      final String? rePassword}) = _$PasswordModelImpl;

  factory _PasswordModel.fromJson(Map<String, dynamic> json) =
      _$PasswordModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get currentPassword;
  @override
  String? get newPassword;
  @override
  String? get rePassword;

  /// Create a copy of PasswordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordModelImplCopyWith<_$PasswordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
