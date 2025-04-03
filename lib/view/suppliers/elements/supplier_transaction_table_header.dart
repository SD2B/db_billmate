import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SupplierTransactionTableHeader extends HookWidget {
  const SupplierTransactionTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() - 610,
      height: 30,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorCode.colorList(context).borderColor!,
      ),
      child: Row(
        children: [
          Expanded(child: Center(child: Text("Date & Time"))),
          VerticalDivider(),
          Expanded(child: Center(child: Text("You Gave"))),
          VerticalDivider(),
          Expanded(child: Center(child: Text("You Bought"))),
        ],
      ),
    );
  }
}
