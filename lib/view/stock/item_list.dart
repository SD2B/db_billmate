import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/common_widgets/delete_popup.dart';
import 'package:db_billmate/common_widgets/loading_widget.dart';
import 'package:db_billmate/common_widgets/sd_toast.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/stock/add_item_popup.dart';
import 'package:db_billmate/view/stock/item_table_values.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

class ItemList extends HookConsumerWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isItemNameEditing = ref.watch(itemNameEditNotifier);
    final isPurchasePriceEditing = ref.watch(purchasePriceEditNotifier);
    final isSalePriceEditing = ref.watch(salePriceEditNotifier);
    final isStockCountEditing = ref.watch(stockCountEditNotifier);
    return ref.watch(itemVMProvider).when(
        data: (data) {
          if (data.isEmpty) {
            return SizedBox(
              height: context.height() - 300,
              width: context.width() - 150,
              child: Center(
                child: Text(
                  "No data",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: black87Color),
                ),
              ),
            );
          }
          return SizedBox(
            height: context.height() - 300,
            width: context.width() - 150,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return Container(
                    height: 50,
                    width: 300,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorCode.colorList(context).borderColor!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text(
                            "${index + 1}",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
                          ),
                        ),
                        10.width,
                        VerticalDivider(color: ColorCode.colorList(context).borderColor),
                        !isItemNameEditing
                            ? ItemTableValues(flex: 2, value: "${item.name}")
                            : Expanded(
                                flex: 2,
                                child: CustomTextField(
                                  height: 40,
                                  width: 100,
                                  controller: TextEditingController(text: item.name),
                                  onSubmitted: (value) async {
                                    final res = await ref.read(itemVMProvider.notifier).save(item.copyWith(name: value));
                                    if (res.isSuccess) {
                                      SDToast.showToast(description: "Item name updated for SL.No. ${index + 1}", type: ToastificationType.success);
                                    }
                                  },
                                ),
                              ),
                        VerticalDivider(color: ColorCode.colorList(context).borderColor),
                        ItemTableValues(value: item.category ?? "__"),
                        VerticalDivider(color: ColorCode.colorList(context).borderColor),
                        SizedBox(
                          width: 50,
                          child: Text(
                            "${item.unit}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: ColorCode.colorList(context).primary),
                          ),
                        ),
                        VerticalDivider(color: ColorCode.colorList(context).borderColor),
                        !isPurchasePriceEditing
                            ? ItemTableValues(value: item.purchasePrice ?? "__")
                            : Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  height: 40,
                                  width: 100,
                                  isAmount: true,
                                  selectAllOnFocus: true,
                                  controller: TextEditingController(text: item.purchasePrice ?? ""),
                                  inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 2)],
                                  onSubmitted: (value) async {
                                    final res = await ref.read(itemVMProvider.notifier).save(item.copyWith(purchasePrice: value));
                                    if (res.isSuccess) {
                                      SDToast.showToast(description: "Purchase price updated for ${item.name}", type: ToastificationType.success);
                                    }
                                  },
                                ),
                              ),
                        VerticalDivider(color: ColorCode.colorList(context).borderColor),
                        !isSalePriceEditing
                            ? ItemTableValues(value: "${item.salePrice}")
                            : Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  height: 40,
                                  width: 100,
                                  isAmount: true,
                                  selectAllOnFocus: true,
                                  controller: TextEditingController(text: "${item.salePrice}"),
                                  inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 2)],
                                  onSubmitted: (value) async {
                                    final res = await ref.read(itemVMProvider.notifier).save(item.copyWith(salePrice: value));
                                    if (res.isSuccess) {
                                      SDToast.showToast(description: "Sale price updated for ${item.name}", type: ToastificationType.success);
                                    }
                                  },
                                ),
                              ),
                        VerticalDivider(color: ColorCode.colorList(context).borderColor),
                        ItemTableValues(value: "${item.stockIn} ${item.unit}"),
                        VerticalDivider(color: ColorCode.colorList(context).borderColor),
                        // ItemTableValues(value: "${item.stockOut} ${item.unit}"),
                        // VerticalDivider(color: ColorCode.colorList(context).borderColor),
                        ItemTableValues(value: "${item.stockCount} ${item.unit}"),
                        VerticalDivider(color: ColorCode.colorList(context).borderColor),
                        SizedBox(
                          width: 50,
                          child: PopupMenuButton(
                              color: whiteColor,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      onTap: () => showDialog(context: context, builder: (context) => AddItemPopup(updateModel: item)),
                                      child: Text(
                                        "Edit",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13, fontWeight: FontWeight.w400, color: ColorCode.colorList(context).primary),
                                      )),
                                  PopupMenuItem(
                                      onTap: () async => showDialog(
                                          context: context,
                                          builder: (context) => DeletePopup(
                                                title: "Delete item - ${item.name}?",
                                                onYes: () async => await ref.read(itemVMProvider.notifier).delete(item.id!),
                                              )),
                                      child: Text(
                                        "Delete",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13, fontWeight: FontWeight.w400, color: ColorCode.colorList(context).primary),
                                      ))
                                ];
                              }),
                        )
                      ],
                    ),
                  );
                }),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => SizedBox(height: context.height() - 300, width: context.width() - 200, child: LoadingWidget()));
  }
}
