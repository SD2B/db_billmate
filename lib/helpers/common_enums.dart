enum RouteEnum {
  home,
  sales,
  stock,
  customers,
  supplier,
  settings,
  excel,
}

extension RouteEnumExtension on RouteEnum {
  String get asString {
    switch (this) {
      case RouteEnum.home:
        return 'Dashboard';
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
      case RouteEnum.excel:
        return 'Excel';
    }
  }
}

String nameFromRoute(String route) {
  for (var value in RouteEnum.values) {
    if (value.name == route) {
      return value.asString;
    }
  }
  return "";
}
