import 'package:db_billmate/view/customers/elements/add_customer_transactions.dart';
import 'package:db_billmate/view/customers/elements/customer_transaction_header.dart';
import 'package:db_billmate/view/customers/elements/customer_transaction_list.dart';
import 'package:db_billmate/view/customers/elements/customer_transaction_table_header.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerTransactions extends HookConsumerWidget {
  final ValueNotifier<int> selected;
  const CustomerTransactions({super.key,  required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CustomerTransactionHeader(),
        CustomerTransactionTableHeader(),
        CustomerTransactionList(),
        AddCustomerTransactions(selected: selected),
      ],
    );
  }
}
