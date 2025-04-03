import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/common_widgets/pickers.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class TransactionPopup extends HookConsumerWidget {
  final bool youGot;
  final bool isSupplier;
  final TransactionModel? amountModel;
  final Function(TransactionModel) onSave;

  const TransactionPopup({
    super.key,
    required this.youGot,
    this.amountModel,
    required this.onSave,
    this.isSupplier = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = useState<TransactionModel>(amountModel ?? TransactionModel());
    final amountController = useTextEditingController(text: "${model.value.amount}" "");
    final noteController = useTextEditingController(text: model.value.description ?? "");
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
        ),
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 280,
                decoration: BoxDecoration(
                  color: youGot ? (isSupplier ? redColor : greenColor) : (isSupplier ? greenColor : redColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    youGot ? (isSupplier ? "You Bought" : "You Got") : "You gave",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: whiteColor,
                        ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: model.value.dateTime ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      date = updateDateTimeWithTime(date, TimeOfDay.now());
                      qp(date);
                      qp(extractTimeFromDateTime(date));
                      bool check = checkIfTimeEmpty(model.value.dateTime);
                      qp(check);
                      if (!check) {
                        qp("111111111111");
                        model.value = model.value.copyWith(dateTime: updateDateTimeWithDate(model.value.dateTime!, date));
                      } else {
                        qp("22222222222222");
                        model.value = model.value.copyWith(dateTime: date);
                      }
                      qp(model.value.dateTime);
                      Picker.timePicker(
                        context: context,
                        initialValue: extractTimeFromDateTime(model.value.dateTime!),
                        onTimeChanged: (selectedTime) {
                          model.value = model.value.copyWith(dateTime: updateDateTimeWithTime(model.value.dateTime ?? DateTime.now(), selectedTime));
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    // width: 280,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: appSecondary)),
                    child: Row(
                      children: [
                        Text(
                          DateFormat("📅 dd/MM/yyyy").format(model.value.dateTime ?? DateTime.now()), // Include time (HH:mm:ss)
                        ),
                        Spacer(),
                        Text(
                          DateFormat("🕓 hh:mm a").format(model.value.dateTime ?? DateTime.now()), // Include time (HH:mm:ss)
                        ),
                      ],
                    ),
                  )),
              CustomTextField(
                selectAllOnFocus: true,
                controller: amountController,
                inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 2)],
                hintText: "Enter amount",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Amount is required";
                  }
                  final doubleValue = double.tryParse(value);
                  if (doubleValue == null || doubleValue <= 0) {
                    return "Enter a valid amount";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: noteController,
                hintText: "Enter note",
                inputFormatters: [CapitalizeEachWordFormatter(onlyFirstLetter: true)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    width: 125,
                    height: 45,
                    textColor: whiteColor,
                    buttonColor: black87Color,
                    text: "Save",
                    onTap: () {
                      if (formKey.currentState?.validate() ?? false) {
                        if (model.value.id != null) {
                          model.value = model.value.copyWith(
                            amount: double.parse(amountController.text),
                            description: noteController.text,
                          );
                        } else {
                          // int id = UniqueIdGenerator.generateId();
                          model.value = model.value.copyWith(
                            id: model.value.id,
                            amount: double.parse(amountController.text),
                            description: noteController.text,
                            dateTime: model.value.dateTime ?? DateTime.now(),
                            toGet: !youGot,
                          );
                        }

                        onSave(model.value);
                        context.pop();
                      }
                    },
                  ),
                  CustomButton(
                    width: 125,
                    height: 45,
                    textColor: blackColor,
                    buttonColor: black26Color,
                    text: "Cancel",
                    onTap: () => context.pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
