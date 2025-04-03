import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/customers/elements/menu_tile.dart';
import 'package:db_billmate/vm/dashboard_vm.dart';
import 'package:db_billmate/vm/supplier_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SuppliersHeader extends HookConsumerWidget {
  final TextEditingController searchController;
  final ValueNotifier<int> selected;
  const SuppliersHeader({super.key, required this.searchController, required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(1);
    final getAndGive = ref.watch(toGetAndGive);
    return Row(
      spacing: 10,
      children: [
        CustomTextField(
          width: 250,
          height: 45,
          controller: searchController,
          hintText: "Search...",
          suffix: Icon(Icons.search),
          onChanged: (p0) {
            p0.isEmpty ? ref.read(supplierVMProvider.notifier).get() : ref.read(supplierVMProvider.notifier).get(search: {"name": p0});
          },
        ),
        PopupMenuButton(
            tooltip: "Sort",
            color: whiteColor,
            constraints: BoxConstraints(maxWidth: 200),
            onSelected: (value) async {
              if (value == 1) {
                selected.value = 1;
                await ref.read(supplierVMProvider.notifier).get(orderBy: "modified");
              } else if (value == 2) {
                selected.value = 2;
                await ref.read(supplierVMProvider.notifier).get(orderBy: "modified", ascending: true);
              } else if (value == 3) {
                selected.value = 3;
                await ref.read(supplierVMProvider.notifier).get(orderBy: "name", ascending: true);
              } else if (value == 4) {
                selected.value = 4;
                await ref.read(supplierVMProvider.notifier).get(orderBy: "balance_amount", isDouble: true, ascending: true);
              } else {
                selected.value = 5;
                await ref.read(supplierVMProvider.notifier).get(orderBy: "balance_amount", isDouble: true);
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
          tooltipMsg: "Refresh",
          buttonSize: 45,
          shape: BoxShape.rectangle,
          icon: Icons.refresh,
          onTap: () async {
            selected.value = 1;
            await ref.read(supplierVMProvider.notifier).get();
          },
        ),
        Expanded(
          child: Row(
            spacing: 10,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greenColor, width: 2),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You Gave :",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹${getAndGive[4]}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 20, fontWeight: FontWeight.w900, color: greenColor),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: redColor, width: 2),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You Bought :",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹${getAndGive[5]}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 20, fontWeight: FontWeight.w900, color: redColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        0.width,
      ],
    );
  }
}
