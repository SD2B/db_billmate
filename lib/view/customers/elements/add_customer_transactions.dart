import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/view/customers/elements/transaction_popup.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddCustomerTransactions extends HookConsumerWidget {
  const AddCustomerTransactions({
    super.key,
    required this.selected,
  });

  final ValueNotifier<int> selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempCustomer = ref.read(tempCustomerProvider.notifier);
    return Row(
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
                      lastId: tempCustomer.state.transactionList?.length ?? 0,
                      onSave: (p0) async {
                        tempCustomer.state = tempCustomer.state.copyWith(transactionList: [p0, ...tempCustomer.state.transactionList ?? []]);
                        await ref.read(customerVMProvider.notifier).save(tempCustomer.state);
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
                      lastId: tempCustomer.state.transactionList?.length ?? 0,
                      onSave: (p0) async {
                        tempCustomer.state = tempCustomer.state.copyWith(transactionList: [p0, ...tempCustomer.state.transactionList ?? []]);
                        await ref.read(customerVMProvider.notifier).save(tempCustomer.state);
                      },
                    ));
          },
          buttonColor: greenColor,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor),
        ),
      ],
    );
  }
}
