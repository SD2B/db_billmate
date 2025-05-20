import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/common_widgets/loading_widget.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/sales/sales_report/invoice_view_pop.dart';
import 'package:db_billmate/view/sales/sales_report/sales_report_table_header.dart';
import 'package:db_billmate/view/stock/item_table_values.dart';
import 'package:db_billmate/vm/invoice_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SalesReport extends HookConsumerWidget {
  const SalesReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchType = useState(1);

    return Column(
      spacing: 10,
      children: [
        // Row(
        //   spacing: 20,
        //   children: [
        //     Container(
        //       height: 100,
        //       width: 200,
        //       decoration: BoxDecoration(
        //         border: Border.all(color: ColorCode.colorList(context).borderColor!),
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: Column(
        //         children: [
        //           Text("No.of Invoices"),
        //           Text("No.of Invoices"),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
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
                final data = rawData.toList();
                qp(data.length, "lllllllllllllllllllllllll");
                return SizedBox(
                  height: context.height() - 270,
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
