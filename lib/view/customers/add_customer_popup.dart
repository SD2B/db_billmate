import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_dropdown.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/models/ui_model.dart';
import 'package:db_billmate/view/stock/add_category_popup.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/group_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddCustomerPopup extends HookConsumerWidget {
  final CustomerModel updateModel;
  const AddCustomerPopup({super.key, this.updateModel = const CustomerModel()});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final model = useState<CustomerModel>(updateModel);
    final transactionModel = useState(TransactionModel());
    final nameController = useTextEditingController(text: model.value.name);
    final phoneController = useTextEditingController(text: model.value.phone);
    final addressController = useTextEditingController(text: model.value.address);
    final openingBalanceController = useTextEditingController(text: "0.00");
    final toGet = useState(true);
    void resetFields() {
      nameController.clear();
      phoneController.clear();
      addressController.clear();
      openingBalanceController.clear();
      toGet.value = true;
      model.value = CustomerModel();
    }

    void saveCustomer() {
      if (formKey.currentState?.validate() ?? false) {
        model.value = model.value.copyWith(
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          balanceAmount: model.value.id != null
              ? model.value.balanceAmount
              : toGet.value
                  ? "${double.tryParse(openingBalanceController.text)}"
                  : "-${double.tryParse(openingBalanceController.text)}",
        );
        transactionModel.value = openingBalanceController.text == "0.00"
            ? TransactionModel()
            : TransactionModel(
                amount: double.tryParse(openingBalanceController.text) ?? 0.0,
                toGet: toGet.value,
                dateTime: DateTime.now(),
              );
      }
    }

    return AlertDialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(20),
      title: Row(
        children: [
          Text(
            model.value.id != null ? "Update Customer" : "Add Customer",
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
              Row(
                children: [
                  SearchableDropdown<UiModel>(
                    width: 250,
                    hint: "Group",
                    initialValue: model.value.group == null ? null : UiModel(value: model.value.group),
                    asyncValues: () async => await ref.read(groupVMProvider.notifier).get(),
                    itemAsString: (p0) => p0.value ?? "",
                    onChanged: (value) {
                      qp(value);
                      model.value = model.value.copyWith(group: value?.value);
                    },
                  ),
                  5.width,
                  CustomIconButton(
                    buttonSize: 45,
                    shape: BoxShape.rectangle,
                    icon: Icons.add,
                    onTap: () {
                      showDialog(context: context, builder: (context) => AddAttributePopup(title: "New Group", onSave: (p0) async => await ref.read(groupVMProvider.notifier).save(p0)));
                    },
                  )
                ],
              ),
              CustomTextField(
                width: 300,
                controller: addressController,
                hintText: "Address",
              ),
              if (model.value.id == null)
                Row(
                  children: [
                    CustomTextField(
                      width: 200,
                      controller: openingBalanceController,
                      inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 2)],
                      hintText: "Opening balance",
                      textInputType: TextInputType.number,
                      selectAllOnFocus: true,
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
              isLoading: ref.read(customerVMProvider).isLoading,
              width: 140,
              height: 45,
              text: model.value.id != null ? "Update" : "Save",
              textColor: whiteColor,
              buttonColor: model.value.id != null ? black87Color : black54Color,
              onTap: () async {
                if (formKey.currentState?.validate() ?? false) {
                  saveCustomer();
                  await ref.read(customerVMProvider.notifier).save(model.value, transactionModel: transactionModel.value);
                  formKey.currentState?.reset();
                  context.pop();
                }
              },
            ),
            if (model.value.id == null)
              CustomButton(
                isLoading: ref.read(customerVMProvider).isLoading,
                width: 140,
                height: 45,
                text: "Save & New",
                textColor: whiteColor,
                buttonColor: ColorCode.colorList(context).primary,
                onTap: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    saveCustomer();
                    await ref.read(customerVMProvider.notifier).save(model.value, transactionModel: transactionModel.value);
                    formKey.currentState?.reset();
                    resetFields();
                  }
                },
              ),
            if (model.value.id != null)
              CustomButton(
                width: 140,
                text: "Cancel",
                textColor: whiteColor,
                buttonColor: black54Color,
                onTap: () {
                  formKey.currentState?.reset();
                  context.pop();
                },
              ),
          ],
        ),
      ],
    );
  }
}
