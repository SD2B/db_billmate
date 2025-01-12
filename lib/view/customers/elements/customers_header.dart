import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/view/customers/add_customer_popup.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomersHeader extends HookConsumerWidget {
  const CustomersHeader({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: 10,
      children: [
        // Spacer(),
        CustomTextField(
          width: 200,
          height: 45,
          controller: searchController,
          hintText: "Search...",
          suffix: Icon(Icons.search),
        ),
        PopupMenuButton(
            tooltip: "Sort",
            color: whiteColor,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    enabled: false,
                    child: Text(
                      "Sort by,",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    )),
                PopupMenuItem(
                    child: Text(
                  "Date",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                      ),
                )),
                PopupMenuItem(
                    child: Text(
                  "Name",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                      ),
                )),
                PopupMenuItem(
                    child: Text(
                  "Amount (asc)",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                      ),
                )),
                PopupMenuItem(
                    child: Text(
                  "Amount (desc)",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                      ),
                )),
              ];
            },
            child: CustomIconButton(
              buttonSize: 45,
              shape: BoxShape.rectangle,
              icon: Icons.tune_rounded,
              noTap: true,
            )),

        CustomIconButton(
          buttonSize: 45,
          shape: BoxShape.rectangle,
          icon: Icons.refresh,
          onTap: () async {
            await ref.watch(customerVMProvider.notifier).get();
          },
        ),
        CustomButton(
          width: 80,
          height: 45,
          text: "+ Add",
          onTap: () {
            showDialog(context: context, builder: (context) => AddCustomerPopup(onSaved: (model) async => await ref.read(customerVMProvider.notifier).save(model)));
          },
          buttonColor: ColorCode.colorList(context).primary,
          textColor: whiteColor,
        ),
      ],
    );
  }
}
