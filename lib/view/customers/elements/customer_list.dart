import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/visibility_wrapper.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/view/customers/add_customer_popup.dart';
import 'package:db_billmate/view/customers/elements/customer_list_tile.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerList extends HookConsumerWidget {
  final List<EndUserModel> customerList;
  final ValueNotifier<EndUserModel> customerModel;

  const CustomerList({super.key, required this.customerList, required this.customerModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int pageIndex = ref.watch(customerPageIndex);
    return Stack(
      children: [
        SizedBox(
          width: 400,
          child: ListView.builder(
            itemCount: customerList.length,
            itemBuilder: (context, index) {
              EndUserModel model = customerList[index];
              return SDVisibilityChecker(
                  onVisibilityChanged: (isVisible) async {
                    if (isVisible) {
                      final index = customerList.indexOf(model);
                      if (index == (customerList.length - 5)) {
                        ref.read(customerPageIndex.notifier).state = pageIndex + 1;
                        await ref.read(customerVMProvider.notifier).get(pageIndex: pageIndex, noLoad: true);
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: (customerList.length == index + 1) ? 100 : 0),
                    child: CustomerListTile(customerModel: customerModel, model: model),
                  ));
            },
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: CustomIconButton(
              tooltipMsg: "Add customer",
              shape: BoxShape.circle,
              buttonSize: 60,
              buttonColor: appPrimary,
              iconColor: whiteColor,
              iconSize: 30,
              icon: Icons.add,
              onTap: () => showDialog(context: context, builder: (context) => AddCustomerPopup()),
            ))
      ],
    );
  }
}
