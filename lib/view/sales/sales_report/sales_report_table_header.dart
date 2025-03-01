import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/view/stock/item_table_headers.dart';
import 'package:flutter/material.dart';

class SalesReportTableHeader extends StatelessWidget {
  const SalesReportTableHeader({
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ColorCode.colorList(context).primary),
            ),
          ),
          10.width,
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(flex: 2, value: "Name"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "Inv No."),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "Bill Total"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "Old Balance"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "GrandTotal"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "Discount"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "Recieved"),
          VerticalDivider(color: ColorCode.colorList(context).secondary),
          ItemTableHeaders(value: "Current Balance"),
        ],
      ),
    );
  }
}
