import 'package:freezed_annotation/freezed_annotation.dart';
part '../gen/item_model.freezed.dart';
part '../gen/item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    int? id,
    String? name,
    String? category,
    @JsonKey(name: "sale_price") String? salePrice,
    @JsonKey(name: "purchase_price") String? purchasePrice,
    String? unit,
    String? quantity,
    @JsonKey(name: "bill_price") String? billPrice,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);
}
