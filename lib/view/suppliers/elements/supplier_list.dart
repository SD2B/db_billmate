import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/visibility_wrapper.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/view/suppliers/add_supplier_popup.dart';
import 'package:db_billmate/view/suppliers/elements/supplier_list_tile.dart';
import 'package:db_billmate/vm/supplier_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SupplierList extends HookConsumerWidget {
  final List<EndUserModel> supplierList;
  final ValueNotifier<EndUserModel> supplierModel;

  const SupplierList({super.key, required this.supplierList, required this.supplierModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int pageIndex = ref.watch(supplierPageIndex);
    return Stack(
      children: [
        SizedBox(
          width: 400,
          child: ListView.builder(
            itemCount: supplierList.length,
            itemBuilder: (context, index) {
              EndUserModel model = supplierList[index];
              return SDVisibilityChecker(
                  onVisibilityChanged: (isVisible) async {
                    if (isVisible) {
                      final index = supplierList.indexOf(model);
                      if (supplierList.length >= 30 && index == (supplierList.length - 5)) {
                        ref.read(supplierPageIndex.notifier).state = pageIndex + 1;
                        await ref.read(supplierVMProvider.notifier).get(pageIndex: pageIndex, noLoad: true);
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: (supplierList.length == index + 1) ? 100 : 0),
                    child: SupplierListTile(supplierModel: supplierModel, model: model),
                  ));
            },
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: CustomIconButton(
              tooltipMsg: "Add Supplier",
              shape: BoxShape.circle,
              buttonSize: 60,
              buttonColor: appPrimary,
              iconColor: whiteColor,
              iconSize: 30,
              icon: Icons.add,
              onTap: () => showDialog(context: context, builder: (context) => AddSupplierPopup()),
            ))
      ],
    );
  }
}
