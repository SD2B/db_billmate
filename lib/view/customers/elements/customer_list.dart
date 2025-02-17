import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/transaction_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerList extends HookConsumerWidget {
  final List<CustomerModel> customerList;
  final ValueNotifier<CustomerModel> customerModel;

  const CustomerList({super.key, required this.customerList, required this.customerModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 400,
      child: ListView.builder(
        itemCount: customerList.length,
        itemBuilder: (context, index) {
          CustomerModel model = customerList[index];
          return CustomerListTile(customerModel: customerModel, model: model);
        },
      ),
    );
  }
}

class CustomerListTile extends HookConsumerWidget {
  final CustomerModel model;
  final ValueNotifier<CustomerModel> customerModel;
  const CustomerListTile({super.key, required this.model, required this.customerModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempCustomer = ref.read(tempCustomerProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tempCustomer.state == model ? blackColor : ColorCode.colorList(context).borderColor!),
        ),
        child: ListTile(
          onTap: () async {
            tempCustomer.state = model;
            customerModel.value = model;
            await ref.watch(transactionVMProvider.notifier).get(where: {"customer_id": model.id});
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
