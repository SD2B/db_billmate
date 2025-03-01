import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_dropdown.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/models/ui_model.dart';
import 'package:db_billmate/view/stock/add_category_popup.dart';
import 'package:db_billmate/vm/category_vm.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:db_billmate/vm/unit_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddItemPopup extends HookConsumerWidget {
  final ItemModel? updateModel;
  const AddItemPopup({super.key, this.updateModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>(); // Form key for validation
    final itemModel = useState(updateModel ?? ItemModel());
    final nameController = useTextEditingController(text: itemModel.value.name);
    final purchasePriceController =
        useTextEditingController(text: itemModel.value.purchasePrice);
    final salePriceController =
        useTextEditingController(text: itemModel.value.salePrice);
    void resetFields() {
      itemModel.value = ItemModel();
      nameController.clear();
      purchasePriceController.clear();
      salePriceController.clear();
    }

    return AlertDialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Row(
        children: [
          Text(
            itemModel.value.id != null ? "Update Item" : "Add Item",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close_rounded)),
        ],
      ),
      content: SizedBox(
        width: 300,
        child: Form(
          key: formKey, // Attach the form key
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: nameController,
                hintText: "Enter name",
                inputFormatters: [CapitalizeEachWordFormatter()],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is required.";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  SearchableDropdown<UiModel>(
                    width: 250,
                    hint: "Select category",
                    initialValue: itemModel.value.category == null
                        ? null
                        : UiModel(value: itemModel.value.category),
                    asyncValues: () async =>
                        await ref.read(categoryVMProvider.notifier).get(),
                    itemAsString: (p0) => p0.value ?? "",
                    onChanged: (value) {
                      itemModel.value =
                          itemModel.value.copyWith(category: value?.value);
                    },
                  ),
                  5.width,
                  CustomIconButton(
                    buttonSize: 45,
                    shape: BoxShape.rectangle,
                    icon: Icons.add,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AddAttributePopup(
                                title: "Category",
                                onSave: (p0) async => await ref
                                    .read(categoryVMProvider.notifier)
                                    .save(p0),
                              ));
                    },
                  )
                ],
              ),
              Row(
                children: [
                  SearchableDropdown<UiModel>(
                    width: 250,
                    hint: "Select unit",
                    initialValue: itemModel.value.unit == null
                        ? null
                        : UiModel(value: itemModel.value.unit),
                    asyncValues: () async =>
                        await ref.read(unitVMProvider.notifier).get(),
                    itemAsString: (p0) => p0.value ?? "",
                    onChanged: (value) {
                      itemModel.value =
                          itemModel.value.copyWith(unit: value?.value);
                    },
                    validator: (model) {
                      if (itemModel.value.unit == null ||
                          itemModel.value.unit?.isEmpty == true) {
                        return "Unit is required.";
                      }

                      return null;
                    },
                  ),
                  5.width,
                  CustomIconButton(
                    buttonSize: 45,
                    shape: BoxShape.rectangle,
                    icon: Icons.add,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AddAttributePopup(
                                title: "Unit",
                                onSave: (p0) async => await ref
                                    .read(unitVMProvider.notifier)
                                    .save(p0),
                              ));
                    },
                  )
                ],
              ),
              CustomTextField(
                controller: purchasePriceController,
                hintText: "Enter purchase price",
                selectAllOnFocus: true,
              ),
              CustomTextField(
                controller: salePriceController,
                hintText: "Enter sale price",
                selectAllOnFocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Sale price is required.";
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return "Enter a valid sale price.";
                  }
                  return null;
                },
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
              width: 145,
              text: itemModel.value.id != null ? "Update" : "Save",
              textColor: whiteColor,
              buttonColor:
                  itemModel.value.id != null ? black87Color : black54Color,
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  itemModel.value = itemModel.value.copyWith(
                    name: nameController.text,
                    purchasePrice: purchasePriceController.text,
                    salePrice: salePriceController.text,
                  );
                  await ref.read(itemVMProvider.notifier).save(itemModel.value);
                  context.pop();
                }
              },
            ),
            if (itemModel.value.id == null)
              CustomButton(
                width: 145,
                text: "Save & New",
                textColor: whiteColor,
                buttonColor: ColorCode.colorList(context).primary,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    itemModel.value = itemModel.value.copyWith(
                      name: nameController.text,
                      purchasePrice: purchasePriceController.text,
                      salePrice: salePriceController.text,
                    );
                    await ref
                        .read(itemVMProvider.notifier)
                        .save(itemModel.value);
                    resetFields();
                  }
                },
              ),
            if (itemModel.value.id != null)
              CustomButton(
                width: 145,
                text: "Cancel",
                textColor: whiteColor,
                buttonColor: black54Color,
                onTap: () async => context.pop(),
              ),
          ],
        ),
      ],
    );
  }
}
