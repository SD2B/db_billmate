import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
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
            return Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: ListTile(
                onTap: () {
                  customerModel.value = model;
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: customerModel.value == model ? ColorCode.colorList(context).primary! : ColorCode.colorList(context).borderColor!,
                    )),
                leading: CircleAvatar(
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
                  model.balanceAmount.toString().split("-").join(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: model.balanceAmount.toString().contains("-") ? greenColor : redColor,
                      ),
                ),
              ),
            );
          }),
    );
  }
}
