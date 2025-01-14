import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/customers/elements/transaction_popup.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CustomerTransactionList extends HookConsumerWidget {
  const CustomerTransactionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempCustomer = ref.read(tempCustomerProvider.notifier);
    return SizedBox(
      width: context.width() - 610,
      height: context.height() - 370,
      child: ListView.builder(
          itemCount: tempCustomer.state.transactionList?.length,
          itemBuilder: (context, index) {
            final transaction = tempCustomer.state.transactionList?[index];
            return InkWell(
              onDoubleTap: () {
                qp(transaction.toJson());
                showDialog(
                    context: context,
                    builder: (context) => TransactionPopup(
                          youGot: !transaction.toGet,
                          lastId: tempCustomer.state.transactionList?.length ?? 0,
                          amountModel: transaction,
                          onSave: (p0) async {
                            final updatedList = tempCustomer.state.transactionList?.map((e) {
                              if (e.id == p0.id) return p0;
                              return e;
                            }).toList();
                            tempCustomer.state = tempCustomer.state.copyWith(transactionList: updatedList);
                            await ref.read(customerVMProvider.notifier).save(tempCustomer.state);
                          },
                        ));
              },
              child: Container(
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
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                    )),
                    VerticalDivider(),
                    Expanded(
                        child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (transaction.toGet)
                            Text(
                              "${transaction.amount}",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: redColor,
                                  ),
                            ),
                          if (!transaction.toGet)
                            Text(
                              transaction.description ?? "",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: ColorCode.colorList(context).primary,
                                  ),
                            ),
                        ],
                      ),
                    )),
                    VerticalDivider(),
                    Expanded(
                        child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!transaction.toGet)
                            Text(
                              transaction.toGet ? "" : "${transaction.amount}",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: greenColor,
                                  ),
                            ),
                          if (transaction.toGet)
                            Text(
                              transaction.description ?? "",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: ColorCode.colorList(context).primary,
                                  ),
                            ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
