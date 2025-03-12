import 'package:db_billmate/common_widgets/loading_widget.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/view/suppliers/elements/supplier_list.dart';

import 'package:db_billmate/view/suppliers/elements/supplier_transactions.dart';
import 'package:db_billmate/view/suppliers/elements/suppliers_header.dart';
import 'package:db_billmate/vm/supplier_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class Suppliers extends HookConsumerWidget {
  const Suppliers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final supplierModel = useState<EndUserModel>(EndUserModel());
    final supplierList = useState<List<EndUserModel>>([]);
    final selected = useState(1);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SuppliersHeader(searchController: searchController, selected: selected),
        20.height,
        ref.watch(supplierVMProvider).when(
              data: (dataList) {
                if (searchController.text.isEmpty) {
                  supplierList.value = [
                    ...supplierList.value,
                    ...dataList.where((newSupplier) => !supplierList.value.any((existingSupplier) => existingSupplier.id == newSupplier.id)),
                  ];
                } else {
                  supplierList.value = [...dataList];
                }
                return Expanded(
                  child: Row(
                    spacing: 20,
                    children: [
                      SupplierList(supplierList: supplierList.value, supplierModel: supplierModel),
                      VerticalDivider(color: ColorCode.colorList(context).borderColor),
                      if (supplierModel.value == EndUserModel())
                        Expanded(
                            child: Center(
                                child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LottieBuilder.asset("assets/lottie/click.json"),
                            Text("Select a supplier"),
                          ],
                        ))),
                      if (supplierModel.value != EndUserModel()) SupplierTransactions( selected: selected),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => SizedBox(height: context.height() - 300, width: context.width() - 200, child: LoadingWidget()),
            )
      ],
    );
  }
}
