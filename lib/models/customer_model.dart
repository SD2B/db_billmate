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
    @JsonKey(name: "group_name") String? group,
    @JsonKey(name: "balance_amount")@Default("0.0") String balanceAmount,
    @JsonKey(name: "modified") DateTime? modified,
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
    @JsonKey(name: "to_get") @Default(false) bool toGet,
    @JsonKey(name: "date_time") DateTime? dateTime,
  }) = _AmountModel;

  factory AmountModel.fromJson(Map<String, dynamic> json) => _$AmountModelFromJson(json);
}
