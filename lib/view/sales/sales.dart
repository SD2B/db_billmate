import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/common_widgets/sd_toast.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/view/sales/bill_items_header.dart';
import 'package:db_billmate/view/sales/label_text.dart';
import 'package:db_billmate/view/stock/add_item_popup.dart';
import 'package:db_billmate/view/stock/item_table_values.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/invoice_vm.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

class Sales extends HookConsumerWidget {
  final BillModel? updateBillModel;
  const Sales({super.key, this.updateBillModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ItemModel billItem = ref.watch(tempItemProvider);
    List<ItemModel> billItemList = ref.watch(tempItemListProvider);
    CustomerModel billCustomer = ref.watch(billCustomerProvider);
    int invNo = (updateBillModel?.invoiceNumber != null ? int.parse(updateBillModel?.invoiceNumber ?? "0") : ref.watch(invNoProvider)) ?? 0;
    FocusNode customerFocus = useFocusNode();
    FocusNode itemFocus = useFocusNode();
    final customerNameController = useTextEditingController(text: "");
    final itemNameController = useTextEditingController();
    final quantityController = useTextEditingController(text: billItem.quantity ?? "0");
    final unitPriceController = useTextEditingController(text: billItem.salePrice ?? "0");
    double itemPrice = (double.tryParse(quantityController.text) ?? 1) * double.parse(billItem.salePrice ?? '0');
    final priceController = useTextEditingController(text: itemPrice.toString());
    final receivedController = useTextEditingController(text: double.parse(updateBillModel?.received ?? "0.00") != 0 ? updateBillModel?.received : "0.00");
    final discountController = useTextEditingController(text: double.parse(updateBillModel?.discount ?? "0.00") != 0 ? updateBillModel?.discount : "0.00");
    final noteController = useTextEditingController(text: updateBillModel?.note ?? "");
    final currentBalance = useState(0.00);
    void reset() {
      ref.read(billCustomerProvider.notifier).state = CustomerModel();
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

    // useEffect(() {
    //   customerFocus.addListener(() {
    //     if (customerFocus.hasFocus) {
    //       qp("Focused on the field");
    //     }
    //   });
    //   return null;
    // }, [customerFocus]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            TypeAheadField<CustomerModel>(
              suggestionsCallback: (search) async {
                qp(search, "hiiiiii");
                List<CustomerModel> customers = await ref.read(customerVMProvider.notifier).get(search: {"name": search}, noWait: true);
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
            if (billCustomer != CustomerModel())
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
                  onChanged: (value) {
                    controller.text = value;
                  },
                  onSubmitted: (p0) {
                    addToItemLst();
                  },
                  suffix: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
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
              onSelected: (item) {
                ref.read(tempItemProvider.notifier).state = item;
              },
            ),
            CustomTextField(
              width: 100,
              controller: quantityController,
              selectAllOnFocus: true,
              hintText: "",
              label: "QTY",
              inputFormatters: [DoubleOnlyFormatter(maxDigitsAfterDecimal: 3)],
              onChanged: (value) {
                getItemTotalPrice();
              },
              onSubmitted: (p0) {
                addToItemLst();
              },
              suffix: SizedBox(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(billItem.unit ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700)),
                ],
              )),
            ),
            CustomTextField(
              width: 150,
              controller: unitPriceController,
              selectAllOnFocus: true,
              hintText: "",
              label: "Unit price",
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
                    if (billCustomer == CustomerModel()) {
                      SDToast.showToast(context, description: "Select a customer", type: ToastificationType.warning);
                      return;
                    }
                    final data = saveToBillModel();
                    qp(data.toJson());
                    bool res = await ref.read(invoiceVMProvider.notifier).save(data);
                    if (res) {
                      reset();
                      ref.read(invoiceVMProvider.notifier).getInvNo();
                      SDToast.showToast(context, description: "Invoice Generated Successfully", type: ToastificationType.success);
                    } else {
                      SDToast.showToast(context, description: "Contact support immediately", type: ToastificationType.error);
                    }
                  }),
              CustomButton(width: 110, buttonColor: blackColor, textColor: whiteColor, text: updateBillModel?.id != null ? "Update & Print" : "Save & Print", onTap: () {}),
              CustomButton(width: 100, buttonColor: ColorCode.colorList(context).borderColor, textColor: blackColor, text: "Clear", onTap: () {}),
            ],
          )
        ]
      ],
    );
  }
}
