import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/constants.dart';
import 'package:db_billmate/view/custom_scaffold/custom_scaffold.dart';
import 'package:db_billmate/view/customers/customers.dart';
import 'package:db_billmate/view/sales/sales.dart';
import 'package:db_billmate/view/settings/settings.dart';
import 'package:db_billmate/view/stock/stock.dart';
import 'package:db_billmate/view/suppliers/suppliers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter myRoute = GoRouter(
  initialLocation: "/",
  redirectLimit: 3,
  errorBuilder: (context, state) {
    return Scaffold(body: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [const Text('Unknown pages'), ElevatedButton(onPressed: () => context.go("/"), child: const Text("Back"))])));
  },
  navigatorKey: ConstantData.navigatorKey,
  routes: _buildRoutes(),
);

List<RouteBase> _buildRoutes() {
  return [
    GoRoute(
      path: '/',
      parentNavigatorKey: ConstantData.navigatorKey,
      pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
          },
          child: const CustomScaffold(child: Customers())),
      routes: [
        ..._staticRoutes(),
      ],
    ),
  ];
}

List<GoRoute> _staticRoutes() {
  return [
    GoRoute(
      path: RouteEnum.customers.name,
      name: RouteEnum.customers.name,
      pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
        },
        child: const CustomScaffold(child: Customers()),
      ),
    ),
    GoRoute(
      path: RouteEnum.supplier.name,
      name: RouteEnum.supplier.name,
      pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
        },
        child: const CustomScaffold(child: Suppliers()),
      ),
    ),
    GoRoute(
      path: RouteEnum.sales.name,
      name: RouteEnum.sales.name,
      pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
        },
        child: const CustomScaffold(child: Sales()),
      ),
    ),
    GoRoute(
      path: RouteEnum.stock.name,
      name: RouteEnum.stock.name,
      pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
        },
        child: const CustomScaffold(child: Stock()),
      ),
    ),
    GoRoute(
      path: RouteEnum.settings.name,
      name: RouteEnum.settings.name,
      pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
        },
        child: const CustomScaffold(child: Settings()),
      ),
    ),
  ];
}
