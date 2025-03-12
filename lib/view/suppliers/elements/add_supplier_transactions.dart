import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/view/customers/elements/transaction_popup.dart';
import 'package:db_billmate/vm/supplier_vm.dart';
import 'package:db_billmate/vm/transaction_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddSupplierTransactions extends HookConsumerWidget {
  const AddSupplierTransactions({
    super.key,
    required this.selected,
  });

  final ValueNotifier<int> selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempSupplier = ref.read(tempSupplierProvider.notifier);
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
                      onSave: (p0) async {
                        TransactionModel model =
                            p0.copyWith(customerId: tempSupplier.state.id);
                        qp(model);
                        await ref
                            .read(transactionVMProvider.notifier)
                            .save(model);
                      },
                    ));
          },
          buttonColor: redColor,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor),
        ),
        CircleAvatar(
            radius: 18,
            backgroundColor: black45Color,
            child: CircleAvatar(
                radius: 14,
                backgroundColor: black54Color,
                child:
                    CircleAvatar(radius: 10, backgroundColor: black87Color))),
        CustomButton(
          width: 200,
          text: "You Got",
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => TransactionPopup(
                      youGot: true,
                      onSave: (p0) async {
                        TransactionModel model =
                            p0.copyWith(customerId: tempSupplier.state.id);
                        qp(model);
                        await ref
                            .read(transactionVMProvider.notifier)
                            .save(model);
                      },
                    ));
          },
          buttonColor: greenColor,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor),
        ),
      ],
    );
  }
}
