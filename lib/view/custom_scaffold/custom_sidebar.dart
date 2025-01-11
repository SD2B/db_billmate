import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/ui_model.dart';
import 'package:db_billmate/view/custom_scaffold/sidebar_button.dart';
import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: context.height(),
      decoration: BoxDecoration(
        color: black87Color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        spacing: 20,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: whiteColor), image: DecorationImage(image: AssetImage("assets/image/db.png"))),
          ),
          Divider(),
          Column(
            spacing: 30,
            children: [
              ...sidebarButtons.map(
                (e) => SidebarButton(e: e),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<UiModel> sidebarButtons = [
  UiModel(
    title: "Accounts",
    svg: "assets/svg/accounts.svg",
    value: RouteEnum.accounts.name,
  ),
  UiModel(
    title: "Sales",
    svg: "assets/svg/sale.svg",
    value: RouteEnum.sales.name,
  ),
  UiModel(
    title: "Stock",
    svg: "assets/svg/stock.svg",
    value: RouteEnum.stock.name,
  ),
  UiModel(
    title: "Customers",
    svg: "assets/svg/customer.svg",
    value: RouteEnum.customer.name,
  ),
  UiModel(
    title: "Suppliers",
    svg: "assets/svg/supplier.svg",
    value: RouteEnum.supplier.name,
  ),
  UiModel(
    title: "Settings",
    svg: "assets/svg/settings.svg",
    value: RouteEnum.settings.name,
  ),
];
