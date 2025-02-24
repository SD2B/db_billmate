import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/stock/item_table_headers.dart';
import 'package:flutter/material.dart';

class BillItemsHeader extends StatelessWidget {
  const BillItemsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: context.width() - 150,
      decoration: BoxDecoration(
        border: Border.all(color: ColorCode.colorList(context).borderColor!),
        borderRadius: BorderRadius.circular(10),
        color: ColorCode.colorList(context).borderColor!,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              "Sl.No.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
            ),
          ),
          10.width,
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(flex: 2, value: "Item Name"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "QTY"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          // ItemTableHeaders(flex: 0, value: "Unit"),
          SizedBox(
            width: 30,
            child: Text(
              "Unit",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
            ),
          ),

          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "Unit Price"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "Total Price"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          SizedBox(
              width: 100,
              child: Center(
                child: Text(
                  "Edit / Delete",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
                ),
              )),
        ],
      ),
    );
  }
}
