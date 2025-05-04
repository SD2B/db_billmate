import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/header_label.dart';
import 'package:db_billmate/common_widgets/show_custom_dialog.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/print_helper/print_helper.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/view/sales/bill_items_header.dart';
import 'package:db_billmate/view/sales/label_text.dart';
import 'package:db_billmate/view/sales/sales.dart';
import 'package:db_billmate/view/sales/sales_report/invoice_view_share_pop.dart';
import 'package:db_billmate/view/stock/item_table_values.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class InvoiceViewPop extends HookConsumerWidget {
  final BillModel model;
  const InvoiceViewPop({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: whiteColor,
      content: Container(
        height: 500,
        // width: 500,
        decoration: BoxDecoration(
          border: Border.all(color: appSecondary),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              // color: redAccentColor,
              height: 80,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      LabelText(label: "Invoice Number", text: "${model.invoiceNumber}", textSize: 20),
                      LabelText(label: "Customer Name", text: "${model.customerName}", textSize: 20),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 10,
                    children: [
                      HeaderLabel(header: "📅 ${DateFormat("EEEE, MMMM dd, yyyy").format(model.dateTime ?? DateTime.now()).toString()}", headFontSize: 15),
                      HeaderLabel(header: "🕧 ${DateFormat("hh:mm aaa").format(model.dateTime ?? DateTime.now()).toString()}", headFontSize: 15),
                    ],
                  )
                ],
              ),
            ),
            10.height,
            BillItemsHeader(isView: true),
            10.height,
            Expanded(
              child: SizedBox(
                // height: context.height() - 550,
                width: context.width() - 150,
                child: ListView.builder(
                    itemCount: model.items?.length,
                    itemBuilder: (context, index) {
                      ItemModel item = model.items?[index] ?? ItemModel();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 50,
                          width: 300,
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
                              ItemTableValues(flex: 2, value: "${item.name}"),
                              VerticalDivider(color: ColorCode.colorList(context).borderColor),
                              ItemTableValues(value: "${item.quantity}"),
                              VerticalDivider(color: ColorCode.colorList(context).borderColor),
                              SizedBox(
                                width: 30,
                                child: Text(
                                  "${item.unit}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: ColorCode.colorList(context).primary),
                                ),
                              ),
                              VerticalDivider(color: ColorCode.colorList(context).borderColor),
                              ItemTableValues(value: "${item.salePrice}"),
                              VerticalDivider(color: ColorCode.colorList(context).borderColor),
                              ItemTableValues(value: "${item.billPrice}"),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            10.height,
            SizedBox(
              // height: 80,
              child: Column(
                spacing: 10,
                children: [
                  Divider(color: appSecondary),
                  Row(
                    spacing: 50,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (model.note?.isEmpty == false) LabelText(label: "Note:", text: "${model.note}", textSize: 12),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 10,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelText(
                            labelAreaSizeSize: 100,
                            textAreaSizeSize: 100,
                            label: "Total",
                            text: (double.tryParse(model.total ?? "0.00") ?? 0.00).toStringAsFixed(2),
                          ),
                          LabelText(
                            labelAreaSizeSize: 100,
                            textAreaSizeSize: 100,
                            label: "Old Balance",
                            text: (double.tryParse(model.ob ?? "0.00") ?? 0.00).toStringAsFixed(2),
                          ),
                          LabelText(
                            labelAreaSizeSize: 100,
                            textAreaSizeSize: 100,
                            label: "Grand Total",
                            text: (double.tryParse(model.grandTotal ?? "0.00") ?? 0.00).toStringAsFixed(2),
                          ),
                        ],
                      ),
                      10.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelText(
                            labelAreaSizeSize: 100,
                            textAreaSizeSize: 100,
                            label: "Discount",
                            text: (double.tryParse(model.discount) ?? 0.00).toStringAsFixed(2),
                          ),
                          LabelText(
                            labelAreaSizeSize: 100,
                            textAreaSizeSize: 100,
                            label: "Received",
                            text: (double.tryParse(model.received) ?? 0.00).toStringAsFixed(2),
                          ),
                          LabelText(
                            labelAreaSizeSize: 100,
                            textAreaSizeSize: 100,
                            label: "Current Balance",
                            text: (double.tryParse(model.currentBalance ?? "0.00") ?? 0.00).toStringAsFixed(2),
                          ),
                        ],
                      ),
                      10.width,
                      CustomButton(
                        text: "Edit",
                        onTap: () {
                          ref.read(tempItemListProvider.notifier).state = model.items ?? [];
                          ref.read(billCustomerProvider.notifier).state = EndUserModel(id: model.customerId, name: model.customerName, balanceAmount: model.ob ?? "0.00");
                          showCustomDialog(
                              context: context,
                              onClosed: () {
                                ref.read(tempItemListProvider.notifier).state = [];
                                ref.read(billCustomerProvider.notifier).state = EndUserModel();
                              },
                              builder: (context) => AlertDialog(
                                    backgroundColor: whiteColor,
                                    contentPadding: EdgeInsets.all(30),
                                    content: Sales(updateBillModel: model, isUpdate: true),
                                  ));
                        },
                        buttonColor: appPrimary,
                        textColor: whiteColor,
                        height: 50,
                        width: 100,
                      ),
                      CustomButton(
                        text: "Print",
                        onTap: () => PrintHelper.printInvoice(context, ref, model),
                        buttonColor: appSecondary,
                        textColor: blackColor,
                        height: 50,
                        width: 100,
                      ),
                      CustomButton(
                        disable: true,
                        disableMessage: "This feature is not available yet",
                        text: "Share",
                        onTap: () {
                          showCustomDialog(context: context, builder: (context) => InvoiceViewSharePop(model: model));
                        },
                        buttonColor: appSecondary,
                        textColor: blackColor,
                        height: 50,
                        width: 100,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
