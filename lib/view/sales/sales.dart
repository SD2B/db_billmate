import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_dropdown.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/common_widgets/sd_toast.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/models/ui_model.dart';
import 'package:db_billmate/view/sales/bill_items_header.dart';
import 'package:db_billmate/view/sales/label_text.dart';
import 'package:db_billmate/view/sales/quantity_suffix.dart';
import 'package:db_billmate/view/stock/add_item_popup.dart';
import 'package:db_billmate/view/stock/item_table_values.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/invoice_vm.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:db_billmate/vm/unit_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

class Sales extends HookConsumerWidget {
  final BillModel? updateBillModel;
  final bool isUpdate;
  const Sales({super.key, this.updateBillModel, this.isUpdate = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantityFocus = useFocusNode();
    final unitPriceFocus = useFocusNode();
    ItemModel billItem = ref.watch(tempItemProvider);
    List<ItemModel> billItemList = ref.watch(tempItemListProvider);
    EndUserModel billCustomer = ref.watch(billCustomerProvider);
    int invNo = (updateBillModel?.invoiceNumber != null ? int.parse(updateBillModel?.invoiceNumber ?? "0") : ref.watch(invNoProvider)) ?? 0;
    FocusNode customerFocus = useFocusNode();
    FocusNode itemFocus = useFocusNode();
    final customerNameController = useTextEditingController(text: "");
    final itemNameController = useTextEditingController();
    final quantityController = useTextEditingController(text: billItem.quantity ?? "0");
    final unitPriceController = useTextEditingController(text: billItem.salePrice ?? "0");
    double itemPrice = (double.tryParse(quantityController.text) ?? 1) * (double.tryParse(billItem.salePrice ?? "0") ?? 0);
    final priceController = useTextEditingController(text: itemPrice.toString());
    final receivedController = useTextEditingController(text: double.parse(updateBillModel?.received ?? "0.00") != 0 ? updateBillModel?.received : "0.00");
    final discountController = useTextEditingController(text: double.parse(updateBillModel?.discount ?? "0.00") != 0 ? updateBillModel?.discount : "0.00");
    final noteController = useTextEditingController(text: updateBillModel?.note ?? "");
    final currentBalance = useState(0.00);
    void reset() {
      ref.read(billCustomerProvider.notifier).state = EndUserModel();
      ref.read(tempItemListProvider.notifier).state = [];
      ref.read(tempItemProvider.notifier).state = ItemModel();
      customerNameController.text = "";
      itemNameController.text = "";
      quantityController.text = "";
      unitPriceController.text = "";
      itemPrice = (double.tryParse(quantityController.text) ?? 1) * double.parse(billItem.salePrice ?? '0');
      priceController.text = itemPrice.toString();
      receivedController.text = "0.00";
      discountController.text = "0.00";
      noteController.text = "";
      currentBalance.value = 0.00;
    }

    void getItemTotalPrice() {
      final itemPriceTotal = (double.tryParse(unitPriceController.text) ?? 0) * (double.tryParse(quantityController.text) ?? 1);
      priceController.text = "$itemPriceTotal";
    }

    void addToItemLst() {
      if (itemNameController.text.isNotEmpty && quantityController.text.isNotEmpty && unitPriceController.text.isNotEmpty) {
        if (billItem.billId != null) {
          // Update the existing item in the list
          ref.read(tempItemListProvider.notifier).state = ref
              .read(tempItemListProvider)
              .map((item) => item.billId == billItem.billId
                  ? billItem.copyWith(
                      salePrice: unitPriceController.text,
                      quantity: quantityController.text,
                      billPrice: priceController.text,
                    )
                  : item)
              .toList();
        } else {
          // Add a new item to the list
          ref.read(tempItemListProvider.notifier).state = [
            ...ref.read(tempItemListProvider),
            billItem.copyWith(
              billId: ref.read(tempItemListProvider).length + 1,
              salePrice: unitPriceController.text,
              quantity: quantityController.text,
              billPrice: priceController.text,
            ),
          ];
        }

        // Reset the temp item
        ref.read(tempItemProvider.notifier).state = ItemModel();

        // Request focus for the next item
        itemFocus.requestFocus();
      }
    }

    void removeFromList(int billId) {
      ref.read(tempItemListProvider.notifier).state = ref.read(tempItemListProvider).where((item) => item.billId != billId).toList();
    }

    double getTotal() {
      double total = billItemList.fold<double>(
        0.0,
        (sum, item) => sum + (double.tryParse(item.billPrice ?? '0') ?? 0),
      );
      return double.parse(total.toStringAsFixed(2));
    }

    double getGrandTotal() {
      double total = getTotal();
      double ob = double.parse(billCustomer.balanceAmount);
      return double.parse((ob + total).toStringAsFixed(2));
    }

    double getcurrentBalance() {
      double gTotal = getGrandTotal();
      double recieved = double.tryParse(receivedController.text) ?? 0.00;
      double discount = double.tryParse(discountController.text) ?? 0.00;
      currentBalance.value = double.parse((gTotal - discount - recieved).toStringAsFixed(2));
      return currentBalance.value;
    }

    double getDiscount() {
      double discount = double.tryParse(discountController.text) ?? 0.00;
      getcurrentBalance();
      return discount;
    }

    BillModel saveToBillModel() {
      BillModel model = BillModel(
        id: updateBillModel?.id,
        invoiceNumber: "$invNo",
        customerId: billCustomer.id,
        customerName: billCustomer.name,
        items: billItemList,
        total: getTotal().toStringAsFixed(2),
        ob: (double.tryParse(billCustomer.balanceAmount) ?? 0.00).toStringAsFixed(2),
        grandTotal: getGrandTotal().toStringAsFixed(2),
        discount: getDiscount().toStringAsFixed(2),
        received: (double.tryParse(receivedController.text) ?? 0.00).toStringAsFixed(2),
        currentBalance: getcurrentBalance().toStringAsFixed(2),
        dateTime: DateTime.now(),
        note: noteController.text,
      );
      qp(model);
      return model;
    }

    // Update itemNameController when billItem changes
    useEffect(() {
      customerNameController.text = billCustomer.name ?? "";
      return null;
    }, [billCustomer]);
    useEffect(() {
      itemNameController.text = billItem.name ?? "";
      unitPriceController.text = billItem.salePrice ?? "";
      quantityController.text = billItem.quantity ?? "1";
      getItemTotalPrice();
      ref.read(invoiceVMProvider.notifier).getInvNo();
      return null;
    }, [billItem]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            TypeAheadField<EndUserModel>(
              suggestionsCallback: (search) async {
                qp(search, "hiiiiii");
                List<EndUserModel> customers = await ref.read(customerVMProvider.notifier).get(search: {"name": search}, noWait: true);
                return customers;
              },
              builder: (context, controller, focusNode) {
                customerFocus = focusNode;
                // Add listener to refresh data when the field gains focus
                customerFocus.addListener(() {
                  if (customerFocus.hasFocus) {
                    controller.text = " ";
                    controller.text = "";
                  }
                });

                return CustomTextField(
                  width: 300,
                  focusNode: customerFocus,
                  controller: customerNameController,
                  selectAllOnFocus: true,
                  hintText: "",
                  label: "Customer name",
                  onChanged: (value) => controller.text = value,
                );
              },
              itemBuilder: (context, customer) {
                return ListTile(
                  tileColor: whiteColor,
                  title: Text(customer.name ?? ""),
                  subtitle: Text(customer.phone ?? ""),
                );
              },
              onSelected: (customer) {
                ref.read(billCustomerProvider.notifier).state = customer;
              },
            ),
            if (billCustomer != EndUserModel())
              CustomButtonCard(
                width: 200,
                height: 45,
                text: "Account Balance: ${billCustomer.balanceAmount}",
                buttonColor: ColorCode.colorList(context).borderColor!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
              ),
            Spacer(),
            CustomButtonCard(
              width: 200,
              height: 45,
              text: "Invoice No: $invNo",
              buttonColor: ColorCode.colorList(context).borderColor!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
            ),
            IconButton(tooltip: "Refresh Invoice Number", onPressed: () => ref.read(invoiceVMProvider.notifier).getInvNo(), icon: Icon(Icons.refresh))
          ],
        ),
        20.height,
        Row(
          spacing: 10,
          children: [
            TypeAheadField<ItemModel>(
              suggestionsCallback: (search) async {
                List<ItemModel> items = await ref.read(itemVMProvider.notifier).get(search: {"name": search});

                return items;
              },
              builder: (context, controller, focusNode) {
                itemFocus = focusNode;
                return CustomTextField(
                  width: 300,
                  focusNode: itemFocus,
                  controller: itemNameController,
                  selectAllOnFocus: true,
                  hintText: "",
                  label: "Item name",
                  inputFormatters: [CapitalizeEachWordFormatter()],
                  onChanged: (value) {
                    controller.text = value;
                  },
                  onSubmitted: (p0) {
                    addToItemLst();
                  },
                  prefix: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                    child: CustomIconButton(
                      buttonSize: 50,
                      icon: Icons.add,
                      iconColor: whiteColor,
                      buttonColor: appPrimary,
                      shape: BoxShape.rectangle,
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AddItemPopup(
                                updateModel: ItemModel(name: itemNameController.text),
                              )),
                    ),
                  ),
                );
              },
              itemBuilder: (context, item) {
                final pricePer = "${item.salePrice}/${item.unit}";

                return ListTile(
                  tileColor: whiteColor,
                  title: Text(item.name ?? ""),
                  subtitle: Text(pricePer),
                );
              },
              emptyBuilder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      ref.read(tempItemProvider.notifier).state = ItemModel(name: itemNameController.text);
                      quantityFocus.requestFocus();
                    },
                    tileColor: whiteColor,
                    title: Text("Add item"),
                    subtitle: Text(""),
                  )
                ],
              ),
              onSelected: (item) {
                ref.read(tempItemProvider.notifier).state = item;
              },
            ),
            CustomTextField(
              focusNode: quantityFocus,
              width: 150,
              controller: quantityController,
              selectAllOnFocus: true,
              hintText: "",
              label: "QTY",
              isAmount: true,
              inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 3)],
              onChanged: (value) {
                getItemTotalPrice();
              },
              onSubmitted: (p0) {
                addToItemLst();
              },
              suffix: billItem.id != null
                  ? QuantitySuffix(billItem: billItem)
                  : SearchableDropdown<UiModel>(
                      width: 250,
                      hint: "Select unit",
                      initialValue: billItem.unit == null ? null : UiModel(value: billItem.unit),
                      asyncValues: () async => await ref.read(unitVMProvider.notifier).get(),
                      itemAsString: (p0) => p0.value ?? "",
                      customChild: SizedBox(height: 50, width: 40, child: Center(child: QuantitySuffix(billItem: billItem))),
                      onChanged: (value) {
                        ref.read(tempItemProvider.notifier).state = billItem.copyWith(unit: value?.value, quantity: quantityController.text, billPrice: priceController.text, salePrice: unitPriceController.text);
                        unitPriceFocus.requestFocus();
                      },
                    ),
            ),
            CustomTextField(
              focusNode: unitPriceFocus,
              width: 150,
              controller: unitPriceController,
              selectAllOnFocus: true,
              hintText: "",
              label: "Unit price",
              isAmount: true,
              inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 2)],
              onChanged: (value) {
                getItemTotalPrice();
              },
              onSubmitted: (p0) {
                addToItemLst();
              },
            ),
            CustomTextField(
              width: 150,
              readOnly: true,
              controller: priceController,
              selectAllOnFocus: true,
              hintText: "",
              label: "Total price",
              isAmount: true,
              onChanged: (value) {},
              onSubmitted: (p0) {
                addToItemLst();
              },
            ),
            CustomButton(
              width: 80,
              height: 45,
              buttonColor: blackColor,
              textColor: whiteColor,
              text: billItem.billId != null ? "Upadte" : "Add",
              onTap: () {
                addToItemLst();
              },
            ),
          ],
        ),
        20.height,
        BillItemsHeader(),
        10.height,
        SizedBox(
          height: updateBillModel?.id != null ? context.height() - 500 : context.height() - 550,
          width: context.width() - 150,
          child: ListView.builder(
              itemCount: billItemList.length,
              itemBuilder: (context, index) {
                final item = billItemList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      ref.read(tempItemProvider.notifier).state = item;
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorCode.colorList(context).borderColor!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Text(
                              "${index + 1}",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
                            ),
                          ),
                          10.width,
                          VerticalDivider(color: ColorCode.colorList(context).borderColor),
                          ItemTableValues(flex: 2, value: "${item.name}"),
                          VerticalDivider(color: ColorCode.colorList(context).borderColor),
                          ItemTableValues(value: "${item.quantity}"),
                          VerticalDivider(color: ColorCode.colorList(context).borderColor),
                          SizedBox(
                            width: 30,
                            child: Text(
                              "${item.unit}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: ColorCode.colorList(context).primary),
                            ),
                          ),
                          VerticalDivider(color: ColorCode.colorList(context).borderColor),
                          ItemTableValues(value: "${item.salePrice}"),
                          VerticalDivider(color: ColorCode.colorList(context).borderColor),
                          ItemTableValues(value: "${item.billPrice}"),
                          VerticalDivider(color: ColorCode.colorList(context).borderColor),
                          SizedBox(
                              width: 100,
                              child: IconButton(
                                onPressed: () => removeFromList(item.billId ?? 0),
                                icon: Icon(Icons.delete),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        if (billItemList.isNotEmpty) ...[
          Spacer(),
          20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextField(
                width: 400,
                height: 120,
                maxLines: 5,
                controller: noteController,
                hintText: "Add Note",
                label: "Add note",
              ),
              Container(
                height: 120,
                width: 500,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorCode.colorList(context).borderColor!),
                ),
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LabelText(
                            label: "Total",
                            text: getTotal().toStringAsFixed(2),
                          ),
                          LabelText(
                            label: "Old Balance",
                            text: (double.tryParse(billCustomer.balanceAmount) ?? 0.00).toStringAsFixed(2),
                          ),
                          LabelText(
                            label: "Grand Total",
                            text: getGrandTotal().toStringAsFixed(2),
                          ),
                          LabelText(
                            label: "Discount",
                            text: getDiscount().toStringAsFixed(2),
                          ),
                          LabelText(
                            label: "Recieved",
                            text: (double.tryParse(receivedController.text) ?? 0.00).toStringAsFixed(2),
                          ),
                          LabelText(
                            label: "Current Balance",
                            text: (getcurrentBalance()).toStringAsFixed(2),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                          width: 200,
                          height: 45,
                          isAmount: true,
                          selectAllOnFocus: true,
                          controller: discountController,
                          inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 2)],
                          hintText: "",
                          label: "Discount",
                          onChanged: (p0) {
                            getDiscount();
                          },
                        ),
                        CustomTextField(
                          width: 200,
                          height: 45,
                          isAmount: true,
                          selectAllOnFocus: true,
                          controller: receivedController,
                          inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 2)],
                          hintText: "",
                          label: "Recieved",
                          onChanged: (p0) {
                            getcurrentBalance();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.height,
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                width: 110,
                buttonColor: blackColor,
                textColor: whiteColor,
                text: updateBillModel?.id != null ? "Update" : "Save",
                isLoading: ref.watch(invoiceVMProvider).isLoading,
                onTap: () async {
                  if (billCustomer.id == null) {
                    SDToast.showToast(description: "Select a customer", type: ToastificationType.warning);
                    return;
                  }

                  // Process and save items first
                  List<Future<void>> itemSaveTasks = [];

                  for (int i = 0; i < billItemList.length; i++) {
                    if (billItemList[i].id == null) {
                      ItemModel item = ItemModel(
                        name: billItemList[i].name,
                        salePrice: billItemList[i].salePrice,
                        unit: billItemList[i].unit,
                        modified: DateTime.now(),
                      );
                      itemSaveTasks.add(ref.read(itemVMProvider.notifier).save(item).then((res) {
                        billItemList[i] = billItemList[i].copyWith(id: res.id);
                      }));
                    }
                  }

                  await Future.wait(itemSaveTasks); // Ensure all items are processed before moving forward

                  final data = saveToBillModel();
                  bool res = await ref.read(invoiceVMProvider.notifier).save(data);

                  if (res) {
                    SDToast.showToast(
                      description: updateBillModel?.id != null ? "Invoice Updated Successfully" : "Invoice Generated Successfully",
                      type: ToastificationType.success,
                    );
                    reset();
                    ref.read(invoiceVMProvider.notifier).getInvNo();
                    if (isUpdate) {
                      context.pop();
                    }
                  } else {
                    SDToast.showToast(description: "Contact support immediately", type: ToastificationType.error);
                  }
                },
              ),
              CustomButton(width: 110, buttonColor: blackColor, textColor: whiteColor, text: updateBillModel?.id != null ? "Update & Print" : "Save & Print", onTap: () {}),
              CustomButton(width: 100, buttonColor: ColorCode.colorList(context).borderColor, textColor: blackColor, text: "Clear", onTap: () {}),
            ],
          )
        ]
      ],
    );
  }
}
