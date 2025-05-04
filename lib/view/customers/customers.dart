import 'package:db_billmate/common_widgets/loading_widget.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/view/customers/elements/customer_list.dart';
import 'package:db_billmate/view/customers/elements/customer_transactions.dart';
import 'package:db_billmate/view/customers/elements/customers_header.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class Customers extends HookConsumerWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final customerModel = useState<EndUserModel>(EndUserModel());
    final customerList = useState<List<EndUserModel>>([]);
    final selected = useState(1);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomersHeader(searchController: searchController, selected: selected),
        // Text("No.of customers: ${customerList.value.length}"),
        20.height,
        ref.watch(customerVMProvider).when(
              data: (dataList) {
                if (searchController.text.isEmpty) {
                  customerList.value = [
                    ...dataList.where((newCustomer) => customerList.value.any((existingCustomer) => existingCustomer.id == newCustomer.id && existingCustomer != newCustomer)),
                    ...customerList.value.where((e) => !dataList.any((newCustomer) => newCustomer.id == e.id && newCustomer != e)),
                    ...dataList.where((newCustomer) => !customerList.value.any((existingCustomer) => existingCustomer.id == newCustomer.id)),
                  ];
                } else {
                  customerList.value = [...dataList];
                }
                return Expanded(
                  child: Row(
                    spacing: 20,
                    children: [
                      CustomerList(customerList: customerList.value, customerModel: customerModel),
                      VerticalDivider(color: ColorCode.colorList(context).borderColor),
                      if (customerModel.value == EndUserModel())
                        Expanded(
                            child: Center(
                                child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LottieBuilder.asset("assets/lottie/click.json"),
                            Text("Select a customer"),
                          ],
                        ))),
                      if (customerModel.value != EndUserModel()) CustomerTransactions(selected: selected),
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
