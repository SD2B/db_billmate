import 'package:db_billmate/common_widgets/delete_popup.dart';
import 'package:db_billmate/common_widgets/loading_widget.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/view/customers/elements/transaction_popup.dart';
import 'package:db_billmate/vm/transaction_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class SupplierTransactionList extends HookConsumerWidget {
  const SupplierTransactionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: context.width() - 610,
      height: context.height() - 370,
      child: ref.watch(transactionVMProvider).when(
            data: (data) {
              final filteredList = data.reversed.toList();
              return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final transaction = filteredList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          qp(transaction);
                        },
                        onDoubleTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => DeletePopup(
                                    title: "Are you sure about deleting this transaction?",
                                    onYes: () {
                                      ref.read(transactionVMProvider.notifier).delete(transaction, isSupplier: true);
                                    },
                                  ));
                        },
                        onLongPress: () {
                          if (transaction.transactionType == TransactionType.normal) {
                            showDialog(
                                context: context,
                                builder: (context) => TransactionPopup(
                                      isSupplier: true,
                                      youGot: !transaction.toGet,
                                      amountModel: transaction,
                                      onSave: (p0) async {
                                        await ref.read(transactionVMProvider.notifier).updateTransactionModel(p0, isSupplier: true);
                                      },
                                    ));
                          }
                        },
                        child: Container(
                          width: 300,
                          height: 70,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorCode.colorList(context).borderColor!),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "📅 ${DateFormat("EEEE, MMMM dd, yyyy").format(transaction.dateTime!)}\n🕧 ${DateFormat("hh:mm aaa").format(transaction.dateTime!)}",
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
                                              color: greenColor,
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
                                              color: redColor,
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
                      ),
                    );
                  });
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => SizedBox(height: context.height() - 300, width: context.width() - 200, child: LoadingWidget()),
          ),
    );
  }
}
