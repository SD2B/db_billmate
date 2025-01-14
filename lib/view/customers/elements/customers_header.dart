import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/view/customers/add_customer_popup.dart';
import 'package:db_billmate/view/customers/elements/menu_tile.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomersHeader extends HookConsumerWidget {
  final TextEditingController searchController;
  final ValueNotifier<int> selected;
  const CustomersHeader({super.key, required this.searchController, required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(1);
    return Row(
      spacing: 10,
      children: [
        CustomTextField(
          width: 200,
          height: 45,
          controller: searchController,
          hintText: "Search...",
          suffix: Icon(Icons.search),
        ),
        // ElevatedButton(
        //   onPressed: () async {
        //     // await ref.read(customerVMProvider.notifier).createAndSaveCustomers();
        //     String dd = "11232.2423523523";
        //     final ss = double.parse(dd).toStringAsFixed(2);
        //     qp(ss);
        //   },
        //   child: Text("test"),
        // ),
        PopupMenuButton(
            tooltip: "Sort",
            color: whiteColor,
            constraints: BoxConstraints(maxWidth: 200),
            onSelected: (value) async {
              if (value == 1) {
                selected.value = 1;
                await ref.read(customerVMProvider.notifier).get(orderBy: "modified");
              } else if (value == 2) {
                selected.value = 2;
                await ref.read(customerVMProvider.notifier).get(orderBy: "modified", ascending: true);
              } else if (value == 3) {
                selected.value = 3;
                await ref.read(customerVMProvider.notifier).get(orderBy: "name", ascending: true);
              } else if (value == 4) {
                selected.value = 4;
                await ref.read(customerVMProvider.notifier).get(orderBy: "balance_amount", isDouble: true, ascending: true);
              } else {
                selected.value = 5;
                await ref.read(customerVMProvider.notifier).get(orderBy: "balance_amount", isDouble: true);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(enabled: false, child: Text("Sort by,", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w600))),
                MenuTile(value: 1, title: "Latest", selected: selected.value == 1),
                MenuTile(value: 2, title: "Oldest", selected: selected.value == 2),
                MenuTile(value: 3, title: "Name (A-Z)", selected: selected.value == 3),
                MenuTile(value: 4, title: "Lowest Amount", selected: selected.value == 4),
                MenuTile(value: 5, title: "Highest Amount", selected: selected.value == 5),
              ];
            },
            child: CustomIconButton(buttonSize: 45, shape: BoxShape.rectangle, icon: Icons.tune_rounded, noTap: true)),
        CustomIconButton(
          buttonSize: 45,
          shape: BoxShape.rectangle,
          icon: Icons.refresh,
          onTap: () async {
            selected.value = 1;
            await ref.watch(customerVMProvider.notifier).get();
          },
        ),
        CustomButton(
          width: 80,
          height: 45,
          text: "+ Add",
          onTap: () => showDialog(context: context, builder: (context) => AddCustomerPopup( onSaved: (model) async => await ref.read(customerVMProvider.notifier).save(model))),
          buttonColor: ColorCode.colorList(context).primary,
          textColor: whiteColor,
        ),
      ],
    );
  }
}
