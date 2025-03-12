import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/models/ui_model.dart';
import 'package:db_billmate/view/custom_scaffold/sidebar_button.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/supplier_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: whiteColor),
            ),
            padding: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Image.asset("assets/image/db.png"),
            ),
          ).onTap(() {
            context.goNamed(RouteEnum.profile.name);
          }),
          Divider(),
          Column(
            spacing: 20,
            children: [
              ...sidebarButtons.map(
                (e) => Tooltip(message: e.title, child: SidebarButton(e: e)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<UiModel> sidebarButtons = [
  UiModel(title: "Dashboard", svg: "assets/svg/home.svg", value: RouteEnum.home.name),
  UiModel(
      title: "Customers",
      svg: "assets/svg/customer.svg",
      value: RouteEnum.customers.name,
      onTap: (WidgetRef ref) {
        ref.read(tempCustomerProvider.notifier).state = EndUserModel();
        ref.read(tempSupplierProvider.notifier).state = EndUserModel();
      }),
  UiModel(title: "Sales", svg: "assets/svg/sale.svg", value: RouteEnum.sales.name),
  UiModel(title: "Sales Report", svg: "assets/svg/inv_report.svg", value: RouteEnum.salesReport.name, onTap: (WidgetRef ref) {}),
  UiModel(title: "Stock", svg: "assets/svg/stock.svg", value: RouteEnum.stock.name),
  UiModel(
      title: "Suppliers",
      svg: "assets/svg/supplier.svg",
      value: RouteEnum.supplier.name,
      onTap: (WidgetRef ref) {
        ref.read(tempCustomerProvider.notifier).state = EndUserModel();
        ref.read(tempSupplierProvider.notifier).state = EndUserModel();
      }),
  UiModel(title: "Settings", svg: "assets/svg/settings.svg", value: RouteEnum.settings.name),
];
