import 'package:freezed_annotation/freezed_annotation.dart';

part '../gen/customer_model.freezed.dart';
part '../gen/customer_model.g.dart';

@freezed
class CustomerModel with _$CustomerModel {
  const factory CustomerModel({
    int? id,
    String? name,
    String? phone,
    String? address,
    String? group,
    double? balanceAmount,
    List<AmountModel>? transactionList,
  }) = _CustomerModel;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);
}

@freezed
class AmountModel with _$AmountModel {
  const factory AmountModel({
    int? id,
    @JsonKey(name: "customer_id") int? customerId,
    @Default(0.0) double amount,
    String? description,
    @JsonKey(name: "is_debit") @Default(false) bool isDebit,
    @JsonKey(name: "date_time") DateTime? dateTime,
  }) = _AmountModel;

  factory AmountModel.fromJson(Map<String, dynamic> json) => _$AmountModelFromJson(json);
}
