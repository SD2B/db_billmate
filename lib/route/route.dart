import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/constants.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/login_model.dart';
import 'package:db_billmate/view/custom_scaffold/custom_scaffold.dart';
import 'package:db_billmate/view/customers/customers.dart';
import 'package:db_billmate/view/home/home.dart';
import 'package:db_billmate/view/login/login.dart';
import 'package:db_billmate/view/profile/profile.dart';
import 'package:db_billmate/view/sales/sales.dart';
import 'package:db_billmate/view/sales/sales_report/sales_report.dart';
import 'package:db_billmate/view/settings/settings.dart';
import 'package:db_billmate/view/stock/excel.dart';
import 'package:db_billmate/view/stock/stock.dart';
import 'package:db_billmate/view/suppliers/suppliers.dart';
import 'package:db_billmate/vm/repositories/login_repo.dart';
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
              child: FutureBuilder<bool>(
                future: isLoggedIn(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData || !snapshot.data!) {
                    return const Login();
                  } else {
                    return const CustomScaffold(child: Home());
                  }
                },
              ),
            ),
        routes: [..._staticRoutes()]),
  ];
}

Future<bool> isLoggedIn() async {
  LoginModel model = await LoginRepo.get();
  return model.isLoggedIn;
}

List<GoRoute> _staticRoutes() {
  return [
    GoRoute(
      path: RouteEnum.login.name,
      name: RouteEnum.login.name,
      pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
        },
        child: const Login(),
      ),
    ),
    GoRoute(
        path: RouteEnum.scaffold.name,
        name: RouteEnum.scaffold.name,
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
              key: state.pageKey,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
              },
              child: const CustomScaffold(child: Home()),
            ),
        routes: [...scaffoldRoutes]),
    // GoRoute(
    //   path: RouteEnum.profile.name,
    //   name: RouteEnum.profile.name,
    //   pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
    //     },
    //     child: const CustomScaffold(child: Profile()),
    //   ),
    // ),
    // GoRoute(
    //   path: RouteEnum.home.name,
    //   name: RouteEnum.home.name,
    //   pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
    //     },
    //     child: const CustomScaffold(child: Home()),
    //   ),
    // ),
    // GoRoute(
    //   path: RouteEnum.customers.name,
    //   name: RouteEnum.customers.name,
    //   pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
    //     },
    //     child: const CustomScaffold(child: Customers()),
    //   ),
    // ),
    // GoRoute(
    //   path: RouteEnum.supplier.name,
    //   name: RouteEnum.supplier.name,
    //   pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
    //     },
    //     child: const CustomScaffold(child: Suppliers()),
    //   ),
    // ),
    // GoRoute(
    //   path: RouteEnum.sales.name,
    //   name: RouteEnum.sales.name,
    //   pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
    //     },
    //     child: const CustomScaffold(child: Sales()),
    //   ),
    // ),
    // GoRoute(
    //   path: RouteEnum.salesReport.name,
    //   name: RouteEnum.salesReport.name,
    //   pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
    //     },
    //     child: const CustomScaffold(child: SalesReport()),
    //   ),
    // ),
    // GoRoute(
    //   path: RouteEnum.stock.name,
    //   name: RouteEnum.stock.name,
    //   pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
    //     },
    //     child: const CustomScaffold(child: Stock()),
    //   ),
    // ),
    // GoRoute(
    //   path: RouteEnum.settings.name,
    //   name: RouteEnum.settings.name,
    //   pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
    //     },
    //     child: const CustomScaffold(child: Settings()),
    //   ),
    // ),
    // GoRoute(
    //   path: RouteEnum.excel.name,
    //   name: RouteEnum.excel.name,
    //   pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
    //     },
    //     child: const ExcelScreen(),
    //   ),
    // ),
  ];
}

List<GoRoute> scaffoldRoutes = [
  GoRoute(
    path: RouteEnum.profile.name,
    name: RouteEnum.profile.name,
    parentNavigatorKey: ConstantData.navigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(child: CustomScaffold(child: const Profile())),
  ),
  GoRoute(
    path: RouteEnum.home.name,
    name: RouteEnum.home.name,
    parentNavigatorKey: ConstantData.navigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(child: CustomScaffold(child: const Home())),
  ),
  GoRoute(
    path: RouteEnum.customers.name,
    name: RouteEnum.customers.name,
    parentNavigatorKey: ConstantData.navigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(child: CustomScaffold(child: const Customers())),
  ),
  GoRoute(
    path: RouteEnum.supplier.name,
    name: RouteEnum.supplier.name,
    parentNavigatorKey: ConstantData.navigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(child: CustomScaffold(child: const Suppliers())),
  ),
  GoRoute(
    path: RouteEnum.sales.name,
    name: RouteEnum.sales.name,
    parentNavigatorKey: ConstantData.navigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(child: CustomScaffold(child: const Sales())),
  ),
  GoRoute(
    path: RouteEnum.salesReport.name,
    name: RouteEnum.salesReport.name,
    parentNavigatorKey: ConstantData.navigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(child: CustomScaffold(child: const SalesReport())),
  ),
  GoRoute(
    path: RouteEnum.stock.name,
    name: RouteEnum.stock.name,
    parentNavigatorKey: ConstantData.navigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(child: CustomScaffold(child: const Stock())),
  ),
  GoRoute(
    path: RouteEnum.settings.name,
    name: RouteEnum.settings.name,
    parentNavigatorKey: ConstantData.navigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(child: CustomScaffold(child: const Settings())),
  ),
  GoRoute(
    path: RouteEnum.excel.name,
    name: RouteEnum.excel.name,
    parentNavigatorKey: ConstantData.navigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(child: const ExcelScreen()),
  ),
];
