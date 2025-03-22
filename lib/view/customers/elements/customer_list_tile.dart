import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/transaction_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerListTile extends HookConsumerWidget {
  final EndUserModel model;
  final ValueNotifier<EndUserModel> customerModel;
  const CustomerListTile({super.key, required this.model, required this.customerModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCustomer = ref.read(tempCustomerProvider);

    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selectedCustomer == model ? blackColor : ColorCode.colorList(context).borderColor!),
        ),
        child: ListTile(
          onTap: () async {
            await customerListTileOnTap(ref);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: CircleAvatar(
            backgroundColor: greyColor.shade300,
            child: Text(
              (model.name ?? "Customer").initials,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          title: Text(
            model.name ?? "",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: ref.watch(customerQuickTransaction)
              ? Column(
                  children: [
                    10.height,
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        if (selectedCustomer.id != model.id) ...[
                          CustomButton(
                            width: 100,
                            text: "You Gave",
                            onTap: () async {
                              await customerListTileOnTap(ref, isQuick: true);
                            },
                            buttonColor: redColor,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor),
                          ),
                          CustomButton(
                            width: 100,
                            text: "You Gave",
                            onTap: () async {
                              await customerListTileOnTap(ref, isQuick: true);
                            },
                            buttonColor: greenColor,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor),
                          ),
                        ],
                        if (selectedCustomer.id == model.id) ...[
                          CustomTextField(
                            width: 100,
                            label: "To Get",
                            constantBorderColor: redColor,
                            controller: TextEditingController(),
                            isAmount: true,
                            inputFormatters: [DoubleOnlyFormatter()],
                            onSubmitted: (p0) async {
                              await saveQuickTransaction(p0, ref);
                            },
                          ),
                          CustomTextField(
                            width: 100,
                            label: "To Give",
                            constantBorderColor: greenColor,
                            controller: TextEditingController(),
                            isAmount: true,
                            inputFormatters: [DoubleOnlyFormatter()],
                            onSubmitted: (p0) async {
                              await saveQuickTransaction(p0, ref, isToGet: false);
                            },
                          ),
                        ]
                      ],
                    ),
                    if (selectedCustomer.id == model.id)
                      Text(
                        "Press Enter Key to add transaction",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                      )
                  ],
                )
              : null,
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

  Future<void> saveQuickTransaction(String p0, WidgetRef ref, {bool isToGet = true}) async {
    TransactionModel transactionModel = TransactionModel(
      customerId: model.id,
      amount: double.tryParse(p0) ?? 0,
      toGet: isToGet,
      description: "",
      dateTime: DateTime.now(),
      transactionType: TransactionType.normal,
    );
    qp(transactionModel);
    await ref.read(transactionVMProvider.notifier).save(transactionModel);
  }

  Future<void> customerListTileOnTap(WidgetRef ref, {bool isQuick = false}) async {
    if (isQuick) {
      ref.read(tempCustomerProvider.notifier).state = model;
      customerModel.value = model;
      await ref.watch(transactionVMProvider.notifier).get(where: {"customer_id": model.id});
    } else {
      if (ref.read(tempCustomerProvider.notifier).state == model) {
        ref.read(tempCustomerProvider.notifier).state = EndUserModel();
        customerModel.value = EndUserModel();
      } else {
        ref.read(tempCustomerProvider.notifier).state = model;
        customerModel.value = model;
        await ref.watch(transactionVMProvider.notifier).get(where: {"customer_id": model.id});
      }
    }
  }
}
