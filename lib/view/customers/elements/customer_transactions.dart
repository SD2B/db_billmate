import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/view/customers/elements/transaction_popup.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CustomerTransactions extends HookConsumerWidget {
  const CustomerTransactions({
    super.key,
    required this.customerModel,
  });

  final ValueNotifier<CustomerModel> customerModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          width: context.width() - 610,
          height: 50,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorCode.colorList(context).borderColor!,
          ),
          child: Row(
            children: [
              Expanded(child: Center(child: Text("Date & Time"))),
              VerticalDivider(),
              Expanded(child: Center(child: Text("You Gave"))),
              VerticalDivider(),
              Expanded(child: Center(child: Text("You Got"))),
            ],
          ),
        ),
        SizedBox(
          width: context.width() - 610,
          height: context.height() - 330,
          child: ListView.builder(
              itemCount: customerModel.value.transactionList?.length,
              itemBuilder: (context, index) {
                final transaction = customerModel.value.transactionList?[index];
                return Container(
                  width: 300,
                  height: 70,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorCode.colorList(context).borderColor!),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "📅 ${DateFormat("EEEE, MMMM dd, yyyy").format(transaction!.dateTime!)}\n🕧 ${DateFormat("hh:mm aaa").format(transaction.dateTime!)}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      )),
                      VerticalDivider(),
                      Expanded(
                          child: Center(
                        child: Text(
                          transaction.toGet ? "${transaction.amount}" : "",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: redColor,
                              ),
                        ),
                      )),
                      VerticalDivider(),
                      Expanded(
                          child: Center(
                        child: Text(
                          transaction.toGet ? "" : "${transaction.amount}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: greenColor,
                              ),
                        ),
                      )),
                    ],
                  ),
                );
              }),
        ),
        Row(
          spacing: 10,
          children: [
            CustomButton(
              width: 200,
              text: "You Gave",
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => TransactionPopup(
                          youGot: false,
                          lastId: customerModel.value.transactionList?.length ?? 0,
                          onSave: (p0) async {
                            customerModel.value = customerModel.value.copyWith(transactionList: [p0, ...customerModel.value.transactionList ?? []]);
                            await ref.read(customerVMProvider.notifier).save(customerModel.value);
                          },
                        ));
              },
              buttonColor: redColor,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor),
            ),
            CircleAvatar(radius: 18, backgroundColor: black45Color, child: CircleAvatar(radius: 14, backgroundColor: black54Color, child: CircleAvatar(radius: 10, backgroundColor: black87Color))),
            CustomButton(
              width: 200,
              text: "You Got",
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => TransactionPopup(
                          youGot: true,
                          lastId: customerModel.value.transactionList?.length ?? 0,
                          onSave: (p0) async {
                            customerModel.value = customerModel.value.copyWith(transactionList: [p0, ...customerModel.value.transactionList ?? []]);
                            await ref.read(customerVMProvider.notifier).save(customerModel.value);
                          },
                        ));
              },
              buttonColor: greenColor,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor),
            ),
          ],
        ),
      ],
    );
  }
}
