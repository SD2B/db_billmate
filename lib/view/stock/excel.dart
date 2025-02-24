import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/sd_toast.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/file_picker_helper.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/vm/item_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

class ExcelScreen extends HookConsumerWidget {
  const ExcelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = useState<List<ItemModel>>([]);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text("Import From Excel"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 20, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomButton(
                width: 80,
                height: 45,
                buttonColor: blackColor,
                textColor: whiteColor,
                text: "Import",
                onTap: () async {
                  itemList.value = await FilePickerHelper.importExcel();
                },
              ),
              20.height,
              if (itemList.value.isNotEmpty) ...itemList.value.map((e) => Text(e.toString())),
              20.height,
              CustomButton(
                width: 80,
                height: 45,
                buttonColor: blackColor,
                textColor: whiteColor,
                text: "Save items",
                onTap: () async {
                  bool res = await ref.read(itemVMProvider.notifier).multiSave(itemList.value);
                  if (res) {
                    SDToast.showToast(context, description: "Successfully added these items", type: ToastificationType.success);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
