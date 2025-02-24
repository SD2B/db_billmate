import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/view/sales/bill_items_header.dart';
import 'package:db_billmate/view/stock/item_table_headers.dart';
import 'package:db_billmate/view/stock/item_table_values.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Sales extends HookConsumerWidget {
  const Sales({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ItemModel billItem = ref.watch(tempItemProvider);
    List<ItemModel> billItemList = ref.watch(tempItemListProvider);
    CustomerModel billCustomer = ref.watch(tempCustomerProvider);
    final customerNameController = useTextEditingController(text: "");
    final itemNameController = useTextEditingController();
    final quantityController = useTextEditingController(text: billItem.quantity ?? "0");
    final unitPriceController = useTextEditingController(text: billItem.salePrice ?? "0");
    final itemPrice = (double.tryParse(quantityController.text) ?? 1) * double.parse(billItem.salePrice ?? '0');
    final priceController = useTextEditingController(text: itemPrice.toString());

    void getItemTotalPrice() {
      final itemPriceTotal = (double.tryParse(unitPriceController.text) ?? 0) * (double.tryParse(quantityController.text) ?? 1);
      priceController.text = "$itemPriceTotal";
    }

    void addToItemLst() {
      if (itemNameController.text.isNotEmpty && quantityController.text.isNotEmpty && unitPriceController.text.isNotEmpty) {
        ref.read(tempItemListProvider.notifier).state.add(billItem.copyWith(
              salePrice: unitPriceController.text,
              quantity: quantityController.text,
              billPrice: priceController.text,
            ));
        ref.read(tempItemProvider.notifier).state = ItemModel();
      }
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
      return null;
    }, [billItem]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TypeAheadField<CustomerModel>(
          suggestionsCallback: (search) async {
            qp(search);
            List<CustomerModel> customers = await ref.read(customerVMProvider.notifier).get(search: {"name": search}, noWait: true);
            return customers;
          },
          builder: (context, controller, focusNode) {
            return CustomTextField(
              width: 300,
              focusNode: focusNode,
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
            ref.read(tempCustomerProvider.notifier).state = customer;
          },
        ),
        20.height,
        Row(
          spacing: 10,
          children: [
            TypeAheadField<ItemModel>(
              suggestionsCallback: (search) async {
                qp(search);
                List<ItemModel> item = await ref.read(itemVMProvider.notifier).get(search: {"name": search});
                return item;
              },
              builder: (context, controller, focusNode) {
                return CustomTextField(
                  width: 300,
                  focusNode: focusNode,
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
                );
              },
              itemBuilder: (context, item) {
                return ListTile(
                  tileColor: whiteColor,
                  title: Text(item.name ?? ""),
                  subtitle: Text(item.salePrice ?? ""),
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
              text: "Add",
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
          height: context.height() - 500,
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
                            child: PopupMenuButton(
                                color: whiteColor,
                                itemBuilder: (context) {
                                  return [];
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
