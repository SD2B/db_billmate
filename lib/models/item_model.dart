import 'package:db_billmate/helpers/model_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../gen/item_model.freezed.dart';
part '../gen/item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    int? id,
    @JsonKey(name: "bill_id") int? billId,
    String? barcode,
    String? name,
    String? category,
    @JsonKey(name: "sale_price") String? salePrice,
    @JsonKey(name: "purchase_price") String? purchasePrice,
    String? unit,
    String? quantity,
    @JsonKey(name: "bill_price") String? billPrice,
    @DateTimeConverter() DateTime? modified,
    @Default("0.00") @JsonKey(name: "stock_count") String? stockCount,
    @Default("0.00") @JsonKey(name: "stock_alert") String? stockAlert,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);
}

@freezed
class BillModel with _$BillModel {
  const factory BillModel({
    int? id,
    @JsonKey(name: "invoice_number") String? invoiceNumber,
    @JsonKey(name: "customer_id") int? customerId,
    @JsonKey(name: "customer_name") String? customerName,
    List<ItemModel>? items,
    String? total,
    String? ob,
    @JsonKey(name: "grand_total") String? grandTotal,
    @Default("0.00") String discount,
    @Default("0.00") String received,
    @JsonKey(name: "current_balance") String? currentBalance,
    @DateTimeConverter() @JsonKey(name: "date_time") DateTime? dateTime,
    String? note,
  }) = _BillModel;

  factory BillModel.fromJson(Map<String, dynamic> json) => _$BillModelFromJson(json);
}
