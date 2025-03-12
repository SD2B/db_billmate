import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/vm/supplier_vm.dart';
import 'package:db_billmate/vm/transaction_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SupplierListTile extends HookConsumerWidget {
  final EndUserModel model;
  final ValueNotifier<EndUserModel> supplierModel;
  const SupplierListTile({super.key, required this.model, required this.supplierModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempSupplier = ref.read(tempSupplierProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tempSupplier.state == model ? blackColor : ColorCode.colorList(context).borderColor!),
        ),
        child: ListTile(
          onTap: () async {
            if (tempSupplier.state == model) {
              tempSupplier.state = EndUserModel();
              supplierModel.value = EndUserModel();
            } else {
              tempSupplier.state = model;
              supplierModel.value = model;
              await ref.watch(transactionVMProvider.notifier).get(where: {"customer_id": model.id});
            }
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: CircleAvatar(
            backgroundColor: greyColor.shade300,
            child: Text(
              model.name!.initials,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          title: Text(
            model.name!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          trailing: Text(
            double.parse(model.balanceAmount).toStringAsFixed(2).split("-").join(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: (model.balanceAmount.toString().contains("-") || double.parse(model.balanceAmount) == 0) ? greenColor : redColor,
                ),
          ),
        ),
      ),
    );
  }
}
