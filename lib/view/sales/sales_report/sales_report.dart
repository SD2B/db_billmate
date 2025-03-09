import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/common_widgets/header_label.dart';
import 'package:db_billmate/common_widgets/loading_widget.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/print_helper.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/view/sales/bill_items_header.dart';
import 'package:db_billmate/view/sales/label_text.dart';
import 'package:db_billmate/view/sales/sales.dart';
import 'package:db_billmate/view/sales/sales_report/sales_report_table_header.dart';
import 'package:db_billmate/view/stock/item_table_values.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/invoice_vm.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class SalesReport extends HookConsumerWidget {
  const SalesReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchType = useState(1);

    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 20,
          children: [
            Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: ColorCode.colorList(context).borderColor!),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("No.of Invoices"),
                  Text("No.of Invoices"),
                ],
              ),
            )
          ],
        ),
        Row(
          spacing: 10,
          children: [
            CustomTextField(
              width: 400,
              height: 45,
              controller: searchController,
              hintText: "Search...",
              onChanged: (p0) async {
                if (searchType.value == 1) {
                  await ref.read(invoiceVMProvider.notifier).get(search: {"invoice_number": p0});
                } else {
                  await ref.read(invoiceVMProvider.notifier).get(search: {"customer_name": p0});
                }
              },
              prefix: PopupMenuButton(
                  color: whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButtonCard(
                      width: 150,
                      height: 50,
                      text: searchType.value == 1 ? "Invoice Number" : "Customer Name",
                      buttonColor: appPrimary,
                      textColor: whiteColor,
                    ),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(child: Text("Invoice Number"), onTap: () => searchType.value = 1),
                      PopupMenuItem(child: Text("Customer Name"), onTap: () => searchType.value = 2),
                    ];
                  }),
            ),
            CustomIconButton(
              buttonSize: 45,
              icon: Icons.tune_rounded,
              shape: BoxShape.rectangle,
              onTap: () {},
            ),
            CustomIconButton(
              buttonSize: 45,
              icon: Icons.refresh_rounded,
              shape: BoxShape.rectangle,
              onTap: () async => await ref.read(invoiceVMProvider.notifier).get(),
            ),
          ],
        ),
        SalesReportTableHeader(),
        ref.watch(invoiceVMProvider).when(
              data: (rawData) {
                final data = rawData.reversed.toList();
                qp(data.length, "lllllllllllllllllllllllll");
                return SizedBox(
                  height: context.height() - 380,
                  width: context.width() - 150,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final invoice = data[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () {
                              showDialog(context: context, builder: (context) => InvoiceViewPop(model: invoice));
                            },
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
                                  ItemTableValues(flex: 2, value: "${invoice.customerName}"),
                                  VerticalDivider(color: ColorCode.colorList(context).borderColor),
                                  ItemTableValues(value: "${invoice.invoiceNumber}"),
                                  VerticalDivider(color: ColorCode.colorList(context).borderColor),
                                  ItemTableValues(value: "${invoice.total}"),
                                  VerticalDivider(color: ColorCode.colorList(context).borderColor),
                                  ItemTableValues(value: "${invoice.ob}"),
                                  VerticalDivider(color: ColorCode.colorList(context).borderColor),
                                  ItemTableValues(value: "${invoice.grandTotal}"),
                                  VerticalDivider(color: ColorCode.colorList(context).borderColor),
                                  ItemTableValues(value: invoice.discount),
                                  VerticalDivider(color: ColorCode.colorList(context).borderColor),
                                  ItemTableValues(value: invoice.received),
                                  VerticalDivider(color: ColorCode.colorList(context).borderColor),
                                  ItemTableValues(value: "${invoice.currentBalance}"),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              },
              error: (e, stackTrace) => Text(e.toString()),
              loading: () => LoadingWidget(),
            ),
      ],
    );
  }
}

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
            Container(
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
                          ref.read(billCustomerProvider.notifier).state = CustomerModel(id: model.customerId, name: model.customerName, balanceAmount: model.ob ?? "0.00");
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: whiteColor,
                                    contentPadding: EdgeInsets.all(30),
                                    content: Sales(updateBillModel: model),
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
