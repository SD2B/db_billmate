import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/customers/add_customer_popup.dart';
import 'package:db_billmate/view/customers/elements/account_close_popup.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/transaction_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerTransactionHeader extends HookConsumerWidget {
  const CustomerTransactionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempCustomer = ref.read(tempCustomerProvider.notifier);
    return Container(
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
          CircleAvatar(
            backgroundColor: whiteColor,
            child: Text(
              "${tempCustomer.state.name?.initials}",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: black87Color),
            ),
          ),
          VerticalDivider(),
          Text(
            "${tempCustomer.state.name}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ColorCode.colorList(context).primary,
                ),
          ),
          VerticalDivider(),
          Text( 
            double.parse(tempCustomer.state.balanceAmount).toStringAsFixed(2).split("-").join(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: (tempCustomer.state.balanceAmount.contains("-") || double.parse(tempCustomer.state.balanceAmount) == 0) ? greenColor : redColor,
                ),
          ),
          Spacer(),
          VerticalDivider(),
          CustomButton(
              width: 100,
              height: 45,
              buttonColor: black87Color,
              textColor: whiteColor,
              text: "Edit Account",
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AddCustomerPopup(
                          updateModel: tempCustomer.state,
                        ));
              }),
          VerticalDivider(),
          CustomButton(
              width: 100,
              height: 45,
              buttonColor: black87Color,
              textColor: whiteColor,
              text: "Close Account",
              onTap: () {
                if (ref.read(transactionVMProvider).value?.isNotEmpty == true) showDialog(context: context, builder: (context) => AccountClosePopup());
              })
        ],
      ),
    );
  }
}
