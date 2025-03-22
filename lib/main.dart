import 'package:db_billmate/constants/theme.dart';
import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/route/route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await LocalStorage.init(); // Initialize the database
  } catch (e) {
    qp(e);
  }
  // debugRepaintRainbowEnabled = true;

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'DB-Billmate',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.getThemeData(ThemeMode.light),
        themeMode: ThemeMode.light,
        // themeMode:
        //     ref.watch(mainVM).isLightTheme ? ThemeMode.light : ThemeMode.dark,
        darkTheme: MyTheme.getThemeData(ThemeMode.dark),
        routerConfig: myRoute,
      ),
    );
  }
}
