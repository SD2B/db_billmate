import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/view/customers/elements/customer_list.dart';
import 'package:db_billmate/view/customers/elements/customer_transactions.dart';
import 'package:db_billmate/view/customers/elements/customers_header.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Customers extends HookConsumerWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final customerModel = useState<CustomerModel>(CustomerModel());
    final customerList = useState<List<CustomerModel>>([]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomersHeader(searchController: searchController),
        20.height,
        ref.watch(customerVMProvider).when(
            data: (dataList) {
              customerList.value = dataList;
              return Expanded(
                child: Row(
                  spacing: 20,
                  children: [
                    CustomerList(customerList: customerList.value, customerModel: customerModel),
                    VerticalDivider(color: ColorCode.colorList(context).borderColor),
                    if (customerModel.value == CustomerModel()) Expanded(child: Center(child: Text("Select a customer"))),
                    if (customerModel.value != CustomerModel()) CustomerTransactions(customerModel: customerModel),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => CircularProgressIndicator.adaptive())
      ],
    );
  }
}
