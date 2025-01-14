import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AccountClosePopup extends HookConsumerWidget {
  const AccountClosePopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempCustomer = ref.read(tempCustomerProvider.notifier);

    final toGet = useState(true);
    final amountController = useTextEditingController();
    return AlertDialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: SizedBox(
        width: 200,
        child: Text(
          "Are you sure you want to close this account?",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 20, fontWeight: FontWeight.w400, color: black87Color),
        ),
      ),
      content: SizedBox(
        width: 250,
        child: Row(
          children: [
            CustomTextField(
              width: 140,
              controller: amountController,
              hintText: "New balance",
              inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 2)],
            ),
            10.width,
            Checkbox(
              value: toGet.value,
              onChanged: (value) => toGet.value = value ?? true,
            ),
            const Expanded(child: Text('To get', style: TextStyle(fontSize: 16.0))),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
                width: 120,
                height: 40,
                buttonColor: black87Color,
                textColor: whiteColor,
                text: "Yes",
                onTap: () async {
                  tempCustomer.state = tempCustomer.state.copyWith(
                    modified: DateTime.now(),
                    balanceAmount: amountController.text.isEmpty ? "0.00" : double.parse(amountController.text).toStringAsFixed(2),
                    transactionList: amountController.text.isEmpty ? [] : [AmountModel(id: 1, amount: double.parse(amountController.text), toGet: toGet.value, customerId: tempCustomer.state.id, dateTime: DateTime.now(), description: "Balance after account closed on ${DateFormat("EEEE, MMMM dd, yyyy").format(DateTime.now())} at ${DateFormat("hh:mm aaa").format(DateTime.now())}")],
                  );
                  await ref.read(customerVMProvider.notifier).save(tempCustomer.state);
                  context.pop();
                }),
            CustomButton(width: 120, height: 40, buttonColor: ColorCode.colorList(context).borderColor, textColor: black87Color, text: "No", onTap: () => context.pop()),
          ],
        )
      ],
    );
  }
}
