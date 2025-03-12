
import 'package:db_billmate/view/suppliers/elements/add_supplier_transactions.dart';
import 'package:db_billmate/view/suppliers/elements/supplier_transaction_header.dart';
import 'package:db_billmate/view/suppliers/elements/supplier_transaction_list.dart';
import 'package:db_billmate/view/suppliers/elements/supplier_transaction_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SupplierTransactions extends HookWidget {
  final ValueNotifier<int> selected;
  const SupplierTransactions({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SupplierTransactionHeader(),
        SupplierTransactionTableHeader(),
        SupplierTransactionList(),
        AddSupplierTransactions(selected: selected),
      ],
    );
  }
}
