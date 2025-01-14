enum RouteEnum {
  home,
  sales,
  stock,
  customers,
  supplier,
  settings,
}

extension RouteEnumExtension on RouteEnum {
  String get asString {
    switch (this) {
      case RouteEnum.home:
        return 'Home';
      case RouteEnum.sales:
        return 'Sales';
      case RouteEnum.stock:
        return 'Stock';
      case RouteEnum.customers:
        return 'Customer Management';
      case RouteEnum.supplier:
        return 'Supplier Management';
      case RouteEnum.settings:
        return 'Settings';
    }
  }
}
