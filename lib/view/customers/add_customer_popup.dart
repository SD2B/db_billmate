import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class AddCustomerPopup extends HookWidget {
  final CustomerModel updateModel;
  final Function(CustomerModel) onSaved;
  const AddCustomerPopup({super.key, this.updateModel = const CustomerModel(), required this.onSaved});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final groupController = useTextEditingController();
    final phoneController = useTextEditingController();
    final addressController = useTextEditingController();
    final openingBalanceController = useTextEditingController();
    final toGet = useState(true);
    final model = useState<CustomerModel>(updateModel);
    void resetFields() {
      nameController.clear();
      groupController.clear();
      phoneController.clear();
      addressController.clear();
      openingBalanceController.clear();
      toGet.value = true;
      model.value = CustomerModel(); // Reset the model to default values
    }

    void saveCustomer() {
      if (formKey.currentState?.validate() ?? false) {
        model.value = model.value.copyWith(
          name: nameController.text,
          group: groupController.text,
          phone: phoneController.text,
          address: addressController.text,
          transactionList: [
            if (openingBalanceController.text.isNotEmpty)
              AmountModel(
                id: 1,
                amount: double.tryParse(openingBalanceController.text) ?? 0.0,
                toGet: toGet.value,
                dateTime: DateTime.now(),
              ),
          ],
        );
        onSaved(model.value);
      }
    }

    return AlertDialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(20),
      title: Row(
        children: [
          Text(
            "Add Customer",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Spacer(),
          IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close_rounded)),
        ],
      ),
      content: Form(
        key: formKey,
        child: SizedBox(
          width: 300,
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                width: 300,
                controller: nameController,
                inputFormatters: [CapitalizeEachWordFormatter()],
                hintText: "Name",
                validator: (value) => value == null || value.isEmpty ? 'Name is required' : null,
              ),
              CustomTextField(
                width: 300,
                controller: phoneController,
                hintText: "Phone",
                textInputType: TextInputType.phone,
                inputFormatters: [IntegerOnlyFormatter(maxDigits: 10)],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone is required';
                  } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              CustomTextField(
                width: 300,
                controller: groupController,
                hintText: "Group",
              ),
              CustomTextField(
                width: 300,
                controller: addressController,
                hintText: "Address",
              ),
              Row(
                children: [
                  CustomTextField(
                    width: 200,
                    controller: openingBalanceController,
                    inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 2)],
                    hintText: "Opening balance",
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(width: 10),
                  Checkbox(
                    value: toGet.value,
                    onChanged: (value) => toGet.value = value ?? true,
                  ),
                  const Expanded(child: Text('To get', style: TextStyle(fontSize: 16.0))),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              width: 140,
              text: "Save",
              textColor: whiteColor,
              buttonColor: black54Color,
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {
                  saveCustomer();
                  formKey.currentState?.reset();
                  context.pop();
                }
              },
            ),
            CustomButton(
              width: 140,
              text: "Save & New",
              textColor: whiteColor,
              buttonColor: ColorCode.colorList(context).primary,
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {
                  saveCustomer();
                  formKey.currentState?.reset();
                  resetFields();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
