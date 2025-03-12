import 'package:db_billmate/helpers/model_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../gen/end_user_model.freezed.dart';
part '../gen/end_user_model.g.dart';

@freezed
class EndUserModel with _$EndUserModel {
  const factory EndUserModel({
    int? id,
    String? name,
    String? phone,
    String? address,
    @JsonKey(name: "group_name") String? group,
    @JsonKey(name: "balance_amount") @Default("0.0") String balanceAmount,
    @JsonKey(name: "modified") DateTime? modified,
    @Default(EndUsertype.customer) @JsonKey(name: "end_user_type") String endUsertype,
  }) = _EndUserModel;

  factory EndUserModel.fromJson(Map<String, dynamic> json) => _$EndUserModelFromJson(json);
}

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    int? id,
    @IntConverter() @JsonKey(name: "customer_id") int? customerId,
    @DoubleConverter() @Default(0.0) double amount,
    String? description,
    @BoolConverter() @JsonKey(name: "to_get") @Default(false) bool toGet,
    @DateTimeConverter() @JsonKey(name: "date_time") DateTime? dateTime,
    @Default(TransactionType.normal) @JsonKey(name: "transaction_type") String transactionType,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
}

class EndUsertype {
  static const String customer = "customer";
  static const String supplier = "supplier";
}

class TransactionType {
  static const String sale = "sale";
  static const String normal = "normal";
}
