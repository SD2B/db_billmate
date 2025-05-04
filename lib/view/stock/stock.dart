import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/common_widgets/scaling_text.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/excel_helper.dart';
import 'package:db_billmate/helpers/file_picker_helper.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/stock/add_item_popup.dart';
import 'package:db_billmate/view/stock/excel.dart';
import 'package:db_billmate/view/stock/item_list.dart';
import 'package:db_billmate/view/stock/item_table_headers.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Stock extends HookConsumerWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final itemModel = useState(ItemModel());
    final searchController = useTextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            CustomTextField(
              width: 300,
              height: 45,
              controller: searchController,
              label: "Search...",
              hintText: "Search...",
              onChanged: (search) async {
                await ref.read(itemVMProvider.notifier).get(search: {"name": search});
              },
            ),
            CustomIconButton(
              buttonSize: 45,
              icon: Icons.tune_rounded,
              shape: BoxShape.rectangle,
              onTap: () {},
            ),
            CustomIconButton(
              buttonSize: 45,
              icon: Icons.refresh_rounded,
              shape: BoxShape.rectangle,
              onTap: () async => await ref.read(itemVMProvider.notifier).get(),
            ),
            CustomButton(
              width: 80,
              height: 45,
              text: "+ Add",
              onTap: () => showDialog(context: context, builder: (context) => AddItemPopup()),
              buttonColor: ColorCode.colorList(context).primary,
              textColor: whiteColor,
            ),
            CustomButton(
              width: 150,
              height: 45,
              text: "⬇️ Import from excel",
              onTap: () => context.pushNamed(RouteEnum.excel.name, extra: ExcelType.items),
              buttonColor: ColorCode.colorList(context).primary,
              textColor: whiteColor,
            ),
            CustomButton(
              width: 150,
              height: 45,
              text: "⬆️ Export to excel",
              onTap: () => ExcelHelper.exportToExcel(ref.watch(itemVMProvider).value ?? []),
              buttonColor: ColorCode.colorList(context).primary,
              textColor: whiteColor,
            ),
            if (ref.watch(salePriceEditNotifier) || ref.watch(purchasePriceEditNotifier) || ref.watch(itemNameEditNotifier) || ref.watch(stockCountEditNotifier))
              Container(
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: yellowAccentColor),
                  color: yellowAccentColor.withValues(alpha: .3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: ScalingText(text: "ℹ️ Press Enter on every field \n      to save what you edited", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: appPrimary))),
              ),
          ],
        ),
        10.height,
        Container(
          height: 40,
          width: context.width() - 150,
          decoration: BoxDecoration(
            border: Border.all(color: ColorCode.colorList(context).borderColor!),
            borderRadius: BorderRadius.circular(10),
            color: ColorCode.colorList(context).borderColor!,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  "Sl.No.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
                ),
              ),
              10.width,
              VerticalDivider(color: ColorCode.colorList(context).secondary),
              ItemTableHeaders(
                  flex: 2,
                  value: "Item Name",
                  onTap: (value) {
                    qp(value);
                    ref.read(itemNameEditNotifier.notifier).state = value;
                  }),
              VerticalDivider(color: ColorCode.colorList(context).secondary),
              ItemTableHeaders(value: "Category"),
              VerticalDivider(color: ColorCode.colorList(context).secondary),
              SizedBox(
                width: 50,
                child: Text(
                  "Unit",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
                ),
              ),
              VerticalDivider(color: ColorCode.colorList(context).secondary),
              ItemTableHeaders(
                  value: "Purchase Price",
                  onTap: (value) {
                    qp(value);
                    ref.read(purchasePriceEditNotifier.notifier).state = value;
                  }),
              VerticalDivider(color: ColorCode.colorList(context).secondary),
              ItemTableHeaders(
                  value: "Sale Price",
                  onTap: (value) {
                    qp(value);
                    ref.read(salePriceEditNotifier.notifier).state = value;
                  }),
              VerticalDivider(color: ColorCode.colorList(context).secondary),
              ItemTableHeaders(
                value: "Stock In",
              ),
              // VerticalDivider(color: ColorCode.colorList(context).secondary),
              // ItemTableHeaders(
              //   value: "Stock Out",
              // ),
              VerticalDivider(color: ColorCode.colorList(context).secondary),
              ItemTableHeaders(
                value: "Stock Left",
                // onTap: (value) {
                //   qp(value);
                //   ref.read(stockCountEditNotifier.notifier).state = value;
                // },
              ),
              VerticalDivider(color: ColorCode.colorList(context).secondary),
              SizedBox(
                  width: 50,
                  child: Center(
                    child: Text(
                      "Actions",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
                    ),
                  )),
            ],
          ),
        ),
        10.height,
        ItemList(),
      ],
    );
  }
}
