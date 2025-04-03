import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/customers/elements/reminder_pop.dart';
import 'package:db_billmate/view/suppliers/add_supplier_popup.dart';
import 'package:db_billmate/view/suppliers/elements/supplier_account_close_popup.dart';
import 'package:db_billmate/vm/supplier_vm.dart';
import 'package:db_billmate/vm/transaction_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SupplierTransactionHeader extends HookConsumerWidget {
  const SupplierTransactionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempSupplier = ref.read(tempSupplierProvider.notifier);
    final startDate = useState(DateTime.now().subtract(Duration(days: 30)));
    final endDate = useState(DateTime.now());
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
              "${tempSupplier.state.name?.initials}",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: black87Color),
            ),
          ),
          VerticalDivider(),
          Text(
            "${tempSupplier.state.name}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ColorCode.colorList(context).primary,
                ),
          ),
          VerticalDivider(),
          Text(
            double.parse(tempSupplier.state.balanceAmount).toStringAsFixed(2).split("-").join(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: (tempSupplier.state.balanceAmount.contains("-")) ? redColor : greenColor,
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
                    builder: (context) => AddSupplierPopup(
                          updateModel: tempSupplier.state,
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
                if (ref.read(transactionVMProvider).value?.isNotEmpty == true) showDialog(context: context, builder: (context) => SupplierAccountClosePopup());
              }),
          // VerticalDivider(),
          // CustomIconButton(
          //   tooltipMsg: "Reminder",
          //   shape: BoxShape.rectangle,
          //   icon: Icons.alarm_outlined,
          //   buttonSize: 45,
          //   buttonColor: black87Color,
          //   iconColor: whiteColor,
          //   iconSize: 20,
          //   onTap: () {
          //     if (ref.read(transactionVMProvider).value?.isNotEmpty == true) {
          //       showDialog(context: context, builder: (context) => ReminderPop(model: tempSupplier.state));
          //     }
          //   },
          // ),
          VerticalDivider(),
          CustomIconButton(
            tooltipMsg: "Date Filter",
            shape: BoxShape.rectangle,
            icon: Icons.calendar_month_rounded,
            buttonSize: 45,
            buttonColor: black87Color,
            iconColor: whiteColor,
            iconSize: 20,
            onTap: () async {
              DateTimeRange? range = await showDateRangePicker(
                context: context,
                initialDateRange: DateTimeRange(start: startDate.value, end: endDate.value),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (range != null) {
                qp(range);
                startDate.value = range.start;
                endDate.value = range.end;
                ref.read(transactionVMProvider.notifier).get(where: {"customer_id": tempSupplier.state.id}, dateRange: range);
              }
            },
          ),
        ],
      ),
    );
  }
}
