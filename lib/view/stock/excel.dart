import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/sd_toast.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/file_picker_helper.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

class ExcelScreen extends HookConsumerWidget {
  final String excelType;
  const ExcelScreen({super.key, required this.excelType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final excelData = useState<List<dynamic>>([]);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text("Import From Excel  $excelType"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 30,
              children: [
                CustomButton(
                  width: 80,
                  height: 45,
                  buttonColor: blackColor,
                  textColor: whiteColor,
                  text: "Import",
                  onTap: () async {
                    final data = await FilePickerHelper.importExcel(excelType: excelType);
                    if (excelType == ExcelType.items && data is List<ItemModel>) {
                      excelData.value = data;
                    } else if (excelType == ExcelType.customers && data is List<EndUserModel>) {
                      excelData.value = data;
                    } else {
                      SDToast.showToast(description: "Invalid data in Excel", type: ToastificationType.error);
                    }
                  },
                ),
                CustomButton(
                  width: 80,
                  height: 45,
                  buttonColor: blackColor,
                  textColor: whiteColor,
                  text: "Save items",
                  onTap: () async {
                    if (excelType == ExcelType.items) {
                      List<ItemModel> data = excelData.value as List<ItemModel>;
                      bool res = await ref.read(itemVMProvider.notifier).multiSave(data);
                      if (res) {
                        SDToast.showToast(description: "Successfully added these items", type: ToastificationType.success);
                      }
                    } else {
                      List<EndUserModel> data = excelData.value as List<EndUserModel>;
                      bool res = await ref.read(customerVMProvider.notifier).multiSave(data);
                      if (res) {
                        SDToast.showToast(description: "Successfully added these customers", type: ToastificationType.success);
                      }
                    }
                  },
                ),
              ],
            ),
            20.height,
            if (excelData.value.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: excelData.value.length,
                  itemBuilder: (context, index) {
                    if (excelType == ExcelType.items) {
                      final model = excelData.value[index] as ItemModel;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: appSecondary))), width: 200, child: Text(model.name.toString())),
                            Text("₹${model.salePrice}"),
                          ],
                        ),
                      );
                    } else {
                      final model = excelData.value[index] as EndUserModel;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: appSecondary))), width: 200, child: Text(model.name.toString())),
                            Text("₹${model.balanceAmount}"),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            20.height,
          ],
        ),
      ),
    );
  }
}

class ExcelType {
  static const String customers = "customers";
  static const String items = "items";
}
